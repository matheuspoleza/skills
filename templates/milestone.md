---
feature: {slug}
milestone: {milestone-id}
status: planned | in-progress | built | reviewed
updated: {YYYY-MM-DD}
---

# Milestone {n} — {one-line goal}

This milestone ships an **independently verifiable vertical slice**: {what the user sees once this lands}.

---

## Tasks

- [ ] **task-001: {name}** — {one-line what}

  **Given/When/Then:**
  - Given {state}, When {action}, Then {observable outcome}
  - Given {state}, When {action}, Then {observable outcome}

  **Review Contract** (filled by `/build`):
  - Test command: `{command}`
  - Endpoints: `{method} {path}` → `{expected}`
  - Visual routes: `{path}` → `{screenshot path}`
  - Edge cases verified: {list}
  - Known gaps: {list}

- [ ] **task-002: {name}** — {one-line what}

  **Given/When/Then:** ...

  **Review Contract:** ...

---

## Issues

Block reasons, logged scope-skipped items, anything that came up during build that needs surfacing.

- {issue} — {disposition: blocked / skipped / open question}

---

## Self-Review Summary

Filled by `/build-batch` or `/review` Phase 1.

- Verdict: passed | passed-with-notes | failed
- Evidence: `reviews/{milestone-id}.md`
- Fix bullets appended above with `polish-` prefix if applicable
