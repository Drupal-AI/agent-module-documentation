# Entity Tasks — manual setup guide

**Entity Tasks** (`entity_tasks`) exposes a **block** that displays the local tasks
— the View / Edit / Delete tabs — for the current page. Instead of those tabs only
appearing in the theme's default local‑tasks region, you can place them as a block
anywhere in your layout. It also offers a **toolbar integration** so the tasks can
appear in the admin toolbar in one of three styles.

The everyday use is giving editors quick, consistently placed access to an entity's
operations wherever it suits your design. Because the block simply renders the
current page's local tasks, the tabs shown always reflect the viewing user's
permissions — only tasks a user can actually access appear — so the module adds no
access‑control role beyond its own permission.

It has no module dependencies and supports Drupal 10 and 11. Two things are worth
configuring: **where you place the block** (via the Block layout screen) and, if
you want tasks in the toolbar, the **toolbar display mode** (via the module's
settings form, disabled by default).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — placing the block and choosing the
   toolbar display mode.

## Where it lives in the admin menu

You place the block from **Structure → Block layout**
(`/admin/structure/block`), and choose the toolbar display style from the module's
settings form at **Configuration → Entity Tasks** (`/admin/config/entity-tasks`).
