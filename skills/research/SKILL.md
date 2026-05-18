---
name: research
description: Survey a codebase or product surface in PM-mode and produce a research note with hot picks per dimension, without making decisions or writing code. Use when starting product discovery, exploring an unfamiliar area, asked to "research", "explore", "look around the product", or "find candidates for X".
---

# Research

Read, observe, synthesize. Produce a research note that maps the surface and surfaces candidates. The human picks; this skill recommends but does not decide.

---

## Produces

`docs/{feature}/research.md` using `templates/research.md`:

```
---
feature: {slug}
phase: research
updated: YYYY-MM-DD
---

# Research — {topic}

## What I Looked At
- Files and directories surveyed
- Pages opened (with screenshot paths if visual)

## Map
- Brief diagram or bullet tree of the area

## Hot Picks by Dimension
- One impactful feature: {candidate} — why it stood out
- Few high-impact-low-effort UX improvements: {candidate}, {candidate}
- Few high-impact-low-effort tech debt: {candidate}, {candidate}

## Open Questions
- ...

## Recommendation (one line)
```

---

## Steps

1. **Scope the question** — what is the user trying to learn? One sentence.
2. **Survey the surface** — read code, screenshot pages, list candidates as you go. Don't go deep on any one yet.
3. **Group candidates** into three buckets: Feature / UX / Tech debt
4. **Pick hot ones** per bucket — one impactful feature, a few each of UX and tech debt
5. **Write the note** using the template
6. **Hand back to the human** — they decide what becomes a PRD via `/prd`

If candidates are too many to evaluate, invoke `/triage` to cut the list before recommending.

---

## NOT

- Does not write a PRD or tech design — that's `/prd`
- Does not grill the user — that's `/grill-me`. Research is silent synthesis.
- Does not implement anything
- Does not pick the winner — recommends with reasoning, lets the human decide
