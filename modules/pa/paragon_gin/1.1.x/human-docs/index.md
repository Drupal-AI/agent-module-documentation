# Paragon Gin — manual setup guide

**Paragon Gin** (`paragon_gin`) bundles a set of authoring‑experience refinements
for sites that use the **Gin** admin theme together with **Layout Builder**. It is
part of the Paragon distribution, and its whole job is to make editing layouts in
Gin feel cleaner and more intuitive.

Once enabled it makes a series of focused tweaks: it adds a Gin theme setting that
toggles the Layout Builder block list between an **icon view and a list view**; it
restyles the section **edit links** in a layout; it shows a **tooltip with the
block type** when you hover over a block; it refines the navigation **top bar** with
handy *View / Edit Layout Builder / Version History* shortcuts; it updates inline
block titles from a `field_heading` value when one is present; and it removes the
(non‑functional) block search bar to reduce clutter.

Everything Paragon Gin does is presentation — CSS, JavaScript, Twig templates and
hooks. It adds no routes, permissions, services or config entities, so there is
nothing here that changes content or access; it purely polishes the admin UI.

Because it is a coordination layer, Paragon Gin has several dependencies: it needs
**Paragon Core**, **Gin LB** (`gin_lb`), **Layout Builder Browser**
(`layout_builder_browser`) and core's **Navigation** and **Navigation Top Bar**
modules, and of course you will want the **Gin** admin theme itself in use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Gin / Layout
   Builder dependencies and enable it.

There is **no dedicated Parade Gin settings page**. The one option it adds — the
Layout Builder block **view‑mode toggle** — lives in the Gin theme settings, as
described below.

## Where it lives in the admin menu

Paragon Gin does not add an admin page of its own. Its refinements appear inside
**Layout Builder** (the block browser, section edit links, hover tooltips) and on
the **navigation top bar**. Its single setting is added to the **Gin theme
settings** at **Appearance → Settings → Gin**
(`/admin/appearance/settings/gin`).

## How to use it

1. Make sure the **Gin** admin theme is installed and set as the admin theme, and
   that **Gin LB**, **Layout Builder Browser** and **Paragon Core** are enabled
   (see [Installation](installation/index.md)).
2. Enable Paragon Gin. The layout‑editing refinements apply immediately — edit any
   entity with Layout Builder to see the restyled edit links, block‑type tooltips
   and the cleaned‑up top bar.
3. If you want to change how the Layout Builder block library is presented, open
   the **Gin theme settings** and use the view‑mode toggle Paragon Gin adds there
   to switch between the icon view and the list view.
