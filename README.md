# Skills

A personal development toolkit for Claude Code. Install into any project to get a structured pipeline from research to ship.

## Pipeline

```
/onboard → /research → /prd → /build (or /build-batch) → /review → PR
```

Primitives invokable anywhere: `/grill-me`, `/zoom-out`, `/handoff`, `/triage`, `/write-a-skill`.

## Skills

| Skill | What it does |
|---|---|
| `/onboard` | Map the codebase into a shared catalog + take visual baselines |
| `/research` | Survey a surface in PM-mode, recommend candidates per dimension |
| `/prd` | Write a progressive PRD — problem → requirements → tech design → milestones. Pass `fast` for 15-min mode. |
| `/build` | Implement a milestone, supervised, BDD + TDD + end-to-end validation |
| `/build-batch` | Implement a milestone autonomously inside a Conductor worktree, log-and-skip on scope creep |
| `/review` | Two-phase validation — agentic QA, human-eyes pass, PR description |
| `/debug` | Reproduce → propose fix options → validate against cleared log → regression test |
| `/grill-me` | One-question-at-a-time interview with recommended answers |
| `/zoom-out` | Go up one abstraction layer, map siblings + callers |
| `/handoff` | Compact session into a cold-readable resume doc |
| `/triage` | Cut N candidates to M using RICE |
| `/write-a-skill` | Author a new skill that conforms to the contract |
| `/bootstrap` | Install or update this toolkit in the current project (curl one-liner under the hood) |

## Install

From the target project, run:

```bash
curl -fsSL https://raw.githubusercontent.com/matheuspoleza/skills/main/install.sh | bash
```

To install into a different directory, pass it explicitly:

```bash
curl -fsSL https://raw.githubusercontent.com/matheuspoleza/skills/main/install.sh | bash -s -- /path/to/project
```

The installer clones this repo into a tempdir on the fly — requires `git` and `curl`.

Once installed, re-run the same one-liner to update, or invoke `/bootstrap` from inside the project to do the same.

### From a local clone

```bash
./install.sh                 # current directory
./install.sh /path/to/proj   # specific project
```

Either path copies skills, rules, templates, and prompts into `.claude/` and creates/updates `CLAUDE.md`.

## Feature docs structure

Each feature gets a folder in `docs/`:

```
docs/{feature}/
├── prd.md              ← single source of truth (PRD, tech design, milestones)
├── milestones/
│   └── milestone-1.md  ← vertical slices with BDD-criteria tasks
├── research.md         ← optional, if /research was used
└── reviews/
    ├── {milestone}.md            ← two-phase review report
    ├── {milestone}-pr.md         ← PR description ready to paste
    └── manual-test-{milestone}.md
```

No `progress.md`. No per-task files. `prd.md` is the cold-readable handoff between sessions; everything else hangs off it.

## Rules (always-on)

Installed into `.claude/rules/` and referenced from `CLAUDE.md`:

- **tdd.md** — Red → Green → Refactor, one behavior at a time
- **bdd.md** — Given/When/Then acceptance criteria before code
- **clean-code.md** — SOLID, complexity/size signals, comments only for *why*
- **react.md** — Prop-driven data flow, composed hooks, no-useEffect-sync, reusability gates (tokens + existing components)
- **visual-check.md** — Screenshot and verify UI changes with Chrome DevTools MCP
- **agentation.md** — Wire and use Agentation for UI feedback when available
- **scope-first.md** — Define scope before code; log-and-skip on creep
- **handoff.md** — Every doc must be cold-readable; no "we", "earlier", "as discussed"
- **escalation.md** — Stop-and-ask vs log-and-skip vs proceed-with-note
- **status-sync.md** — Four places stay in sync during `/build`

## Templates

Document shapes the skills fill in. `prd.md`, `review.md`, `pr-description.md`, `manual-test.md`, `research.md`, `bug.md`.

## Prompts

Paste-and-edit copy for moments when prompting craft should be visible. See `prompts/README.md`.

## Authoring new skills

Run `/write-a-skill` or read `skills/write-a-skill/SKILL.md`. The contract: two-sentence description starting with "Use when…", 100-line body cap, four-part body shape (produces / reads / steps / NOT).

## What goes where

| If the thing is… | It belongs in… |
|---|---|
| Named invocable procedure | `skills/{name}/SKILL.md` |
| Always-on or condition-triggered constraint | `rules/{name}.md` |
| Document shape with `{placeholders}` | `templates/{name}.md` |
| Read-once project context | `CLAUDE.md` |
| Paste-and-edit copy (visible craft) | `prompts/{name}.md` |
