# Agentation

When the user is giving you UI feedback, prefer **Agentation annotations** over verbal descriptions. Verbal feedback like "the blue button" or "that spacing" forces you to guess which element, file, or component the user means. Agentation annotations carry the CSS selector, file path, React component, and computed styles — no guessing.

## When to Apply

Use Agentation annotations when **all** of the following are true:
- The feedback is about something visible in a running dev server
- The project has Agentation installed (check `package.json` for `agentation` in deps/devDeps)
- The Agentation MCP server is available (you can see Agentation-related MCP tools listed)

**Skip for:** backend feedback, copy-only changes the user pastes as plain text, terminal/CLI output issues, code-level review of files the user has already opened.

## Workflow

1. **Check availability** at the start of a UI-feedback exchange:
   - Is `agentation` in `package.json`?
   - Is `<Agentation />` mounted in the React root? (grep for it under `src/` — common spots are `main.tsx`, `App.tsx`, `index.tsx`)
   - Is the Agentation MCP server connected? (check available tools for an `agentation` prefix)

2. **If Agentation is not available**, fall back to verbal feedback. Do not block — just note one-line: *"Agentation is not set up — taking feedback verbally. Run `npx agentation-mcp init` and add `<Agentation />` to your React root if you want structured annotations."*

3. **If Agentation is available**, tell the user:
   *"Open the running app, click the Agentation toolbar icon, and annotate the element you want to flag. I'll read the annotation directly — no need to describe the location."*

4. **Read annotations via MCP** instead of asking the user to describe what they see. Each annotation gives you a selector, file path, and component tree — use those when creating fix tasks so the file is named explicitly.

5. **Resolve the annotation** in Agentation once the fix lands, so the user's annotation list stays clean. Use the Agentation MCP's resolve action — do not leave stale annotations.

## What "Annotation-Driven Feedback" Looks Like

| Verbal (avoid) | Annotation (prefer) |
|---|---|
| "The login button is misaligned" | Annotation on `button.login-submit` → `src/auth/LoginForm.tsx:42` |
| "There's a spacing issue in the sidebar" | Annotation on `nav.sidebar > .menu-item` → `src/layout/Sidebar.tsx:88` |
| "The empty state looks broken" | Annotation on `[data-testid=empty-state]` → `src/projects/EmptyState.tsx:12` |

The annotation tells you the file to edit. Open it, fix it, write the task referencing that file path.

## Anti-Patterns

| Anti-pattern | Why bad |
|---|---|
| Asking the user to describe the element when Agentation is set up | The whole point is to skip that step |
| Reading the annotation but creating a fix task that doesn't reference the annotated file | The annotation's file path is the most reliable signal — use it |
| Ignoring annotations because verbal feedback already arrived | If both exist, annotation is more precise — prefer it |
| Leaving resolved annotations open in Agentation after shipping the fix | The user's annotation list becomes noise — resolve via MCP |
