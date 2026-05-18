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

Write `docs/{feature}/reviews/{milestone-id}-pr.md` using `templates/pr-description.md`. This is the artifact the interviewer sees. Make it precise.

---

## NOT

- Does not modify production code — that's `/build`
- Does not invent acceptance criteria — uses what the milestone bullets already declare
- Does not escalate scope on the user's behalf — escalations are logged and decided by the human
