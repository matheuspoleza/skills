---
name: bootstrap
description: Install or update the skills toolkit (skills, rules, templates, prompts, CLAUDE.md) in the current project from the canonical GitHub repo. Use when starting a new project, when asked to "install skills", "set up the toolkit", "update skills to latest", or "bootstrap".
---

# Bootstrap

Fetch the latest skills toolkit and install it into the current project. Works for first install and as the update command for existing installs.

---

## Produces

In the target project root:

- `.claude/skills/`, `.claude/rules/`, `.claude/templates/`, `.claude/prompts/` populated with the latest contents
- `CLAUDE.md` created, or rule references appended to an existing file
- `docs/` directory ensured
- Agentation auto-setup if a React `package.json` is detected (devDependency + `.mcp.json` entry)

---

## Reads

- Existing `CLAUDE.md` (appended to, not overwritten)
- Any `package.json` under the target (to detect React for Agentation)
- `.mcp.json` at the project root (created or updated)

No project source code is read or modified.

---

## Steps

### 1. Confirm scope

Default target is the current working directory. If the user names a different target, take its absolute path. Confirm before running if the target isn't obvious.

### 2. Run the installer

From the target directory:

```bash
curl -fsSL https://raw.githubusercontent.com/matheuspoleza/skills/main/install.sh | bash
```

The script self-bootstraps: it clones the repo into a tempdir and re-execs from there. Requires `git` and `curl` (both standard).

For a non-CWD target, pass the path explicitly:

```bash
curl -fsSL https://raw.githubusercontent.com/matheuspoleza/skills/main/install.sh | bash -s -- /path/to/project
```

### 3. Report

Summarize what was installed or updated from the installer's stdout — skills added, rules appended to `CLAUDE.md`, deprecated entries removed. Surface any warnings verbatim, especially:

- `npm install agentation -D failed` — user must run it manually
- `failed to update .mcp.json` — likely malformed existing JSON

---

## Does NOT

- Modify any source code in the target project
- Run skills (`/onboard`, `/research`, etc.) — the user invokes those after install
- Commit changes — the user reviews and commits
- Auto-update on a schedule — re-run this skill explicitly to pull the latest
