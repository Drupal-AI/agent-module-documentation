# jsTree menu — manual setup guide

**jsTree menu** (`jstree_menu`) renders your Drupal menus as interactive,
collapsible trees using the **jsTree** JavaScript library. It is provided as a
block: place a "jsTree menu" block, pick which menu it should show, and that menu
appears as an expandable tree with fold-out branches — which is especially handy
for large, deeply nested navigation that would be unwieldy as a flat list.

You can switch the tree's appearance between the **default** and **proton** jsTree
themes from the module's admin form. The module reflects the menu it renders,
including each menu item's access, so users only see the links they are allowed to
see; it has no access-control role of its own.

One thing to sort out before it works: jsTree menu integrates the **jsTree
library** but does not bundle it. You need to install the jsTree library (and,
recommended, the jsTree proton theme) following the module's own README, otherwise
the block has nothing to render with.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, set up the
   jsTree library, and enable the module.
2. [Configuration](configuration/index.md) — the admin form (jsTree theme) and
   placing the jsTree menu block.

## Where it lives in the admin menu

The module's settings form is the config route `jstree_menu.config`, where you
choose the jsTree theme. You place the block itself under **Structure → Block
layout** (`/admin/structure/block`) — see [Configuration](configuration/index.md).

## How to use it

1. Install the jsTree library so the module has something to render with (see
   [Installation](installation/index.md)).
2. Add a **jsTree menu** block to a region under **Structure → Block layout**, and
   choose which menu it should render.
3. Optionally set the jsTree theme (default or proton) on the module's admin form.

Recommended companions include **Taxonomy menu** (to turn vocabularies into
menus), a Bootstrap theme or the **Font Awesome** module (so menu icons render
correctly), and **Special Menu Items** (for parent items that are not links).
