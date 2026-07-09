# Clean Code — SOLID, Complexity, Comments

Write code a teammate can read without you in the room. Small functions, clear names, single responsibilities, and **comments only where the code can't speak for itself.**

## Comments — explain *why*, never narrate *what*

The default is **no comment**. Code says what it does; a comment is for the thing the code can't say. Most AI-written comments restate the next line — delete them.

| Comment | Verdict |
|---|---|
| `// increment counter` above `counter++` | Delete — narrates the obvious |
| `// loop through users` above `users.map(...)` | Delete — the code already says this |
| `// Stripe webhooks can arrive twice; this guard makes the handler idempotent` | Keep — explains a non-obvious *why* |
| `// HACK: upstream lib mutates the array, so we clone first. Remove when #1423 lands` | Keep — names a constraint + exit condition |
| Commented-out code "in case we need it" | Delete — that's what git is for |
| JSDoc that repeats the type signature | Delete — the types already say it |

Rules:
- A comment must add information the reader can't get from the code itself: a *why*, a gotcha, a link to an issue, a non-obvious invariant.
- If you feel the urge to comment *what* a block does, that's a signal to **extract it into a well-named function** instead. The function name is the comment.
- Never leave narration, section banners (`// ---- helpers ----`), or "AS-discussed" notes. Strip them on sight.

## SOLID, applied pragmatically

| Principle | The smell to catch |
|---|---|
| **Single Responsibility** | A function/class/module that changes for more than one reason. "And" in its description = split it. |
| **Open/Closed** | Adding a case means editing a long `switch` in five places. Prefer a map/strategy you extend, not edit. |
| **Liskov** | A subtype/implementation that throws on methods it "doesn't support" breaks the contract. |
| **Interface Segregation** | Callers forced to depend on methods they never use. Split fat interfaces. |
| **Dependency Inversion** | High-level logic importing a concrete client (db, http) directly. Depend on an abstraction, inject the concrete. |

Don't gold-plate: apply these when there's real duplication or a second reason-to-change has appeared — not speculatively on first write.

## Code smells (Fowler) — name them to catch them

Refactoring's catalog of smells is deep in the model's prior — you don't need to teach it, only to **invoke the name**. On any code-quality pass, walk this list and, when one fits, say it back by name and act on it ("this is feature envy — move the method to the data it uses"). Naming is what makes the fix concrete.

| Smell | What it looks like | The move |
|---|---|---|
| **Mysterious name** | A name that doesn't say what the thing is/does | Rename until it does |
| **Duplicated code** | Same shape in two+ places | Extract, unify |
| **Long function / large class** | One unit doing many things | Extract functions; split responsibilities |
| **Feature envy** | A method that mostly touches *another* object's data | Move it next to the data |
| **Data clumps** | The same 3–4 fields travel together everywhere | Bundle into a value object |
| **Primitive obsession** | Strings/ints standing in for a domain concept | Introduce a type for the concept |
| **Repeated switches** | The same `switch`/`if` on a type in many spots | Polymorphism or a strategy map |
| **Divergent change / shotgun surgery** | One module changes for many reasons, or one change touches many modules | Re-cut module boundaries |
| **Speculative generality** | Abstraction for a case that never arrived | Delete it; YAGNI |
| **Message chains / middle man** | `a.b().c().d()`, or a class that only delegates | Hide the chain; collapse the pass-through |

Don't hunt smells speculatively on first write — this list is for the review/refactor pass, where naming the smell is the cheapest way to turn a vague "this feels off" into a concrete fix.

## Complexity & size — signals, not hard fails

These are "start refactoring" thresholds, not lint gates. Crossing one means *look*, not *fail*.

| Signal | Threshold | What to do |
|---|---|---|
| Cyclomatic complexity | ~10 branches in one function | Extract guard clauses; split the branches into named helpers |
| Function length | ~50 lines | Pull cohesive blocks into functions named for what they do |
| File length | ~300 lines (~500 = priority) | Split by responsibility — logic vs orchestration vs presentation |
| Nesting depth | 3+ levels of `if`/`for` | Invert with early returns; extract the inner body |
| Parameter count | 4+ positional args | Pass an options object; or the function is doing too much |

If you exceed a threshold deliberately, leave a one-line *why* (per the comment rule above) — otherwise refactor.

## Naming & dead code

- Names state intent: `isExpired`, `retryWithBackoff`, `unpaidInvoices` — not `flag`, `data2`, `handleStuff`.
- Booleans read as predicates (`hasAccess`), functions as verbs (`fetchUser`), collections as plurals (`orders`).
- Delete dead code, unused exports, and commented-out blocks as you touch a file. No "just in case."
- No magic numbers/strings — name them (`MAX_RETRIES = 3`), unless the literal is self-evidently the value (`* 2`).

## Anti-Patterns

| Anti-pattern | Why bad |
|---|---|
| Comment on every line | Noise drowns the one comment that mattered |
| One giant function "because it's all related" | Can't test, name, or reuse the parts |
| Abstracting on first write (speculative generality) | You guess the wrong axis; YAGNI |
| Leaving dead code behind a flag with no removal date | Rot; the reader can't tell live from dead |
| Hiding a constraint in a clever one-liner instead of a comment | The *why* is lost; the next dev "fixes" it back |

## Why

Under any time pressure, the next reader (often you, in a week) pays for every clever line and every narrating comment. Small, well-named, single-purpose units with comments reserved for genuine *why* are the cheapest way to keep the code legible as it grows. In autonomous lanes (`/build-batch`), this rule plus `scope-first.md` is what keeps the diff reviewable.
