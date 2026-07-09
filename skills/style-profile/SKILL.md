---
name: style-profile
description: Build and refine a personal writing-style profile that /humanizer auto-loads, by sampling real writing (Slack, Linear), interviewing the user, and calibrating with example rewrites. Use when setting up voice matching, when /humanizer output still needs the same manual edits every time, or asked to "learn my style", "build my style profile", or "make humanizer sound like me".
---

# Style Profile

Produces a durable, personal writing-style profile that `/humanizer` reads automatically, so generated and rewritten text matches how the user actually writes without re-editing every time.

## Produces

- `~/.claude/style-profile.md` — the profile. A reference doc, not a procedure. Sections: Voice rules (binding), Banned, Preferred, Worked examples. See `profile-template.md`.

## Inputs it reads

- The user's real writing, when available: Slack messages (`from:` search) and Linear issues/comments they authored. These are ground truth — prefer them over what the user *thinks* they do.
- The user's answers to the interview.
- The user's like/dislike verdicts on example rewrites.
- An existing `~/.claude/style-profile.md` if refining rather than creating.

## Steps

1. **Sample (if sources available).** Pull 15-30 of the user's recent Slack messages and Linear issue descriptions. Extract only *observable* patterns: sentence length, bullets vs prose, link density, contractions, how they open, recurring words, jargon level, objectivity. Quote 3-4 real lines as evidence. Skip a source cleanly if its MCP is missing.
2. **Interview.** Use `/grill-me` style: one question at a time, with a recommended answer drawn from the sample. Cover the gaps the sample can't settle (tone for different audiences, when bullets vs prose, how technical, link policy, length).
3. **Calibrate with examples.** Write the same short message 2-3 ways. Show before/after pairs. The user marks 👍/👎 per pair. Turn each verdict into a concrete rule. Repeat until verdicts stop changing the rules.
4. **Write the profile.** Fill `profile-template.md` into `~/.claude/style-profile.md`. Every rule is concrete and testable ("no em dashes", "max one link per paragraph"), each backed by a sample quote or a verdict. Include 2-3 worked before/after examples.
5. **Confirm the hook.** Verify `~/.claude/skills/humanizer/SKILL.md` auto-loads the profile (Voice Calibration section). If not, tell the user to re-run install or add the line.

## What it does NOT do

- It does not rewrite text. That is `/humanizer`'s job — this skill only produces the profile humanizer consumes.
- It does not invent preferences. Every rule traces to a sample quote, an interview answer, or a calibration verdict.
- It does not edit text in place anywhere, or run `/humanizer` automatically.
- It does not post to Slack or Linear. It only reads from them.

## Refining later

Re-invoke any time. Read the existing profile, sample fresh writing, and run only the example-calibration loop on the rules the user keeps overriding. Update in place; don't start from scratch.
