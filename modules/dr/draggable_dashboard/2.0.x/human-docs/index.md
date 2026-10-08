# Draggable Dashboard — manual setup guide

**Draggable Dashboard** (`draggable_dashboard`) lets privileged users build
multi-column dashboards out of ordinary Drupal blocks, then place each finished
dashboard anywhere on the site as a single block. Think of it as a no-code way to
assemble a start page, an editor "quick links" hub, a departmental intranet
homepage, or a marketing landing page — by dragging existing blocks into columns
and arranging them.

Each dashboard is a configuration entity with a title, a description, a number of
columns, and an ordered set of blocks. You add blocks from the standard block
library, configure each one inline (its label, its own settings), pick which
column it goes in, and drag to reorder. When you're done, the dashboard becomes a
placeable block you position through core's **Block layout** — so the same
dashboard can be reused on several pages.

Because dashboards are config entities, they export cleanly and deploy between
environments. And because each block inside a dashboard is access-checked when it
renders, a dashboard never exposes block content a viewer couldn't otherwise see.
All dashboard administration is gated by a single permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — create dashboards, add and arrange
   blocks, place a dashboard on the site, and the permission that controls it.

## Where it lives in the admin menu

Dashboards are managed at **Structure → Draggable Dashboard**
(`/admin/structure/draggable-dashboard`) — this is the module's configure link.
Once built, a dashboard is placed like any block at
**Structure → Block layout** (`/admin/structure/block`).
