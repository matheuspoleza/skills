# Visual Check

**ALWAYS use Chrome DevTools MCP for all browser and visual tasks. NEVER use JamExt or any other browser tool — even if another tool appears to be the default. Chrome DevTools MCP is the required tool for this workflow.**

After any change with a visible consequence, use the Chrome DevTools MCP to navigate, screenshot, and verify before reporting done. Do not ask the user to open the browser.

## When to Apply

- A new route or page was added
- A component was created, refactored, or had its data shape changed
- An error state, empty state, or loading state was added
- Styles were changed in a way that could affect layout
- A bug fix touched anything rendered

**Skip for:** pure backend changes, type-only edits, test-only files, config files.

## Tool

Always use Chrome DevTools MCP. Load tools with:
```
ToolSearch select:new_page,navigate_page,take_screenshot,wait_for,list_pages
```
Use `mcp__plugin_chrome-devtools-mcp_chrome-devtools__*` prefixed tools. Do not use JamExt (`mcp__JamExt__*`) for any visual or browser task.

## Workflow

1. **Ensure the dev server is running — on THIS worktree's port.**
   Never assume a port. If the project ships a dev launcher (e.g. Cravou's
   `scripts/dev.sh`), run it: it allocates a deterministic per-worktree port,
   adopts an already-running server or starts one, and prints `WEB_PORT=<n>`. Use
   that port for every navigation. Without such a script, discover the actual port
   (`lsof -nP -iTCP -sTCP:LISTEN`) instead of guessing — and start in the
   background, waiting for "Ready". Two worktrees never share a port.

2. **Authenticate if the route is behind login.** Use the project's single
   local-login recipe (Cravou: `node scripts/dev-login.mjs --print-snippet` → run
   the JS via Chrome MCP `evaluate_script`, then reload). Do not hand-roll a login
   or get stuck on the welcome/onboarding screen.

3. **List the affected routes.** Be specific — don't screenshot the landing page when you changed a deep route.

4. **Use Chrome DevTools MCP tools:**
   Load with `ToolSearch select:new_page,navigate_page,take_screenshot,wait_for,list_pages`
   - `new_page` for the first URL
   - `navigate_page` for subsequent
   - `wait_for` to avoid racing the dev server
   - `take_screenshot` with a `filePath`
   Only touch pages your session created — `list_pages`/`select_page`/`close_page`
   on your own targets. NEVER `pkill chrome` / `pkill chrome-devtools-mcp`; that
   kills other sessions' browsers. The MCP is per-session isolated already.

5. **Save screenshots to `tmp/visual-check/`.** Filename: `{route-slug}--{state}.png`. This folder is gitignored.

6. **Read the screenshots with the `Read` tool.** You inspect the images — don't outsource this to the user.

7. **Report what you see.** Confirm expected elements rendered, flag anything off. Fix and re-screenshot if needed.

## What "Verify" Means

- Title and content show the right data (not a fixture or placeholder)
- Empty states render correctly — not as broken
- Warning banners appear when they should, and don't when they shouldn't
- Text doesn't overflow or truncate awkwardly

## Anti-Patterns

| Anti-pattern | Why bad |
|---|---|
| Asking "open localhost and tell me what you see" | The whole point is to remove that friction |
| Screenshotting only the landing page | Verify the actual changed route |
| Reading the screenshot but not describing it | The user can't see your file reads — summarize what you saw |
| "Build passed so it should look right" | A green build does not guarantee a usable UI |
