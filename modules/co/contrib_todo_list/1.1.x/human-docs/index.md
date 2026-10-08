# Contribution Todo list — manual setup guide

**Contribution Todo list** (`contrib_todo_list`) adds a collaborative to‑do list
directly onto Drupal nodes, so content editors and reviewers can create, share,
and track tasks tied to a specific piece of content. It is built for teams
coordinating work — for example tracking what remains to be done on a Drupal
module or project page — turning a node into a shared checklist rather than
keeping tasks in a separate tool.

Todos are attached to specific nodes (and to elements within the content), can be
shared with other contributors, and carry a status you can track. It supports
language‑specific todos for multilingual sites, and access is governed by a
permission the module provides. Under the hood it uses core's **Options** module
for the status select values and core's **History** module to track state, so both
must be enabled.

After enabling the module there are a couple of manual steps: grant the "Manage
todo list" permission to the right roles, and place the "Contrib todo list" block
in a theme region so the list appears on node pages. Once that is done, editors
visit any node and start adding todos.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, grant the permission, and place the block.

There is **no dedicated settings page** for this module. Setup is done through the
Permissions and Block layout pages, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no configuration form of its own. You set it up through core admin
pages:

- **People → Permissions** (`/admin/people/permissions`) — grant the *Manage todo
  list* permission.
- **Structure → Block layout** (`/admin/structure/block`) — place the *Contrib
  todo list* block.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. At **People → Permissions**, grant the **Manage todo list** permission to the
   roles that should be able to create and manage todos.
3. At **Structure → Block layout**, place the **Contrib todo list** block in a
   region of your theme (for example a sidebar or the content area).
4. Visit any node page. Editors with the permission can now create todos, share
   them with other contributors, and update their status right there on the node.
