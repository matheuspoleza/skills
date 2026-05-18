# Escalation — Stop, Log, or Proceed

When you hit something unexpected, pick one of three responses. Don't improvise.

## The Three Responses

### Stop-and-ask
Pause work and ask the user. Use when:
- The task is ambiguous between two real interpretations and you'd build the wrong thing
- A decision changes scope (adds a new endpoint, new model, new page)
- A discovered constraint contradicts the PRD or tech design
- Production data could be affected

State the situation, your two options, your recommendation, and wait.

### Log-and-skip
Write to `tmp/scope-skipped.md` (or the milestone file's Issues section if inside `/build`) and continue with the current task. Use when:
- You found an unrelated issue
- A nice-to-have refactor would slow this task
- A flaky test failed in code you didn't touch
- The pattern matches `rules/scope-first.md` creep

### Proceed-with-note
Make the call, leave a note in the doc you're writing. Use when:
- A tiny decision is obvious given the constraints (one trivial option)
- A naming or formatting choice doesn't change behavior
- The decision is reversible in seconds

State what you decided and why in one line. The user objects if needed.

## Decision Table

| Situation | Response |
|---|---|
| Two plausible interpretations of a requirement | Stop-and-ask |
| New endpoint needed to satisfy this task | Stop-and-ask |
| Unrelated bug spotted in adjacent file | Log-and-skip |
| Flaky test in untouched code | Log-and-skip |
| Variable name choice | Proceed-with-note |
| Whether to use `useMemo` here | Proceed-with-note |
| The fix needs a 3-day migration | Stop-and-ask |
| The fix needs a 5-minute helper | Proceed-with-note |

## Why

Interviews grade decision-making, not stoicism. Stopping for a real ambiguity is a feature; stopping for a typo wastes the clock. Picking the right response is the craft.
