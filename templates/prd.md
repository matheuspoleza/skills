---
feature: {slug}
phase: prd
updated: {YYYY-MM-DD}
---

# PRD — {feature}

## 1. Coverage Checklist

Qualitative gut-check. Lean answers, not prose.

- **Who is this for?** {actor — use catalog name if it exists}
- **What problem does it solve?** {the situation in the world, not the solution}
- **What does success look like?** {observable outcome}
- **What's explicitly ruled out?** {what we are not doing}
- **New surface or modifying existing?** {new pages/endpoints vs touching existing}
- **Product restrictions?** {time, scope, tech, regulatory}

---

## 2. Product Requirements

**Goal:** {one sentence — what changes for the user}

**Target users:** {primary actor, secondary actor}

**In scope:**
- {behavior — observable}
- {behavior — observable}

**Explicitly out of scope:**
- {what we cut} — {why}
- {what we cut} — {why}

**Success criteria:**
- {observable outcome that proves it shipped correctly}
- {observable outcome}

---

## 3. Tech Design

Fill the rooms that apply. Skip the rest.

**Scope & boundaries.** {what modules this touches; new vs extend}

**Data model.** {entities, fields, relations, migration shape}

**API.** {endpoints — method, path, request/response shape, errors, auth}

**Frontend.** {pages, components, routes, state ownership}

**Business rules.** {guards / reactions / effects}

**Sequences & edge cases.** {non-trivial flows; what can fail and how}

**Risks.**
| Risk | Mitigation | Status |
|---|---|---|
| {risk} | {how} | mitigated / accepted / residual |

**Open questions.**
- {question} — {resolved by: more discovery / a POC / user input}

---

## 4. Milestones

Each milestone is **independently shippable** — a working vertical slice with user-visible value.

- **Milestone 1:** {one-line goal} → `milestones/milestone-1.md`
- **Milestone 2:** {one-line goal} → `milestones/milestone-2.md`

---

## Decisions Made

| Decision | Considered | Chose | Why |
|---|---|---|---|
| {topic} | {options} | {chosen} | {reasoning} |
