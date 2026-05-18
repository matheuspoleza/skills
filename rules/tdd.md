# TDD — Red → Green → Refactor

Strict one-behavior-at-a-time cycle. No batching tests. No production code without a failing test first.

## The Cycle

1. **Red** — Write exactly ONE failing test describing a single behavior.
2. **Green** — Write the MINIMAL code to make it pass. Green means ALL of:
   - Test passes
   - Lint is clean for changed files
   - TypeScript compiles (if applicable)
   - If any of these fail, you are NOT green. Fix before moving on.
3. **Refactor** — Clean up production and test code while keeping everything green.
4. **Repeat** — Next behavior, back to step 1.

## Rules

- Never write multiple tests before implementing.
- Never write production code without a failing test driving it.
- Each cycle handles one behavior — not a batch.
- Run the test after every change to confirm red/green state.
- Tests are the specification: if it's not tested, it doesn't exist.

## When to Bend the Rules

- **Spike / exploratory code** — when you don't yet know the shape. Throw the spike away, then TDD the real implementation.
- **Pure visual tweaks** — spacing, colors, copy. Verify in the browser instead.
- **Config / dependency / typo changes** — no behavior change, no test needed.

## Bug Fixes

1. Write a failing test that reproduces the bug (red).
2. Fix the code (green).
3. The test stays as a regression guard.

If you can't write a failing test for the bug, you don't yet understand the bug.

## Anti-Patterns

| Anti-pattern | Why bad |
|---|---|
| Writing 10 tests then implementing | Lose the feedback loop |
| Implementation first, tests after | Tests rubber-stamp code instead of specifying it |
| One test with five assertions | Failure message tells you nothing about what broke |
| Skipping the refactor step | Code rot accumulates |
| Lint/typecheck failures "I'll fix later" | Not green. Fix now. |
