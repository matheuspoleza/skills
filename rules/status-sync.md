# Status Sync — Three Places, One Truth

Every task status transition during `/build` updates **three** places at the same time. Treat as atomic. If any one is out of sync, the user has lost visibility.

## The Three Places

1. **Claude TaskUpdate** — the in-conversation task list
2. **Milestone file** — `docs/{feature}/milestones/milestone-{n}.md` → the task's `- [ ]` / `- [x]` checkbox and inline status note
3. **`.context/todos.md`** — the worktree-level checklist Conductor reads

## Transition Table

| Transition | TaskUpdate | Milestone file | .context/todos.md |
|---|---|---|---|
| Start | `in_progress` | `- [ ] task-{id}: {name} (in progress)` | `- [ ] task-{id}: {name} (in progress)` |
| Done | `completed` | `- [x] task-{id}: {name}` + Review Contract sub-section filled | `- [x] task-{id}: {name}` |
| Blocked | keep `in_progress` + describe block | `- [ ] task-{id}: {name} (blocked: {reason})` + add to milestone's Issues section | `- [ ] task-{id}: {name} (blocked: {reason})` |

## Why .context/todos.md

Conductor reads this to populate the "Your todos" panel in its worktree view. Outside Conductor, it's a harmless markdown checklist. Always create and keep in sync.

## Why All Three

- TaskUpdate alone → not visible across sessions
- Milestone file alone → no live conversation visibility
- .context/todos.md alone → not visible outside Conductor

Each surface has a different reader. Skipping one breaks at least one reader's view.

## Anti-Patterns

| Anti-pattern | Cost |
|---|---|
| "I'll batch all updates at the end" | User has no live visibility — looks dead to them |
| Mark `done` before validation completes | Lies to the next session, breaks `/review` |
| Update two of three, forget the third | The forgotten reader gets stale state |
