# Maestro — manual setup guide

**Maestro** (`maestro`) is a business-process / workflow engine for Drupal. You
draw a workflow **template** out of connected **tasks** (start, interactive
human tasks, if/and/or branching, content-type steps, batch functions,
set-variable steps, sub-flows, end), launch running **processes** from that
template, and an **orchestrator** advances each process through its **task
queue**, assigning the interactive tasks to the users, roles, or groups that
should handle them.

This is a suite. The base **Maestro** module documented here is the **engine,
data model, and task plugin system** — the machinery that runs workflows and the
API to drive it. The things you *click* to build and run workflows visually ship
as **submodules**: the visual template editor, the task console where users do
their assigned work, and various integrations. So a typical install enables the
base module plus one or more of those submodules.

Key pieces to have in mind:

- **Template** — the workflow definition (a task graph). It's exportable
  configuration. A template must pass validation before it can be put "into
  production".
- **Task** — a step in the template. Built-in task types include Start, End, If,
  And, Or, Interactive (a human task with a form), Manual Web, Content Type
  (create/edit a node as a step), Batch Function, Set Process Variable, and Spawn
  Sub-Flow. Developers can add their own task types.
- **Process** — a running (or finished) instance of a template.
- **Queue** — the list of task instances the engine works through for each
  process.
- **Orchestrator** — the runner that executes ready non-interactive tasks and
  hands out assignments. **Maestro does not schedule itself** — you trigger the
  orchestrator from cron/Drush (or it runs when a Task Console refreshes).

Maestro provides several permissions, Drush commands, config schema, and two
plugin types. It depends on core **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (and the submodules you need), and grant permissions.
2. [Configuration](configuration/index.md) — the engine settings form, running
   the orchestrator, and starting processes.

## Where it lives in the admin menu

The engine settings form is at **Configuration → Workflow → Maestro**
(`/admin/config/workflow/maestro`). Template building, the task console, and other
UIs are provided by the submodules and appear under their own admin sections once
enabled.

## How to use it (the big picture)

1. **Build a template** — using the visual template builder submodule
   (`maestro_template_builder`), draw the task graph: a Start task, your
   interactive/content/branching tasks in between, and an End task. Configure each
   task's assignment and settings. Validate the template.
2. **Launch a process** from the template — from a URL, from Drush, or from code
   (see [Configuration](configuration/index.md)).
3. **Advance it** — schedule the orchestrator (via cron hitting the orchestrator
   URL, or `drush maestro:orchestrate`) so running processes move forward and
   assignments are created.
4. **Do the work** — assigned users open their tasks in the Task Console
   (`maestro_taskconsole` submodule) and complete them, which advances the process
   to the next task.

The full option-by-option setup of the engine, the orchestrator, and process
launching is in [Configuration](configuration/index.md).
