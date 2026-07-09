---
name: build-batch
description: Implement a milestone autonomously inside a Conductor worktree without stop-and-ask checkpoints, strictly enforcing scope-first and logging anything out of scope. Use when running parallel Conductor lanes, asked to "build autonomously", "run this in the background", "yolo this milestone", or for low-risk batched UX/tech-debt work.
---

# Build Batch

Autonomous milestone execution. Same TDD/BDD/validation as `/build`, but no stop-and-ask checkpoints during the run. Trade interactivity for parallelism.

The autonomous twin of `/build`. Use inside a Conductor worktree where the user is busy elsewhere — small bets only.

---

## Produces

Same as `/build`: working code, filled Review Contracts under each task bullet in the milestone file, updated checkbox state, updated `.context/todos.md`.

Plus: `tmp/scope-skipped.md` with every out-of-scope item discovered during the run.

---

## Reads

Same as `/build`:
1. `docs/{feature}/prd.md` — scope and tech design
2. `docs/{feature}/milestones/milestone-{n}.md` — task bullets in scope
3. `.app-catalog/features/{feature}.md` — pages, flows, vocabulary, gotchas (and `.app-catalog/README.md` for the wider domain/actor map)

If a task bullet is missing BDD criteria, **stop and ask** — this is the one allowed escalation pre-run.

---

## Steps

### 0. Pre-flight (the only blocking checkpoint)

Before any code:
- Confirm every task bullet has BDD criteria below it
- Confirm `.context/todos.md` exists and matches the milestone bullets

If either fails, halt and ask the user. After this point, no stop-and-ask.

### 1. Loop (autonomous, scope-first)

For each task bullet in order, follow the `/build` implementation loop (`rules/status-sync.md`, `rules/tdd.md`, `rules/bdd.md`, `rules/visual-check.md`).

When anything unexpected comes up, default to **log-and-skip** per `rules/escalation.md`:
- Unrelated bug → log to `tmp/scope-skipped.md`, continue
- Adjacent refactor → log, continue
- Flaky test in untouched code → log, continue

Only stop if:
- A task cannot be completed at all (genuine block — log in milestone's Issues section, move to next task)
- Discovery contradicts the PRD's Tech Design section (cannot proceed without re-deciding)

### 2. Self-review

After every task bullet is checked, run validation per `/review` Phase 1 on yourself: tests, endpoints, visuals, edge cases. Record verdict at the bottom of the milestone file.

If self-review fails, add fix bullets at the end of the milestone file but do not implement them — those return to the human queue.

### 3. Summary

End with a PR-style summary at the bottom of the milestone file:
- What shipped
- What was logged-and-skipped (and where in `tmp/scope-skipped.md`)
- Any genuine blocks
- Self-review verdict and link to evidence

Tell the user: *"Batch done. Milestone {id}. Summary at the bottom of the milestone file; skipped items in tmp/scope-skipped.md."*

---

## NOT

- Does not run on features with unresolved PRD questions — those go through `/build` interactively
- Does not expand scope to fix adjacent issues — log-and-skip, always
- Does not skip validation — the autonomous mode means no human gates, not no gates
- Does not run on task bullets without BDD criteria
