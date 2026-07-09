#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/matheuspoleza/skills.git"

# Locate this script's directory. When piped via curl ($BASH_SOURCE is empty
# or refers to a non-file like /dev/stdin), we self-bootstrap by cloning the
# repo into a tempdir and re-execing from there.
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
  SKILLS_DIR=""
fi

if [ -z "$SKILLS_DIR" ] || [ ! -d "$SKILLS_DIR/skills" ]; then
  TARGET_INPUT="${1:-$PWD}"
  if [ ! -d "$TARGET_INPUT" ]; then
    echo "Error: target directory '$TARGET_INPUT' does not exist."
    exit 1
  fi
  TARGET_ABS="$(cd "$TARGET_INPUT" && pwd)"
  echo "Fetching skills toolkit from $REPO_URL..."
  TMP_BOOT="$(mktemp -d)"
  trap 'rm -rf "$TMP_BOOT"' EXIT
  git clone --depth 1 --quiet "$REPO_URL" "$TMP_BOOT/skills"
  bash "$TMP_BOOT/skills/install.sh" "$TARGET_ABS"
  exit $?
fi

TARGET="${1:-.}"

if [ ! -d "$TARGET" ]; then
  echo "Error: target directory '$TARGET' does not exist."
  exit 1
fi

echo "Installing skills into $TARGET..."

mkdir -p "$TARGET/.claude/skills"
mkdir -p "$TARGET/.claude/rules"
mkdir -p "$TARGET/.claude/templates"
mkdir -p "$TARGET/.claude/prompts"

