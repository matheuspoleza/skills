# Grill Personas

Paste to get adversarial review of a draft PRD or tech design from three personas at once. Edit the path, send.

---

```
Read `docs/{feature}/prd.md` and run an adversarial review as three personas in parallel. Each persona writes their concerns to a section in `docs/{feature}/persona-review.md` — don't ask me anything yet.

**UX persona** — thinks as a designer:
- Is the user flow clear?
- What states are missing (empty, error, loading)?
- What would confuse a first-time user?
- Where does the information architecture break?

**QA persona** — thinks as a quality engineer:
- What are the edge cases?
- What inputs could break this?
- What are the failure modes?
- What acceptance criteria are missing or vague?

**Tech Lead persona** — thinks as an architect:
- Is this technically feasible at the stated scope?
- What's the hidden complexity?
- What integrations or dependencies are involved?
- What could go wrong in production?

After all three sections are written, present the top 3 concerns across all personas (your pick) and ask me to triage them one at a time — fix in the PRD, defer to a follow-up, or dismiss with reasoning.
```

---

## Why this shape

Three lenses, written silently, then you triage. The agent does the synthesis you'd otherwise have to do alone under time pressure.

The "don't ask me anything yet" line is critical — without it, the agent will ping-pong between personas asking you to clarify, defeating the purpose.
