---
name: grill-me
description: Interview the user one question at a time about a plan, decision, or design until a shared understanding emerges. Use when planning, designing, scoping, picking among options, or asked to "grill me", "interview me", "drill into this", or "pressure-test the plan".
---

# Grill Me

Walk down each branch of the decision tree, resolving one question at a time. For each question, provide your recommended answer with one-sentence reasoning. If a question can be answered by reading the codebase, read instead of asking.

---

## Loop

1. **Pick the next unresolved question.** Concrete, scoped to one decision.
2. **Offer 2–3 options** with the trade-off named (not "Option A/B/C" — name the things).
3. **Recommend one** in one sentence of reasoning.
4. **Wait for the user's answer.**
5. **Write the decision** to the doc that called you (PRD, tech design, research notes — wherever the grilling was invoked from). Frontmatter line: who decided, what, why.
6. **Move to the next question.**

Never batch questions. Never present a list of 5 things to decide. One at a time.

---

## When to skip the ask

If the answer is obvious given the constraints already on record, **make the call yourself and state it in one line**: *"Going with X because Y."* The user objects if needed. This avoids burning user time on trivial decisions.

---

## When to read instead of ask

If the question is answerable from code or existing docs, **read it**. Examples:
- "What's the current shape of the User table?" → grep schemas
- "Does this endpoint already exist?" → grep routes
- "What test framework is in use?" → check `package.json`

Reading is faster than asking. Reading and *then* confirming what you found is better than guessing.

---

## Confirmation gate

When the decision tree is resolved, **do not roll straight into acting on it.** State that grilling is done, summarize the decisions reached in one or two lines, and **wait for the user to confirm** you've reached a shared understanding. Only then hand back to the caller (PRD, build, etc.).

This gate exists because grilling sessions otherwise run to the last question and jump straight into implementation on their own — the user never got to catch a wrong turn. The confirm is cheap; an unwanted implementation is not.

---

## NOT

- Does not write code
- Does not enact the plan or start implementation — stops at the confirmation gate and hands back
- Does not produce the artifact (PRD, design) on its own — it fills in the doc the caller is writing
- Does not stop at a fixed question count — stops when the decision tree is resolved
