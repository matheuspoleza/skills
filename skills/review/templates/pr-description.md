# PR description template

Write the PR like a teammate explaining the change to another engineer, not like a
spec. Plain English, outcome-first, short. This style is calibrated on two canonical
PRs — match them:

- https://github.com/jamdotdev/apiofjam/pull/12854 (CORE-2509)
- https://github.com/jamdotdev/apiofjam/pull/12855 (CORE-2511)

Always run the body through `/humanizer` before posting (it loads the owner's
`style-profile.md`, which has the binding voice rules).

## Shape

1. **Ticket link on its own line** (if there is one): `[CORE-1234](https://linear.app/yay/issue/CORE-1234)`. Skip it for a stacked child PR that just points at its parent.
2. **One short paragraph: what it does and why,** framed as the capability it unlocks, not the code. "This lets us grab a still frame from a Jam's video and return it as an image. It's the groundwork for giving an AI agent eyes on a recording." Not "wraps `FrameService.fetchFrames`".
3. **One short paragraph (optional): how it works at a high level,** plus what builds on it or, for a stacked PR, the parent PR that holds the real logic.
4. **A short bullet list only if there are user-facing options/capabilities,** under a plain lead-in line like `What you can ask for:`. 2-4 bullets, plain English, no code identifiers.
5. **Behavior and edge cases in plain prose** (errors, privacy, limits) — not a table, not a checklist.
6. **Testing in ONE plain sentence:** what was verified end to end. "Tested end to end against real CF video: frames come back as readable images, the access check holds on a private Jam, and each size renders at the right resolution." No checkbox list.
7. **`Out of scope (separate tickets): ...`** one line, only if relevant.
8. **Link the technical spec** (Notion) if one exists.

## Voice

- Clean, full sentences with normal capitalization. This is written work, not Slack — do NOT use the lowercase chat register here.
- Plain English and outcome-framed. Say what it does for a person or agent. Name the command or tool the user sees (`jam get frames`, the `getFrames` tool), not internal functions (`verifyScope`, `assertJamWithMedia`).
- Short. A few short paragraphs. If a reviewer needs depth, it lives in the review report, not the PR body.
- Few links, each purposeful: the ticket, the parent/related PR, the spec doc. Nothing decorative.

## Do not

- No markdown `##` headings. Use a plain label line (`What you can ask for:`, `Out of scope:`) only to introduce a list.
- No test-plan checkbox list. No `- [x]` items. Testing is one sentence (#6).
- No "Notes for reviewers" section, no pre-existing-error caveats, no dependency-ordering paragraph. If a dependency matters, say it in one plain sentence ("the logic lives in the parent PR #12854").
- No Before/After tables, no command-output dumps, no schema keys, no error codes, no pixel measurements, no guard-order function lists.
- No em or en dashes, no emoji, no bold inline-header bullets (`**Thing:** ...`).
- Don't open with bullets or a `short version:` line. Open with the prose paragraph from #2.

## Skeleton

```
[CORE-1234](https://linear.app/yay/issue/CORE-1234)

<one paragraph: what this lets us do and why it matters, in plain English>

<optional one paragraph: how it works at a high level; for a stacked PR, point at the parent PR that holds the logic>

What you can ask for:
- <plain-English capability>
- <plain-English capability>

<one or two plain sentences on error/edge/privacy behavior>

Tested <one sentence on what was verified end to end>.

Out of scope (separate tickets): <list>.

Technical specs: <Notion link>
```
