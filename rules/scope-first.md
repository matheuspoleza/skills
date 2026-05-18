# Scope First

Define the scope of what you're about to do **before** writing any code. When you discover work outside that scope mid-task, log it and skip — don't pull it in.

## The Loop

1. **State the scope** — one sentence: *"This task adds X. Out of scope: Y."*
2. **State how you'll know it's done** — one sentence: *"Done when {observable behavior}."*
3. **Implement only that.**
4. **Anything else gets logged** to `tmp/scope-skipped.md` (or the milestone file's Issues section if you're inside `/build`) and skipped.

If you can't state scope + done in two sentences, you don't yet understand the task. Stop and ask.

## What Counts As Creep

| Situation | Action |
|---|---|
| You see an unrelated bug | Log to `scope-skipped.md`, skip |
| The fix needs a refactor you didn't plan | Try the smallest in-scope path first; if blocked, surface to the user |
| A "while I'm here…" cleanup | Skip — it's a separate task |
| A test fails that's unrelated to your change | Log, skip, surface in summary |
| The task is ambiguous between two interpretations | Stop — `rules/escalation.md` |

## Resume Queue

Logged items in `tmp/scope-skipped.md` are the **resume queue**. After the current task is done and validated, the user decides which queue items become real tasks. Never silently merge queue items into the current change.

## Why

Scope creep destroys the only signal you have under time pressure: "is this thing working?" Every extra change adds a failure mode. One thing done well beats five things half-done.

In autonomous lanes (Conductor, `/build-batch`), this rule is the only thing standing between you and a sprawling diff. Enforce it strictly there.
