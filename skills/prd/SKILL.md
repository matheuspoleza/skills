---
name: prd
description: Build a single progressive PRD doc that captures problem, product requirements, tech design, and milestones — grilling the user via /grill-me at each section to reach shared understanding. Use when starting a feature, scoping a non-trivial change, or asked to "write a PRD", "spec this", "plan the feature", or "design the architecture".
---

# PRD

One doc, four sections, filled progressively. Each section grills the user via `/grill-me` until the section is decided, then moves on. The result is the single source of truth for the feature.

Argument: `fast` — skip optional probes, cap to 15 minutes, single milestone. Use when the feature is small or the clock is tight.

---

## Produces

`docs/{feature}/prd.md` using `templates/prd.md`:

```
---
feature: {slug}
phase: prd
updated: YYYY-MM-DD
---

# PRD — {feature}

## 1. Coverage Checklist        ← qualitative, gut-check
## 2. Product Requirements      ← what, why, who, scope, ruled-out
## 3. Tech Design               ← data, API, components, sequences, risks
## 4. Milestones                ← vertical slices, each independently shippable
```

Plus `docs/{feature}/milestones/milestone-{n}.md` per slice.

---

## Reads

- `.app-catalog/catalog.json` if present — use its names verbatim
- `docs/{feature}/research.md` if present — start from the hot picks

---

## Steps

### Section 1 — Coverage Checklist

Before any structured writing, run through:
- Who is this for?
- What problem does it solve?
- What does success look like?
- What's explicitly ruled out?
- Is this new pages/endpoints or modifying existing?
- Any product restrictions or constraints?

Use `/grill-me` for these. In `fast` mode, ask only the first three.

### Section 2 — Product Requirements

Fill in: goal, target users (use catalog actors), in-scope behaviors (use catalog actions), explicit non-goals, success criteria as observable outcomes.

**Voice rules:**
- Take positions. *"We are not doing X"* beats *"X is out of scope for now."*
- No hedging. *"It might be the case that…"* is not allowed.
- Name what was cut and why — cuts matter as much as inclusions.

### Section 3 — Tech Design

Use `/grill-me` to walk these rooms in order, skipping any that don't apply:

1. Scope & boundaries — what does this touch?
2. Data model — entities, fields, relations, migration
3. API — endpoints, shapes, errors, auth
4. Frontend — components, routes, state ownership
5. Business rules — guards, reactions, effects
6. Sequences & edge cases — non-trivial flows
7. Security/privacy/cost — risks table
8. Open questions — what's still undecided

Update Section 2 immediately if a tech decision changes scope or risk.

### Section 4 — Milestones

Each milestone is **independently shippable** — a working vertical slice with user-visible value. Walk sequencing with `/grill-me`:
- Smallest end-to-end slice we can ship?
- Riskiest part — what comes first?
- Dependencies between slices?

Write `docs/{feature}/milestones/milestone-{n}.md` per slice. Each contains the task list with BDD acceptance criteria per task.

In `fast` mode: one milestone, one slice, no breakdown.

---

## NOT

- Does not write code
- Does not run grilling itself — invokes `/grill-me`
- Does not produce wireframes or visual designs
- Does not start implementation — `/build` or `/build-batch` comes next
