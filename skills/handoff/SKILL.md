---
name: handoff
description: Compact the current Claude session into a cold-readable handoff doc so a fresh session can resume with no context loss. Use when context is getting long, before switching tasks, before closing the session, or asked to "handoff", "save context", "wrap this up for next time".
---

# Handoff

Write a cold-readable resume doc. The next session opens this file and knows exactly where to pick up.

---

## Produces

`docs/{feature}/handoff.md` (or `tmp/handoff-{date}.md` if no feature context):

```markdown
---
feature: {slug}
phase: {current}
updated: YYYY-MM-DD
---

# Handoff

## State
- What's done: ...
- What's in progress: ...
- What's blocked: ...

## Decisions Made
- {decision} → {why}

## Next Step
- Skill to invoke: `/{skill} {args}`
- Files to read first: {paths}
- Open question: ...
```

Every section is required. If a section is empty, write "none" — don't omit.

---

## Steps

1. **Read the PRD and current milestone file** if they exist, to anchor in current pipeline state
2. **Summarize the session** — what was attempted, what was decided, what was deferred. Bullets, not prose.
3. **List concrete next actions** with the exact skill and args
4. **Apply `rules/handoff.md`** — no "we", "earlier", "as discussed". Restate decisions explicitly.
5. **Show the file path** and ask the user to confirm before closing

---

## NOT

- Does not commit code
- Does not summarize the conversation into prose narrative — bullets and frontmatter only
- Does not assume the next reader has any context beyond the PRD, the current milestone file, and this handoff
