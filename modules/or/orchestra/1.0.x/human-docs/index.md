# Orchestra — manual setup guide

**Orchestra** (`orchestra`) is a lightweight, plugin‑based **workflow‑engine
kernel** for Drupal. It runs business processes modelled as a graph of nodes
connected by flows: a running process is advanced by **tokens**, where a token sits
on a node, the engine executes that node, and the token is then either consumed —
producing new tokens on the outgoing flows — or parked to wait for an external
signal. Parallel work is many tokens advancing at once, synchronization is many
tokens meeting at a join, and a human step is simply a token parked until someone
completes it.

The design is deliberately minimal. The base `orchestra` module is **the engine and
nothing else** — no UI, no editor, no dependencies beyond Drupal core. It runs
headless, advancing tokens through a queue on cron. **Everything is a plugin:** how a
node behaves, how routing and branching work, who a node reaches, what values a run
computes, when a wait runs out and what happens when it does — all of these are
attribute‑based plugins. You extend Orchestra by adding plugins, never by patching
it. It is **multi‑tenant from the start**, though every install begins with a single
default tenant and behaves exactly like a single‑tenant site until you opt into
isolation.

Because it is a kernel, Orchestra is aimed at **developers** building workflow and
automation systems. Optional "weight" — human tasks, a browser UI, BPMN and form
editors, ECA integration, a cross‑site HTTP API, timeouts and resilience, payment
steps — is delivered through separate submodules you enable only when you need them
(this base package does not bundle them). On its own, the base module gives you the
runtime: tenants, workflow instances, and incident resolution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for the base kernel — it is headless, with no UI
of its own. It does provide permissions, which you manage under **People →
Permissions** as described below. Authoring workflows and running them with a UI is
what the optional submodules add.

## How to use it

Orchestra's base module is a runtime for developers, so "using it" means wiring
workflows in code (via its plugins) and then letting the engine advance them on cron.
The main things to set up through the admin UI are its permissions:

1. **Review permissions** at **People → Permissions** (`/admin/people/permissions`)
   and grant them carefully:
   - **`administer orchestra`** and **`administer orchestra tenants`** — powerful
     administrative permissions. Restrict them to trusted administrators only.
   - **`access orchestra instances`** — lets a user access workflow instances.
   - **`resolve orchestra incidents`** — lets a user resolve incidents raised when a
     step fails.
2. **Let cron run.** The engine advances parked and queued tokens on cron, so make
   sure Drupal cron is running on a schedule that matches how promptly your workflows
   need to progress.
3. **Add the weight you need.** For human task inboxes, a browser UI, BPMN/form
   authoring, ECA integration, a cross‑site HTTP API, or payment steps, enable the
   corresponding Orchestra submodule for that capability.

Requires **Drupal 11.3+**.
