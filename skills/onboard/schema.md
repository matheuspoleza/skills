# catalog.json schema

```json
{
  "domains": [{
    "id": "string",
    "name": "string",
    "description": "string",
    "resources": ["resource-id"],
    "views": ["view-id"],
    "actors": ["actor-id"]
  }],
  "resources": [{ "id": "string", "name": "string", "description": "string" }],
  "actors": [{ "id": "string", "name": "string", "role": "string" }],
  "views": [{ "id": "string", "name": "string", "route": "string | null", "domain": "string" }],
  "actions": [{
    "id": "string",
    "name": "string",
    "actor": "actor-id",
    "view": "view-id",
    "resource": "resource-id",
    "event": "string",
    "domain": "string"
  }],
  "rules": [{
    "id": "string",
    "type": "guard | reaction | effect",
    "action": "action-id",
    "event": "event-name",
    "description": "string"
  }],
  "journeys": [{
    "id": "string",
    "name": "string",
    "goal": "string",
    "domains": ["domain-id"],
    "steps": [{ "view": "view-id", "action": "action-id" }]
  }]
}
```

## Field-mapping pitfalls

**Rule type → required reference field.** Using the wrong one produces empty Gherkin output.

| Rule type | Required field | Wrong field to avoid |
|-----------|---------------|----------------------|
| `guard`   | `action: "action-id"` | ~~`when`~~ |
| `reaction` | `event: "event-name"` | ~~`when`~~ |
| `effect`  | `event: "event-name"` | ~~`when`~~ |

One rule per action. Multi-action guards like `"action": "create-project|archive-project"` are silently ignored — split them.

## Journey steps must be objects, not strings

```json
// ✗ compiler skips, feature file gets empty "# Step N" comments
"steps": ["create-task", "assign-task"]

// ✓ compiler resolves view, guards, reactions
"steps": [
  { "view": "project-detail", "action": "create-task" },
  { "view": "project-detail", "action": "assign-task" }
]
```
