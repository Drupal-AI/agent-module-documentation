# Node Add Copy — manual setup guide

**Node Add Copy** (`node_add_copy`) lets an editor start a brand-new node with
its fields **pre-filled from an existing node** of the same content type. It's a
"duplicate to a new node" flow that speeds up creating similar content — rather
than retyping everything, you begin from a copy and adjust.

What makes it different from most clone modules is *when* the new node is
created. Modules like Quick Node Clone create the duplicate immediately and then
let you edit it. Node Add Copy instead opens a normal **Node add** form
pre-populated with the source node's values, so you can review and edit the
information **before** the new node is saved — nothing is written until you
submit. It provides its own permission to control who can use the copy flow, and
has no dependencies beyond Drupal core.

> **Please note:** this project is marked **Unsupported / obsolete** by its
> maintainer, who recommends using
> [**Quick Node Clone**](https://www.drupal.org/project/quick_node_clone)
> instead — it does the same and more. Treat Node Add Copy as legacy: fine to
> understand an existing site that uses it, but prefer a maintained alternative
> for new projects.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form,
just its own permission and the copy flow described below.

## How to use it

1. Grant the module's **permission** to the roles that should be able to copy
   nodes, at **People → Permissions** (`/admin/people/permissions`).
2. From an existing node, use the copy action the module provides to open a
   **Node add** form of the same content type, pre-filled with that node's
   values.
3. Review and edit the pre-filled fields as needed, then **save** — only at that
   point is the new node actually created.
