---
feature: {slug}
phase: review
milestone: {milestone-id}
updated: {YYYY-MM-DD}
---

# Review — {milestone-id}

**Phase 1 verdict:** passed | passed-with-notes | failed
**Phase 2 verdict:** complete | open | n/a

---

## Phase 1 — Agentic QA

### Tests

```bash
{test command run}
```

**Result:** {passed | failed — exact output if failed}

### Endpoints

| Endpoint | Method | Result | Notes |
|---|---|---|---|
| {/path} | {method} | ✓ / ✗ | {response notes} |

### Visual Routes

| Route | Result | Screenshot | Notes |
|---|---|---|---|
| {/path} | ✓ / ✗ | reviews/screenshots/{name}.png | {what was checked} |

### Edge Cases

| Case | Result | Notes |
|---|---|---|
| {case} | ✓ / ✗ | {notes} |

### Failures
{none | list each failure with exact output}

### Notes
{cosmetic / copy / naming observations — NOT promoted to fix tasks here}

---

## Phase 2 — Human Findings

Manual test guide: `reviews/manual-test-{milestone-id}.md`
Feedback channel: agentation | verbal

### Observations

| # | Observation | Classification | Action |
|---|---|---|---|
| 1 | {what the user found} | fix-task / escalation / non-issue | {task path or "logged"} |

### Escalations
- {finding} — {reason it exceeds polish scope}

---

## Fix Tasks Created
- [ ] `tasks/polish-{id}-{name}.md` — {what needs fixing}

---

## Verdict
{passed: ready for PR — see `reviews/{milestone-id}-pr.md` | failed: build must fix before review closes}
