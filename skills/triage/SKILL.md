---
name: triage
description: Cut a list of N candidates down to the M most-worth-doing using RICE or a simpler heuristic, with the user making the final call. Use when picking what to ship next, prioritizing a backlog, asked to "triage", "prioritize this list", "what should I do first", or "cut this down".
---

# Triage

Score each candidate, recommend a cut line, let the user decide.

---

## Steps

1. **List the candidates** — one line each, what they are
2. **Score each** with RICE or the simpler heuristic below
3. **Sort descending** and show the table
4. **Recommend a cut line** ("top M based on {reason}") in one sentence
5. **Wait for the user's decision** — they can accept, reorder, or override
6. **Write the cut list** to wherever it was requested (research notes, backlog file, conversation)

---

## Scoring

**RICE** — when you have enough info:
- Reach: who/what does this touch (rough integer)
- Impact: 1 (minor) / 2 / 3 (high) / 5 (massive)
- Confidence: 0.5 (guess) / 0.7 / 0.9 (sure)
- Effort: hours

`RICE = (Reach × Impact × Confidence) / Effort`

**Simpler heuristic** — when info is thin: each candidate gets one of
- **Bet** — high upside if it works, scope contained
- **Cleanup** — low risk, predictable value
- **Skip** — interesting but not in budget

Pick the right number of Bets + Cleanups; everything else is Skip.

---

## NOT

- Does not invent candidates the user didn't list
- Does not make the final cut without confirmation — recommends, doesn't decide
- Does not pad estimates to make the math come out — if confidence is low, say so