# Skills — mirror whole directory (SKILL.md plus any sibling .md files).
# Clear stale .md files first so removed siblings (e.g. an old schema.md) don't linger.
for skill_dir in "$SKILLS_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  dest="$TARGET/.claude/skills/$skill_name"
  mkdir -p "$dest"
  rm -f "$dest"/*.md
  cp "$skill_dir"/*.md "$dest/"
  echo "  ✓ skill: $skill_name"
done

# Rules
for rule in "$SKILLS_DIR/rules"/*.md; do
  cp "$rule" "$TARGET/.claude/rules/$(basename "$rule")"
  echo "  ✓ rule: $(basename "$rule")"
done

# Templates
for template in "$SKILLS_DIR/templates"/*.md; do
  cp "$template" "$TARGET/.claude/templates/$(basename "$template")"
  echo "  ✓ template: $(basename "$template")"
done

# Prompts (paste-and-edit copy)
for prompt in "$SKILLS_DIR/prompts"/*.md; do
  cp "$prompt" "$TARGET/.claude/prompts/$(basename "$prompt")"
  echo "  ✓ prompt: $(basename "$prompt")"
done

# Cleanup deprecated skills from previous installs
for old in discovery tech-design breakdown polish; do
  if [ -d "$TARGET/.claude/skills/$old" ]; then
    rm -rf "$TARGET/.claude/skills/$old"
    echo "  ✗ removed deprecated skill: $old"
  fi
done
for old in task.md polish.md tech-design.md progress.md; do
  if [ -f "$TARGET/.claude/templates/$old" ]; then
    rm "$TARGET/.claude/templates/$old"
    echo "  ✗ removed deprecated template: $old"
  fi
done

mkdir -p "$TARGET/docs"
echo "  ✓ docs/ directory ready"

# Agentation auto-setup (unchanged)
react_pkgs=()
while IFS= read -r pkg; do
  if grep -qE '"react"[[:space:]]*:' "$pkg"; then
    react_pkgs+=("$pkg")
  fi
done < <(find "$TARGET" -type d -name node_modules -prune -o -type f -name package.json -print 2>/dev/null)

if [ "${#react_pkgs[@]}" -gt 0 ]; then
  echo ""
  echo "Detected ${#react_pkgs[@]} React package.json file(s) — setting up Agentation..."
  for pkg in "${react_pkgs[@]}"; do
    pkg_dir="$(dirname "$pkg")"
    rel="${pkg_dir#$TARGET/}"; [ "$rel" = "$pkg_dir" ] && rel="."
    if grep -qE '"agentation"[[:space:]]*:' "$pkg"; then
      echo "  – $rel: agentation already in package.json"
    else
      if (cd "$pkg_dir" && npm install agentation -D >/dev/null 2>&1); then
        echo "  ✓ $rel: installed agentation as devDependency"
      else
        echo "  ! $rel: npm install agentation -D failed — run it manually"
      fi
    fi
  done
  mcp_result=$(node -e "
const fs = require('fs');
const path = process.argv[1];
let cfg = {};
try { cfg = JSON.parse(fs.readFileSync(path, 'utf8')); } catch (e) {}
cfg.mcpServers = cfg.mcpServers || {};
if (cfg.mcpServers.agentation) {
  console.log('already');
} else {
  cfg.mcpServers.agentation = { command: 'npx', args: ['-y', 'agentation-mcp', 'server'] };
  fs.writeFileSync(path, JSON.stringify(cfg, null, 2) + '\n');
  console.log('added');
}
" "$TARGET/.mcp.json" 2>&1) || mcp_result="error: $mcp_result"
  case "$mcp_result" in
    added)   echo "  ✓ agentation MCP added to .mcp.json at project root" ;;
    already) echo "  – agentation MCP already configured in .mcp.json" ;;
    *)       echo "  ! failed to update .mcp.json: $mcp_result" ;;
  esac
  echo "  → /onboard will offer to mount <Agentation /> in your React root(s)"
  echo ""
else
  echo "  – no React package.json found under $TARGET (skipped Agentation setup)"
fi

# CLAUDE.md
CLAUDE_FILE="$TARGET/CLAUDE.md"
RULES=(tdd bdd clean-code react visual-check agentation scope-first handoff escalation status-sync)

if [ ! -f "$CLAUDE_FILE" ]; then
  cat > "$CLAUDE_FILE" <<'EOF'
# Claude Instructions

## Product Context

If `.app-catalog/README.md` exists, read it at the start of every session.
It indexes the product's domains, actors, and features — use its names
consistently in all docs, code, and conversations.

For feature work, also load the relevant `.app-catalog/features/{slug}.md`,
which has the pages, flows, screenshots, and gotchas for that one feature.

## Skills

Invoke with /skill-name:

**Setup**
- `/bootstrap` — Install or update this toolkit in the current project
- `/onboard` — Map the codebase, take visual baselines

**Discovery**
- `/research` — Survey a surface, surface candidates per dimension
- `/prd` — Write a progressive PRD (problem → requirements → tech design → milestones). Pass `fast` for 15-min mode.

**Build**
- `/build` — Implement a milestone, supervised, BDD + TDD
- `/build-batch` — Implement a milestone autonomously (Conductor lane)

**Validate**
- `/review` — Two-phase validation (agentic QA → human eyes → PR description)

**Debug**
- `/debug` — Reproduce a bug, capture evidence to a cleared log, propose fix options, validate, add regression test

**Primitives**
- `/grill-me` — One-question-at-a-time interview with recommended answers
- `/zoom-out` — Go up one abstraction layer, map siblings + callers
- `/handoff` — Compact session into a cold-readable resume doc
- `/triage` — Cut N candidates to M using RICE
- `/write-a-skill` — Author a new skill that conforms to the contract

**Writing**
- `/humanizer` — Strip AI-writing tells from text; auto-loads your `~/.claude/style-profile.md`
- `/style-profile` — Learn your writing style into `~/.claude/style-profile.md`, which `/humanizer` auto-loads

## Rules

@.claude/rules/tdd.md
@.claude/rules/bdd.md
@.claude/rules/clean-code.md
@.claude/rules/react.md
@.claude/rules/visual-check.md
@.claude/rules/agentation.md
@.claude/rules/scope-first.md
@.claude/rules/handoff.md
@.claude/rules/escalation.md
@.claude/rules/status-sync.md

## Prompts

Paste-and-edit copy lives in `.claude/prompts/`. Use it when prompting craft should be visible (interview demos, bespoke sessions). See `.claude/prompts/README.md`.
EOF
  echo "  ✓ CLAUDE.md created"
else
  # Append missing rule references — one rule at a time
  for rule in "${RULES[@]}"; do
    if ! grep -q "@.claude/rules/$rule.md" "$CLAUDE_FILE"; then
      echo "@.claude/rules/$rule.md" >> "$CLAUDE_FILE"
      echo "  ✓ CLAUDE.md appended rule: $rule"
    fi
  done
  # Remove legacy "## Domain Context" block (refers to obsolete catalog.json)
  if grep -q "^## Domain Context" "$CLAUDE_FILE"; then
    awk '
      /^## Domain Context/ { skip = 1; next }
      skip && /^## / && !/^## Domain Context/ { skip = 0 }
      !skip { print }
    ' "$CLAUDE_FILE" > "$CLAUDE_FILE.tmp" && mv "$CLAUDE_FILE.tmp" "$CLAUDE_FILE"
    echo "  ✗ CLAUDE.md removed legacy Domain Context block"
  fi
  # Add product context if missing
  if ! grep -q "app-catalog/README.md" "$CLAUDE_FILE"; then
    DOMAIN_BLOCK="## Product Context

If \`.app-catalog/README.md\` exists, read it at the start of every session.
It indexes the product's domains, actors, and features — use its names
consistently in all docs, code, and conversations.

For feature work, also load the relevant \`.app-catalog/features/{slug}.md\`,
which has the pages, flows, screenshots, and gotchas for that one feature.

"
    head -1 "$CLAUDE_FILE" > "$CLAUDE_FILE.tmp"
    echo "" >> "$CLAUDE_FILE.tmp"
    echo "$DOMAIN_BLOCK" >> "$CLAUDE_FILE.tmp"
    tail -n +2 "$CLAUDE_FILE" >> "$CLAUDE_FILE.tmp"
    mv "$CLAUDE_FILE.tmp" "$CLAUDE_FILE"
    echo "  ✓ CLAUDE.md updated with product context"
  fi
fi

echo ""
echo "Done. Pipeline:"
echo "  /onboard → /research → /prd → /build (or /build-batch) → /review"
echo ""
echo "Primitives anywhere: /grill-me  /zoom-out  /handoff  /triage  /write-a-skill"
