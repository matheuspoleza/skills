# BDD — Acceptance Criteria

Write BDD-style acceptance criteria using Given/When/Then before coding any non-trivial behavior. These become the first failing tests in the TDD cycle.

## When to Use

**Use BDD for:**
- Non-trivial features with branching behavior
- API endpoints and route handlers
- Components with state or conditional rendering
- Any task with more than one outcome

**Skip for:**
- Typo fixes, config changes, dependency bumps
- Pure visual changes verified in the browser

## Format

```typescript
describe('Feature: {feature name}', () => {
  describe('Given {precondition / state}', () => {
    describe('When {action / trigger}', () => {
      it('Then {expected outcome}', () => {
        // test body
      })
    })
  })
})
```

## Structure Rules

1. **Nest logically:** Feature → Given state → When action → Then outcome
2. **One behavior per `it`:** each test verifies a single outcome
3. **Present tense:** "returns" not "will return"
4. **Be specific:** "returns 401 with `{ error: 'unauthorized' }`" not "handles auth"
5. **Reference real names:** use actual function, route, or component names — not generic placeholders

## Cover Both Paths

Every feature gets a happy path AND error paths:

```typescript
describe('Feature: Authentication', () => {
  describe('Given valid credentials', () => {
    describe('When signIn() is called', () => {
      it('Then returns a session token', () => {})
    })
  })

  describe('Given invalid credentials', () => {
    describe('When signIn() is called', () => {
      it('Then returns AuthError', () => {})
    })
  })
})
```

## Acceptance Criteria as Task Header

List BDD scenarios at the top of a task before implementation. Feature is done when all scenarios pass.

## Common Mistakes

| Mistake | Fix |
|---|---|
| Testing implementation details | Test observable behavior |
| Multiple assertions per `it` | One `it` = one outcome |
| Missing error cases | Always include failure paths |
| Abstract scenarios ("given invalid data") | Concrete inputs and outputs |
| No Given state | Always specify preconditions |
