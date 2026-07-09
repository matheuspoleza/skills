# React — Patterns & Reusability Gates

Framework-agnostic React conventions: prop-driven data flow, composed hooks, and two reusability gates that run **before you write a new component or a new style**. Match the project's stack (styling lib, state lib, design system) — these are principles, not imports.

## Reusability gate 1 — never hardcode styles, check tokens first

Before writing any color, spacing, radius, font-size, or shadow literal, **stop and look for the token**.

1. Search the project for design tokens / theme (`theme`, CSS variables like `var(--…)`, a `tokens.ts`, a Tailwind config, a `@…/ds` package).
2. Use the token. `var(--color-danger)` / `theme.colors.danger` / `text-red-600` — not `#e5484d`.
3. Need a value with no token? That's a signal: either a token is missing (add it, or flag it) or you're styling something that should reuse an existing component. Don't paper over it with a literal.

| Hardcoded (avoid) | Token-driven (prefer) |
|---|---|
| `color: #e5484d` | `color: var(--color-danger)` |
| `padding: 16px` scattered everywhere | `padding: var(--space-4)` |
| `font-size: 14px` | the project's `Text`/`Body` primitive |

## Reusability gate 2 — search before you create a component

Before creating a component, **search the codebase for one that already exists**. AI's default is to re-invent `Button`, `Modal`, `Card`, `Avatar`, `EmptyState` — check first.

1. Grep the shared component dir and the design system for the thing you're about to build (by role: button, dialog, list-item, badge…).
2. Found one → use it, extend its props if needed.
3. Found something close → adapt the existing one rather than forking a near-duplicate.
4. Genuinely new → build it, and put it where its reuse scope says (feature-private vs shared, see below).

## Component structure

- Arrow function with an explicit, named props interface — **always**, even for trivial components (they grow):
  ```tsx
  interface UserCardProps {
    user: User;
    onRemove?: (id: string) => void;
  }

  export const UserCard = ({ user, onRemove }: UserCardProps) => { /* … */ };
  ```
- Destructure props in the signature.
- **Container vs presentation:** pages/containers orchestrate data (hooks); presentation components receive data via props and render. Keep business logic out of presentation.
- Co-locate by feature. Code used by one feature lives in that feature's folder; only genuinely shared code moves to a global `components/` / `hooks/` / `utils/`.

## Hooks — compose, don't centralize

- Extract business logic into custom hooks; the component focuses on rendering.
- Prefer **several focused hooks** over one mega-hook: `useUserState`, `useUserUpdate`, `useUserSubscription` — not a single `useEverything`.
- Naming: `use[Entity]State` (state), `use[Entity][Action]` (mutations), `use[Entity]Subscription` (subscriptions).
- Start co-located in the component file; extract to its own file when the component grows (~300 lines) or the hook gets reused.

## useEffect — the default is "don't"

Most `useEffect`s in AI-written React are wrong. Before adding one, check the table:

| You're using useEffect to… | Do this instead |
|---|---|
| Copy a prop into local state | Read the prop directly; or derive with `useMemo`; or remount with a `key` |
| Compute a value from props/state | Compute it during render (memoize if expensive) |
| Reset child state when a prop changes | Give the child a `key` that changes — let it remount |
| Fetch server data | Use the project's data layer (React Query / loader / RSC), not `useEffect` + `setState` |
| Respond to a user event | Do it in the event handler, not an effect watching the result |

`useEffect` is for **synchronizing with something outside React** — a subscription, a DOM API, a non-React widget, a network event. If it's not that, it probably shouldn't exist.

**Prop-driven, top-down data flow:** server state flows through the data layer's selector hooks into parents; parents pass props down; children re-render from props. Don't imperatively sync child contents after a prop change — drive a remount with a `key` tied to a server revision (e.g. `updatedAt`) when a child owns mount-initialized state.

## Anti-Patterns

| Anti-pattern | Why bad |
|---|---|
| Hardcoded hex/px when a token exists | Breaks theming; drift across the app; no single source of truth |
| New `Button`/`Modal` when one exists | Duplication, inconsistent UX, double the maintenance |
| `useEffect` + `setState` to mirror a prop | Extra render, stale states, the bug class that never ends |
| One hook holding all of a page's state | Untestable, re-renders everything, impossible to reuse |
| Business logic inside a presentation component | Can't reuse the view; can't test the logic in isolation |

## Why

The three things that rot a React codebase fastest are hardcoded styles, duplicated components, and effect-driven state sync. The two gates and the useEffect table catch all three at write-time — when they're cheap to avoid — instead of at review-time when they're already everywhere.
