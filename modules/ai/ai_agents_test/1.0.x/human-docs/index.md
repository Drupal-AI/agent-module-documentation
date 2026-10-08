# AI Agents Test — manual setup guide

**AI Agents Test** (`ai_agents_test`) lets you write repeatable tests for your AI
agents. Agents are hard to change safely: editing a prompt, swapping a model, or
adding a tool can fix one case while quietly breaking others, and there is no
compiler to warn you. The answer is the same as for any behaviour you cannot check
statically — keep a body of test cases and re‑run them. This module makes those
cases first‑class objects in Drupal.

Each test is a **content entity**: an input and the behaviour you expect. You
create and edit tests like any other content, list and filter them in a View, and
run them with a button. Crucially, the same test can also be **exported as
configuration**, so it travels with the site and can run in a CI pipeline —
turning "does this agent still behave?" into an automated check.

That dual nature is the point. During development a test is an editable content
entity you tweak and re‑run interactively; for a pipeline it is configuration a
test runner executes. Permissions match this split: a separate administer
permission (restricted) plus distinct **view** and **edit** permissions, so the
people who write tests need not be the people who administer the agent framework.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Tests are managed as content: you create, edit and list them (in a View) using the
module's three permissions — **administer** (restricted), **view**, and **edit**
`ai_agents_test`. Grant edit/view to the prompt engineers who author tests, and
keep administer for those who manage the framework itself.

## How to use it

1. Enable the module on a project that is actively building AI agents.
2. Create a test entity for an agent: capture the input and the behaviour you
   expect.
3. Run tests from the UI as you iterate, and **export them to configuration** so
   they ship with the site and run in CI.

Because both this module and the wider `ai_agents` framework are moving quickly
(it is experimental, at 1.0.0‑alpha4), expect the entity shape and runner
interface to change — adopt it early on active projects, but don't build anything
long‑lived on the exported format yet.
