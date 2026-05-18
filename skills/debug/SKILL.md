---
name: debug
description: Reproduce a bug, capture evidence to a cleared log, propose 2-3 fix options for the human to pick, implement, validate by re-running the repro, and add a regression test. Use when given a bug report, a Jam URL, a stack trace, asked to "debug", "fix this bug", "why is X broken", or chasing flaky behavior.
---

# Debug

Reproduce → diagnose → propose → fix → validate → guard. Never propose a fix you haven't reproduced. Never claim a fix without re-running the repro against a cleared log.

---

## Produces

`docs/bugs/{slug}.md` using `templates/bug.md`. Evidence in `tmp/debug/{slug}.log` and `tmp/debug/{slug}--{before,after}.png` (gitignored).

Pick `{slug}` as kebab-case from the symptom — e.g. `login-button-stuck-loading`.

---

## Reads

Whatever the user gives: bug report, Jam URL, error message, stack trace, screenshot. If repro details are missing, ask before doing anything else.

---

## Steps

### 1. Reproduce

Pick the channel that matches the surface, and write all output to `tmp/debug/{slug}.log`:

- **UI bug:** Chrome DevTools MCP per `rules/visual-check.md`. Capture `list_console_messages` + `list_network_requests` after the failing action; screenshot to `tmp/debug/{slug}--before.png`.
- **API/endpoint bug:** `curl` the failing request with `-i`. Append status, headers, body.
- **Backend bug:** start the dev server with `run_in_background`, trigger the bug, append the relevant stdout slice.

If you cannot reliably reproduce, stop and tell the user. You do not yet understand the bug.

### 2. Document

Write `docs/bugs/{slug}.md` from `templates/bug.md`. The reproduction steps must be precise enough that a teammate could follow them cold.

### 3. Instrument (only if needed)

If the captured logs don't explain the cause, add narrow `console.log`/server log statements at the suspected boundaries. Re-run the repro and append new evidence. Revert the instrumentation diff before the fix commit.

### 4. Propose 2-3 fix options

Draft 2-3 distinct approaches with tradeoffs (root-cause vs. workaround, blast radius, effort). Use `AskUserQuestion` so the human picks. Do not implement before the answer.

### 5. Implement

Apply the chosen fix. Keep the diff minimal — debug is not refactor. Per `rules/scope-first.md`, log adjacent-cleanup ideas to the bug doc; do not pick them up here.

### 6. Validate (with cleared log)

- Delete `tmp/debug/{slug}.log`
- Re-run the exact repro from step 1
- Inspect the fresh log + screenshot

If the bug signature is gone, mark validation `pass` in the doc and capture `--after.png`. If it persists, **loop back to step 3** with what changed appended to the doc.

### 7. Regression test

Per `rules/tdd.md` bug-fix clause: write a failing test that reproduces the bug, then confirm it passes after the fix. Reference the test path in the bug doc.

Skip only for pure visual/copy/config bugs (per `rules/tdd.md`).

---

## NOT

- Does not propose a fix before a reliable reproduction. No repro = no diagnosis.
- Does not validate by reading code. Validation = re-run the repro against a cleared log.
- Does not refactor adjacent code. Minimal change. Anything else is a separate task.
- Does not skip the regression test for behavioral bugs.
- Does not commit the temporary instrumentation from step 3.
