---
name: onboard
description: Build a product field guide for an unfamiliar app — one markdown file per feature with pages, flows, screenshots, and the gotchas only a human knows. Use when starting on a new project, joining an existing codebase, or asked to "map the product", "understand what this app does", or "onboard".
---

# Onboard

Capture *product* understanding — what features exist, what users do with them, what they look like, and what the gotchas are. The stuff a fresh agent can't recover from grepping code.

Runs once per project. Skip if `.app-catalog/README.md` already exists and is current; re-run for a single feature only when that feature meaningfully changes.

---

## Produces

```
.app-catalog/
├── README.md              ← domains, actors, feature index
├── features/
│   └── {feature-slug}.md  ← one file per feature
└── screenshots/
    └── {feature-slug}-{view}.png
```

Each `features/{slug}.md` is the atomic unit. Downstream skills load just the relevant feature for the task at hand.

---

## Reads

- The running app (via Chrome DevTools MCP or Jam)
- The user (interview for purpose, edge cases, gotchas)
- `package.json` (to detect Agentation)
- Routes / nav config — only as scaffolding to find pages, not as the catalog itself

---

## Steps

### 1. Browse — build a draft

Click through the running app. For each distinct chunk of capability:
- Note the routes you visit
- Take a screenshot to `.app-catalog/screenshots/{candidate-slug}-{view}.png`
- Draft a candidate name and one-sentence purpose

Use Chrome DevTools MCP or Jam per `rules/visual-check.md`. If the app isn't running, ask the user to start it or fall back to pure interview.

End this step with a list of *candidate features* to confirm with the user — names only, no detail yet.

### 2. Interview — confirm each feature

For each candidate feature, ask one question at a time, with a recommended answer (per the grilling pattern):

1. Is this one feature, or should it be split / merged?
2. What's its purpose? (one sentence — why does it exist?)
3. Who uses it? (which actors)
4. What flows matter? (happy path + 1–2 important edges)
5. Anything broken, deprecated, or planned I should know? (gotchas)

Skip a question when browsing already gave a confident answer — don't ask just to ask.

### 3. Write — one file per feature

Write `.app-catalog/features/{slug}.md`:

```markdown
# {Feature Name}

**Domain:** {area-of-product}
**Actors:** {who uses it}
**Purpose:** {one sentence}

## Pages
- `{route}` — {one-line description}

## Flows
**{Flow name} (happy):** {step → step → step}
**{Flow name} (edge):** {what goes wrong, what happens}

## Screenshots
![{view}](../screenshots/{slug}-{view}.png)

## Notes
- {gotcha, limitation, planned change, product decision}
```

Keep it tight. A feature file shouldn't exceed ~50 lines. If it does, the feature is probably two features.

### 4. Index — write README

Write `.app-catalog/README.md`:

```markdown
# App Catalog

## Domains
- **{domain}** — {one-line description}

## Actors
- **{actor}** — {one-line role}

## Features
- [{feature name}](features/{slug}.md) — {one-line purpose}
```

### 5. Wire Agentation (if applicable)

Skip if `agentation` is not in `package.json`. Otherwise:

1. Find the React root: `grep -RIln "createRoot\|ReactDOM.render" src/`
2. Check if `<Agentation />` is already mounted: `grep -RIln "from .agentation.\|<Agentation" src/`
3. If not mounted, offer to add a dev-only render: `{process.env.NODE_ENV === "development" && <Agentation />}`
4. Verify MCP connection — `agentation`-prefixed tools should be in the tool list. If not, ask the user to run `npx agentation-mcp doctor` and `init`.
5. Add a line `**Agentation:** mounted (dev only)` at the bottom of `README.md`.

### 6. Confirm

Summarize: domain count, feature count, actor count. Ask: *"Does this map look right? Any feature I missed, named wrong, or split wrong?"* Revise on feedback.

---

## NOT

- Does not catalog code-level details (resources, mutations, events, rules) — those are derivable from grep
- Does not compile to Gherkin or any other format — markdown is the source of truth
- Does not write PRDs, tech designs, or task breakdowns — downstream skills
- Does not modify production code outside Agentation wiring (and only with user approval)
- Does not run dev servers or install dependencies — assumes the project already runs

---

## Already done?

If `.app-catalog/README.md` exists, read it before any planning session. For task work, load only the relevant `features/{slug}.md`. To update after a feature changes: re-interview for that one feature, rewrite its file, update the README's one-line purpose if it shifted.
