# Kickoff Feature

Paste this at the start of a fresh session, edit the bracketed sections, and send.

---

```
I'm starting work on a feature: {one-sentence what + who}.

Context:
- Product: {name}
- This is: {new feature | modification to existing | bug fix}
- Constraints: {time / scope / tech / regulatory}
- What I already know: {brief — what you've explored, who you've talked to}
- What I want from you: {grill me through a PRD | research the area first | jump to a tech design}

Before we start, please:
1. Read `.app-catalog/catalog.json` if it exists — use its names.
2. Read `docs/{feature}/` if it exists — pick up where it left off.
3. If neither exists, ask me what's in scope before assuming.

Then run `/prd` (or `/research` if I asked for that first). One question at a time, recommend an answer for each.
```

---

## Why this shape

- **One sentence what + who** forces you to scope before talking
- **Context block** primes the agent without flooding it
- **Read these first** prevents the agent from inventing names that conflict with existing ones
- **One question at a time, recommend an answer** is the grilling contract — saying it explicitly is faster than hoping the skill mentions it
