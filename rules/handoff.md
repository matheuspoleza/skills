# Handoff — Cold-Read Contract

Every document the toolkit produces (PRD, milestone, review, PR description, research) must be readable by a fresh agent with **no conversation history**. If a doc references "we", "earlier", "as discussed", "the one I mentioned", it fails the contract.

## The Test

Read the doc as if you opened it for the first time, in a new session. Can you answer:

- What is this feature about? (one sentence)
- What's in scope right now? What's not?
- What's the next step? (which skill to invoke, which file to read)

If any of these is unclear, rewrite.

## Frontmatter Required

Every artifact has YAML frontmatter at the top:

```yaml
---
feature: {feature-slug}
phase: prd | build | review | done
updated: YYYY-MM-DD
---
```

This is the doc's address. It tells a fresh agent which feature this belongs to and where in the pipeline it sits.

## Banned Phrases

| Banned | Why | Fix |
|---|---|---|
| "as we discussed" | Discussion isn't in the file | Restate the decision |
| "the issue I mentioned" | The mention isn't here | Name the issue |
| "you'll know what I mean" | The reader doesn't | Spell it out |
| "TBD" without a date | Permanent loose ends | "TBD by {date}, decided by {who}" |
| "obviously" / "clearly" | Hides assumed context | Make it explicit |

## Cross-References

Reference files by **path**, not memory. `docs/auth/prd.md` is precise. "The PRD" is not.

## Why

Under interview time pressure, you will open new Claude sessions to keep contexts fresh. Every handoff that loses information costs minutes of re-grilling. Writing for cold-read is the cheapest insurance.
