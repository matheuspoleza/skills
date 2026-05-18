---
name: write-a-skill
description: Author a new skill in this toolkit that conforms to the contract — strict frontmatter, 100-line cap, explicit trigger language. Use when adding, rewriting, or auditing any SKILL.md in this toolkit.
---

# Write a Skill

A skill in this toolkit is a **named, invocable procedure**. Anything else — a constraint, a document shape, project context, a paste-template — belongs elsewhere. See "Not a skill?" below.

---

## Contract

### Frontmatter (exactly two fields)

```yaml
---
name: kebab-case-slug
description: <One sentence: what it does.> Use when <one sentence: explicit triggers — user phrases, file types, situations>.
---
```

- `name` matches the directory name
- `description` is third-person, ≤ 1024 chars, **two sentences only**
- First sentence: what the skill does
- Second sentence starts literally with "Use when" and lists trigger phrases or conditions

The description is the **only** thing the agent sees when routing. Spend time on it.

### Body

- **≤ 100 lines total** including blank lines. Hard cap.
- If a single section exceeds 50 lines, extract it to a sibling file (`{section}.md`) and link from SKILL.md
- One H1 matching the skill name
- Short paragraphs > bullet lists > tables. No multi-paragraph prose.

---

## Description examples

**Bad** — fuzzy, no triggers:
> Helps with planning features.

**Bad** — three sentences, leaks how:
> Maps the codebase. First scans routes, then mutations. Use when starting a project.

**Good**:
> Map an unfamiliar codebase into a shared domain catalog with visual baselines. Use when starting on a new project, joining an existing codebase, or asked to "map", "understand the codebase", or "onboard".

---

## Body shape

A skill body answers, in order:

1. **What it produces** (the artifact)
2. **Inputs it reads** (files, tools, prior skill outputs)
3. **Steps** (numbered, each ≤ 10 lines)
4. **What it does NOT do** (negative space — prevents creep)

Skip any section that doesn't apply. Don't pad.

---

## Not a skill? Reroute it

| If the thing is… | It belongs in… |
|---|---|
| An always-on or condition-triggered constraint ("must use X", "never Y") | `rules/{name}.md` |
| A document shape with `{placeholders}` | `templates/{name}.md` |
| Read-once project context ("what is this repo, where do things live") | `CLAUDE.md` |
| Paste-and-edit copy you customize per use (visible craft) | `prompts/{name}.md` |
| A behavior another skill needs to invoke | Still a skill — make it a tiny primitive |

Tiny primitives are legitimate. A 5-line skill that does one thing well is better than bolting that behavior into three larger skills.

---

## Authoring procedure

1. **Name it** — kebab-case, verb-first when possible (`grill-me`, `zoom-out`, `write-a-skill`)
2. **Write the description first** — if you can't fit it into the contract, the skill isn't well-scoped yet
3. **Sketch the four sections** — produces / reads / steps / NOT
4. **Cut to 100 lines**
5. **Cold-read it** — would a fresh agent with only this file know what to do?

---

## Auditing an existing skill

Check in order:

- Does the description match the contract? Rewrite if not.
- Over 100 lines? Trim or split.
- Are there constraints baked in that should be rules?
- Are there document shapes baked in that should be templates?
- Could any section be its own tiny primitive skill?

If any check fails, fix it before the skill ships.
