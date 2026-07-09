# Vendored skill: humanizer

This is a **vendored fork**, not a skill authored to this toolkit's `write-a-skill`
contract. It exceeds the 100-line cap on purpose — it is maintained upstream by a
third party. Edit it freely, but track the divergence below so upstream fixes can be
merged later.

## Upstream

- Repo: https://github.com/blader/humanizer
- License: MIT (see `LICENSE`)
- Pinned commit: `9600f2b7241cb4eed6ad803abee5ea01d67fe8e4` ("Add style cadence AI tells (v2.8.0)", 2026-06-07)

## Local changes on top of upstream

1. **Auto-load style profile.** The `## Voice Calibration` section reads
   `~/.claude/style-profile.md` if present and treats its rules as binding,
   overriding the generic voice default. This is what makes `/style-profile` work.
   Built/refined by the `/style-profile` skill (see `skills/style-profile/`).

Add a bullet here for every future local change, so a merge is auditable.

## Updating from upstream

1. `git -C /tmp clone https://github.com/blader/humanizer.git` (or fetch in the
   existing global clone).
2. Diff the new upstream `SKILL.md` against the pinned commit above to see what
   changed upstream.
3. Diff our `SKILL.md` against the pinned commit to see our local changes.
4. Merge upstream changes in, re-apply the local changes listed above, then bump
   the pinned commit here.

## Install note

`install.sh` copies `*.md` from this directory, so `SKILL.md`, `README.md`,
`AGENTS.md`, and this `VENDOR.md` ship to the target's `.claude/skills/humanizer/`.
`LICENSE` (no `.md`) stays in the repo for attribution and is not copied by the
installer.
