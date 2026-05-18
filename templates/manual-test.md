---
feature: {slug}
milestone: {milestone-id}
updated: {YYYY-MM-DD}
---

# Manual Test Guide — {milestone-id}

## Setup
- **Running:** {api on :{port}, web on :{port}, db seeded with {what}}
- **Test accounts:**
  - {role} — {credentials}
  - {role} — {credentials}
- **Preconditions:** {anything to set up by hand}

## Flows

| # | Flow | Steps | What to look for | Edge cases worth probing |
|---|---|---|---|---|
| 1 | {flow name} | 1. {step}<br>2. {step}<br>3. {step} | {expected outcomes} | {edge cases} |

## Notes from Phase 1 to pay attention to
- {observation from review report's notes section}
- {observation}

## What to deliberately try to break
- Two tabs / concurrency
- Back / forward / refresh mid-flow
- Network throttling (devtools)
- Empty / max-length / special-char inputs
- Permission boundaries (wrong role, expired session)

## How to deliver feedback
- **Agentation available:** annotate elements directly in the running app
- **Otherwise:** describe observations one at a time
