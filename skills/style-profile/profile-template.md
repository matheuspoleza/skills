# Style profile template

Copy this shape into `~/.claude/style-profile.md`. Keep every rule concrete and testable, and back each with a real sample quote or a calibration verdict. Delete this header line in the real file.

```markdown
---
owner: {name}
updated: YYYY-MM-DD
source: slack + linear sample, interview, example calibration
---

# {name}'s writing style

Read this before generating or rewriting any prose for {name}. These rules are binding voice constraints; they override generic "natural voice" defaults.

## Voice rules (binding)

1. {rule} — e.g. "Lead with the TL;DR or the problem in plain words. No warm-up sentence."
2. {rule} — e.g. "Always concrete: real numbers, names, IDs. Never 'significant'/'a lot' when a number exists."
... one numbered rule per pattern, each one line.

## Banned

- {word/pattern the user rejects} — e.g. em dashes, "crucial/pivotal/vibrant", rule-of-three, decorative links.

## Preferred

- {word/pattern the user likes} — e.g. "so"/"because" to connect cause and effect; bullets for multi-part info.

## Worked examples

### Example 1 — {context}
**Before (rejected):** {text}
**After (approved):** {text}

### Example 2 — {context}
...
```

## Notes for the author of the profile

- Voice rules are the heart. 6-12 is plenty. More than that and humanizer can't hold them.
- Distinguish casual register (Slack chat) from written-work register (docs, PRDs, customer copy) if the user writes differently across them. Note which rules apply where.
- Every example should be one the user actually reacted to, not invented.
