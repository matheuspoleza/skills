---
bug: {slug}
phase: debug
opened: YYYY-MM-DD
status: {open | fixed}
---

# Bug — {slug}

## Symptom

{One line: what the user sees go wrong.}

## Steps to Reproduce

1. {step}
2. {step}
3. {observed result vs. expected}

## Evidence

- `tmp/debug/{slug}.log` — console + network + server output captured during repro (cleared between cycles)
- `tmp/debug/{slug}--before.png` — screenshot before fix (UI bugs)
- `tmp/debug/{slug}--after.png` — screenshot after fix (UI bugs)

## Hypothesis

{Why this happens. One paragraph. Reference the log lines or stack frames that support it.}

## Proposed Fixes

1. **{Option A}** — {approach}. Tradeoffs: {scope, risk, root-cause vs. workaround}.
2. **{Option B}** — {approach}. Tradeoffs: ...
3. **{Option C}** — {approach}. Tradeoffs: ...

## Chosen Fix

**{Option title}** — {why it was picked over the alternatives}.

## Validation

- Re-ran repro after fix with cleared log: {pass | fail}
- {notes — what changed in the log/screenshot}

## Regression Test

- File: `{path}`
- Asserts: {what behavior the test pins so this can't regress}

## Adjacent Cleanup (deferred)

- {anything noticed during the fix that is out of scope — keep, don't act}
