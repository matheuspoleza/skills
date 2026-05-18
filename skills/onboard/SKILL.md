---
name: onboard
description: Map an unfamiliar codebase into a shared domain catalog with visual baseline screenshots, compiled markdown docs, and Gherkin features. Use when starting on a new project, joining an existing codebase, or asked to "map the project", "understand the codebase", or "onboard".
---

# Onboard

Build a baseline understanding of the project before any feature work. Runs once per project. Skip if `.app-catalog/catalog.json` already exists and is current.

---

## Produces

All output under `.app-catalog/` at the project root:

```
.app-catalog/
├── catalog.json          ← structured domain catalog
├── screenshots/          ← {domain}-{view}.png
├── docs/                 ← compiled markdown (overview, per-domain, journeys)
└── features/             ← compiled Gherkin (one .feature per journey)
```

The catalog is the shared vocabulary for all downstream skills. They will use its names verbatim.

---

## Reads

- The codebase itself (routes, mutations, schemas, types, post-mutation chains)
- `package.json` (to detect Agentation)

---

## Steps

### 1. Extract — write `catalog.json`

Scan in this order, building the catalog as you go:

1. Routes + auth patterns → Views + Actors
2. Mutations, endpoints, form submissions → Actions + Events
3. Post-mutation chains → Rules (reactions, effects)
4. Precondition checks → Rules (guards)
5. Types, schemas, API payloads → Resources
6. Group by bounded context → Domains
7. Common action sequences → Journeys

Schema and field-mapping pitfalls live in `schema.md` next to this skill. Read it before writing the catalog.

### 2. Compile

```bash
app-catalog compile --catalog .app-catalog/catalog.json --output .app-catalog --target markdown
app-catalog compile --catalog .app-catalog/catalog.json --output .app-catalog --target gherkin
```

### 3. Visual baseline

Use Chrome DevTools MCP per `rules/visual-check.md`. For each domain, navigate to its primary view and screenshot to `.app-catalog/screenshots/{domain}-{view}.png`. Capture at minimum: a main dashboard, a key create flow, a key detail view.

### 4. Wire Agentation (if applicable)

Skip if `agentation` is not in `package.json`. Otherwise:

1. Find the React root: `grep -RIln "createRoot\|ReactDOM.render" src/`
2. Check if `<Agentation />` is already mounted: `grep -RIln "from .agentation.\|<Agentation" src/`
3. If not mounted, offer to add the import and a dev-only render: `{process.env.NODE_ENV === "development" && <Agentation />}`
4. Verify MCP connection — `agentation`-prefixed tools should be in the tool list. If not, ask the user to run `npx agentation-mcp doctor` and `init`.
5. Record `{ "agentation": true }` under a top-level `tooling` block in `catalog.json`.

### 5. Review

Summarize: domains, resource count, actor types, key journeys, feature files. Ask the user *"Does this map look right? Anything missing or misnamed?"* Revise the catalog and re-compile on feedback.

---

## NOT

- Does not write PRDs, tech designs, or task breakdowns — those are downstream skills
- Does not run dev servers or install dependencies — assumes the project already builds
- Does not modify production code outside the Agentation wiring step (and only with user approval)

---

## Already done?

If `.app-catalog/catalog.json` exists, read it before any planning session. Use its names everywhere. To update after new features ship: re-run extraction for the affected domains only, then re-compile. Do not regenerate from scratch.
