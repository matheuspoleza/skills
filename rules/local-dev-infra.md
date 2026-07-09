# Local Dev Infra — Multi-Session / Worktrees

Assume **other Claude sessions are running right now** in other git worktrees of
this repo, sharing this machine. Every local action must be safe under that
assumption: never assume a port is free, never kill a shared process, never wipe
shared state without coordinating. These are cross-project principles; a project
that has concrete tooling (scripts, ports, accounts) documents the specifics in
its own `CLAUDE.md` / runbook — defer to that for exact commands.

## The three guarantees

1. **Server & ports — get the port, don't assume it.**
   - If the project ships a dev launcher (e.g. `scripts/dev.sh`), run it. It gives
     this worktree a deterministic port, adopts an already-running server or starts
     one, and prints the port. Use that port for every browser navigation, e2e
     run, and screenshot.
   - Without such a script, discover the live port (`lsof -nP -iTCP -sTCP:LISTEN`)
     instead of guessing a default. Two worktrees must never share one port — that
     is how you end up validating the wrong code.

2. **Shared singletons — read-mostly, reset only behind an announced lock.**
   - A local database/stack (e.g. Supabase) is typically a single instance shared
     by all worktrees. Treat it as a near read-only fixture: tests run in
     transactions that ROLL BACK; you don't mutate global state for one check.
   - A destructive reset (`db reset`) wipes every session's data. Do it only
     through the project's guarded path (announced lock that refuses while other
     servers are live), and normally only between sprints — never mid-feature, and
     never from a background agent. Starting a stopped shared service is safe;
     stopping one while others may use it is not.

3. **Browser/MCP — per-session isolated, never kill the shared one.**
   - Chrome DevTools MCP runs `--isolated` (ephemeral profile per session), so
     sessions don't fight over a profile lock. Keep it that way.
   - Only touch pages your session created. **NEVER** `pkill chrome` /
     `pkill chrome-devtools-mcp` / kill a shared dev server you didn't start — that
     takes down other sessions.

## Session startup

Run the project's preflight/doctor (e.g. `scripts/dev-preflight.sh`) at the start
of a session. It is read-only: it tells you which shared resources are up, which
other worktrees hold ports, and whether a reset lock is held — so you adopt
instead of collide. If the project has no doctor, manually check: shared stack up?
which ports are listening? then pick a free one.

## Visual validation is orchestrator-only

The single visual gate is Chrome DevTools MCP, run by the **orchestrator** against
this worktree's own port (see `visual-check.md`). Background/build agents do not
open the browser — they build; the orchestrator integrates and proves it visually.
This avoids agents getting stuck trying to drive a browser they can't reliably
reach.
