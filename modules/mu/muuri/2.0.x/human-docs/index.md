# Muuri — manual setup guide

**Muuri** (`muuri`) integrates the **Muuri** JavaScript library — a responsive,
sortable, filterable, draggable grid‑layout library — into Drupal, and adds a
**Muuri Views style plugin** so you can render a View as a dynamic grid. It is a
front‑end / theming module: it makes the Muuri library available to your theme and
components and lets you build interactive card/grid layouts, but it adds no
content and has **no access‑control role** of its own.

The most turnkey way to use it is the **Views style plugin** — build a View, pick
Muuri as its format, and the results render as a draggable, responsive grid. For
custom work you can also attach the Muuri library to your own theme or components
and drive it directly. Everything visual comes from the upstream Muuri project;
this module is the bridge that ships it and wires it into Drupal.

There is nothing to configure at a site‑wide level — the Muuri‑specific options
live on the Views display (or in your own JavaScript). It supports Drupal 9, 10,
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
use it through Views (or your theme), described in "How to use it" below.

## How to use it

The quickest path is through **Views**:

1. Create or edit a View at **Structure → Views** (`/admin/structure/views`).
2. Set the display's **Format** to the **Muuri** style plugin.
3. Configure the Muuri options offered on that format, then arrange your fields
   or content as the grid items.
4. Save and view the display — the results render as a responsive, draggable
   Muuri grid.

For bespoke layouts outside of Views, attach the Muuri library to your theme or a
component and initialize it in your own JavaScript, following the upstream
[Muuri documentation](https://haltu.github.io/muuri/).
