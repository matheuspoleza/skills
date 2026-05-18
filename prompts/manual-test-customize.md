# Manual Test Customize

Paste when the default `templates/manual-test.md` shape doesn't fit (e.g., CLI feature, background job, API-only, complex multi-user flow).

---

```
Write a manual test guide for `docs/{feature}/milestones/{milestone-id}.md`. The standard template at `templates/manual-test.md` doesn't fit because: {reason — e.g., this is a background worker with no UI / this is a CLI / this needs two users in parallel}.

Adapt the shape:
- **Setup** — what processes, accounts, fixtures, env vars
- **Flows** — replace UI steps with: {CLI invocations | curl commands | job triggers | whatever fits}
- **What to look for** — define what success looks like for this surface (log lines? DB state? exit codes? side effects?)
- **What to break deliberately** — list edge cases worth probing on THIS surface

Save to `docs/{feature}/reviews/manual-test-{milestone-id}.md` and show me the file. I'll walk it before giving feedback.
```

---

## Why this shape

The default manual test guide assumes a web UI. Many surfaces aren't web UIs. This prompt tells the agent to adapt the template instead of forcing a square peg.

Calling out *why* the default doesn't fit forces the agent to actually produce something appropriate instead of mechanically swapping field names.
