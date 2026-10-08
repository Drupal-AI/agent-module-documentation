# Entity Workflow — manual setup guide

**Entity Workflow** (`entity_workflow`) brings together two core systems —
**Workflows** (state transitions) and **Workspaces** (staged, isolated content
versions) — to give each entity its own workflow *within* a workspace. Instead of
a single site-wide editorial state, a workspace can let each piece of content move
through its own workflow before the whole workspace is published.

The core module is largely the plumbing; the practical value comes from its two
submodules, which set up ready-to-use workflows so you do not have to build one
from scratch:

- **Entity Workflow Content** (`entity_workflow_content`) provides a basic
  workflow for content.
- **Entity Workflow Workspace** (`entity_workflow_workspace`) provides a basic
  workflow for workspaces themselves.

This is the pattern you reach for when your team prepares a batch of changes in a
workspace, walks individual items through review states, and then publishes the
workspace as a unit. It depends on core's **Workflows** and **Workspaces**
modules and provides its own permissions.

Because both the workflow transitions and workspace publishing are governed by
permissions (the module's own plus core's), the main thing to verify is that
**who can transition states and who can publish a workspace** matches your
editorial trust model — those permissions decide who can move content forward and
who can push a whole workspace live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the submodules that give you ready-made workflows.
2. [Configuration](configuration/index.md) — enabling the workflows, wiring them
   to content, and checking who can transition and publish.

## How to use it

At a high level: enable the module and its submodules to get starter workflows,
confirm the underlying **Workflows** and **Workspaces** are set up, then work in a
workspace — moving each entity through its workflow states and finally publishing
the workspace. See [Configuration](configuration/index.md) for the specifics.
