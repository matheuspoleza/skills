# Claude Instructions — Skills Toolkit

This repository is a personal development toolkit. It contains skills, rules, and templates that get installed into other projects.

## What's Here

- `skills/` — Invocable skills (one per workflow phase)
- `rules/` — Always-on behavior rules (TDD, BDD, visual check)
- `templates/` — Document templates (progress, PRD, tech design, task, review, polish)
- `install.sh` — Installs everything into a target project
- `examples/` — Full example of the workflow in practice

## When Working in This Repo

You are editing the toolkit itself, not running the workflow. Tasks here are:
- Writing or improving skill definitions
- Writing or improving rules
- Updating templates
- Improving the install script
- Adding examples

## Rules (apply when writing skills and rules)

- Skills must be self-contained — a fresh agent with only the SKILL.md should be able to run the skill
- Every skill must define: when to use it, inputs it reads, outputs it produces, and what it does NOT do
- Templates use `{placeholder}` syntax for fields the agent fills in
- Rules are project-agnostic — no framework-specific commands
