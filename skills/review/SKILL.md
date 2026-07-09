---
name: review
description: Validate a completed milestone in two phases — agentic QA (run tests, hit endpoints, screenshot visuals) then human-eyes pass (manual test guide, feedback collection) — and end with a PR-ready description. Use after a milestone is built, or asked to "review", "QA this", "validate the milestone", or "polish".
---

# Review

Two-phase validation of a milestone, ending with a PR-ready description. Phase 1 is autonomous QA against the per-task Review Contracts. Phase 2 is human eyes guided by a manual test guide.

---

## Produces

- `docs/{feature}/reviews/{milestone-id}.md` — verdict, evidence, human findings
- `docs/{feature}/reviews/{milestone-id}-pr.md` — PR description ready to paste
- Fix bullets appended to the milestone file (with `polish-` prefix) if Phase 1 fails or Phase 2 surfaces issues

---

## Reads

1. `docs/{feature}/milestones/milestone-{n}.md` — each task bullet's Review Contract sub-section
2. `docs/{feature}/prd.md` — what was promised

If any task's Review Contract is incomplete, stop and ask `/build` to complete it first.

---

## Phase 1 — Agentic QA

1. **Tests** — run the Review Contract's test command(s). All must pass; on fail, record exact output and stop Phase 1.
2. **Endpoints** — run each curl command; compare actual vs expected; test the contract's error cases. Record ✓/✗ with output.
3. **Visual routes** — for each, navigate with Chrome DevTools MCP, screenshot to `docs/{feature}/reviews/screenshots/{milestone-id}-{slug}.png`, read back, verify content/layout/empty states.
4. **Edge cases** — verify each listed case.
5. **Code-quality scan** — review the milestone's diff against `rules/clean-code.md` (and `rules/react.md` for React files): narrating comments, oversized functions/files, hardcoded styles/colors where a token exists, duplicated components, misused `useEffect`. Walk the Fowler smell list in `rules/clean-code.md` and name any that fit the diff (feature envy, data clumps, primitive obsession, repeated switches, message chains, speculative generality…) — naming the smell is what turns it into an actionable fix. Record each hit with `file:line`. Clear violations become fix bullets (see verdicts); judgment calls go in notes.

Verdicts:
- **passed** — all green
- **passed-with-notes** — green but minor observations recorded (cosmetic, copy, naming); NOT promoted to fix bullets here
- **failed** — tests fail, or core endpoint/visual broken. Append fix bullets to the milestone file with `polish-` prefix and BDD criteria that would have caught the failure. Hand back to `/build`.

---

## Phase 2 — Human eyes

Only if Phase 1 verdict is `passed` or `passed-with-notes`.

1. **Write manual test guide** to `docs/{feature}/reviews/manual-test-{milestone-id}.md` using `templates/manual-test.md`. Include: setup (services, test accounts, preconditions), per-task flows with expected outcomes and edge cases worth probing, notes-to-pay-attention-to pulled from Phase 1, deliberate-break list (concurrency, back/forward, refresh mid-flow, throttled network).

2. **Pick feedback channel** per `rules/agentation.md`:
   - Agentation available → user annotates, you read annotations via MCP
   - Otherwise → verbal observations

3. **Process each observation one at a time** into the review report:
   - Classify: `fix-task` (small, in scope) / `escalation` (PRD or tech-design change) / `non-issue` (intentional, logged so it's not re-raised)
   - Fix tasks: append `polish-{id}: {name}` bullet to the milestone file with BDD criteria; if annotation-sourced, include the file path and selector
   - Escalations: log only — the human decides whether to revise the PRD

4. **Resolve annotations** in Agentation via MCP once a fix lands later in `/build`, so the user's annotation list stays clean.

---

## Phase 3 — PR description

Write `docs/{feature}/reviews/{milestone-id}-pr.md` using `templates/pr-description.md`, then run it through `/humanizer` before posting.

This is the artifact a teammate reads, so write it like a teammate explaining the change — plain English, outcome-first, short. Calibrated on two canonical PRs: [#12854](https://github.com/jamdotdev/apiofjam/pull/12854) and [#12855](https://github.com/jamdotdev/apiofjam/pull/12855). The non-negotiables (full rules in the template):

- Open with one short prose paragraph on what the change lets us do and why, framed as the capability, not the code. No `short version:` line, no bullets-first.
- Clean full sentences with normal capitalization — written work, NOT the lowercase Slack register.
- Name the user-facing command/tool, not internal functions. Keep code identifiers to a minimum.
- Testing is ONE plain sentence ("Tested end to end against real CF video: ..."). No `- [x]` checklist.
- No `##` headings, no "Notes for reviewers" section, no pre-existing-error caveats, no Before/After tables, no command-output dumps. If a dependency matters, one plain sentence pointing at the parent PR.
- No em/en dashes, no emoji, no bold inline-header bullets. Few links: ticket, parent/related PR, spec doc.

Depth (test commands, edge-case tables, code-quality findings, environment caveats) belongs in the review report (`{milestone-id}.md`), never in the PR body.

---

## NOT

- Does not modify production code — that's `/build`
- Does not invent acceptance criteria — uses what the milestone bullets already declare
- Does not escalate scope on the user's behalf — escalations are logged and decided by the human
