# Duplicate Node Layout & Block — manual setup guide

**Duplicate Node Layout & Block** (`duplicate_node`) adds a **Duplicate** tab to
nodes. Click it and Drupal creates a brand‑new node pre‑filled with all the field
values from the original — you make any edits and save. What sets this module apart
from a plain clone is that when **Layout Builder** is in use, it also duplicates the
node's **layout configuration**, including any custom (inline) blocks placed inside
that layout. In other words, it clones the whole page structure, not just the field
data.

That makes it a natural fit for building new pages from a layout‑heavy "template"
node: set up one node exactly how you like it, then duplicate it whenever you need
another page with the same structure. It was written as a modern successor to the
older, now‑outdated Node Clone module, extending the idea to cover Layout Builder
and its inline blocks.

The module depends on core **Node** and **Layout Builder**, and it provides its own
**permission** that controls who may duplicate content — an important control,
because duplicating creates new content. A small settings page lets you tune the
behavior: a title prefix for duplicated nodes, whether Layout Builder configuration
is duplicated, and related options.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the duplicate permission.
2. [Configuration](configuration/index.md) — the Duplicate Node settings form
   (title prefix, Layout Builder duplication, and related options).

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Duplicate Node
Settings**. The Duplicate action itself appears as a **Duplicate** tab on individual
nodes, available to users who hold the module's duplicate permission (set under
**People → Permissions**).

## How to use it

1. Grant the duplicate permission to the appropriate roles (see
   [Installation](installation/index.md)).
2. Open any node and click its **Duplicate** tab.
3. A new node opens, pre‑filled with the original's field values — and, if Layout
   Builder is enabled and duplication is turned on, its layout and inline blocks
   too.
4. Make any changes and **Save** to create the new node.
