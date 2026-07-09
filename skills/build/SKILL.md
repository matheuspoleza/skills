---
name: build
description: Implement a milestone's tasks one at a time using BDD then TDD, with live progress tracked in three places and a Review Contract filled per task. Use when ready to implement, given a milestone path, or asked to "build the next milestone" or "start implementing".
---

# Build

Implement the tasks listed in `docs/{feature}/milestones/milestone-{n}.md`. BDD → TDD → validate. Fill the Review Contract per task as you go so `/review` runs without ambiguity.

---

## Produces

- Working code with passing tests for each task
- Filled Review Contract sub-section per task inside the milestone file
- Updated checkbox state and Issues section in the milestone file

---

## Reads

1. `docs/{feature}/prd.md` — feature scope, tech design, milestone list
2. `docs/{feature}/milestones/milestone-{n}.md` — the tasks in scope (as bullets with BDD criteria below each)
3. `.app-catalog/features/{feature}.md` — pages, flows, vocabulary, gotchas (and `.app-catalog/README.md` for the wider domain/actor map)

If a task bullet has no BDD acceptance criteria, do not start coding — write them first per `rules/bdd.md`.

---

## Steps

### 1. Seed todos (required before any code)

Mirror every task bullet in the milestone into TWO places:

- **Claude TaskCreate** — one task per bullet: `subject: "task-{id}: {name}"`, `description: "Implement {what} — see milestones/milestone-{n}.md"`
- **`.context/todos.md`** at the worktree root — one checkbox per bullet in milestone order

Both populated, in order, before any code. Conductor reads `.context/todos.md`; outside Conductor it's a harmless checklist.

### 2. Implementation loop (per task, in milestone order)

Per `rules/status-sync.md`, every status transition syncs three places: TaskUpdate + the milestone file's checkbox + `.context/todos.md`. Treat as atomic.

For each task bullet:

1. Mark **in progress** (sync three)
2. Read the task bullet and its BDD criteria fully
3. Write BDD criteria if missing (`rules/bdd.md`)
4. TDD cycle per `rules/tdd.md`: one failing test → minimal code green → refactor. Never batch tests.
5. Clean-code self-check before marking done (`rules/clean-code.md`, and `rules/react.md` for any React code): no narrating comments, functions/files within the size signals, no hardcoded styles/colors where a token exists, no duplicate of an existing component, no `useEffect` that should be derived state or a remount `key`. Fix violations now — don't defer.
6. Validate end-to-end:
   - **Backend / API:** run tests, hit endpoints (curl), verify DB state, confirm typed errors
   - **Frontend / UI:** run tests, then `rules/visual-check.md` (Chrome DevTools MCP, screenshot to `tmp/visual-check/{route}--{state}.png`, read screenshot back)
7. Fill the Review Contract under the task bullet in the milestone file (test command, endpoints with expected responses, visual routes with screenshot paths, edge cases, known gaps)
8. Mark **done** (sync three) — tick the checkbox and confirm the Review Contract sub-section is complete

Then move to the next task.

### 3. Milestone done

After all task bullets are checked:

- Verify each task's Review Contract is complete
- Update the milestone file's status block at the top to `built`
- Tell the user: *"Milestone {n} is built. {k} tasks done. Run `/review {milestone-id}` next."*

---

## NOT

- Does not change scope. If a task reveals the PRD's Tech Design is wrong, stop and tell the user — they may need to revise the PRD.
- Does not skip validation. A passing test suite is necessary but not sufficient — endpoints and visuals still need to be hit.
- Does not parallelize tasks within a milestone. One task at a time, finish and validate before starting the next.
- Does not hack around blockers. If blocked: sync three to `blocked`, log in the milestone's Issues section, move to the next unblocked task.
