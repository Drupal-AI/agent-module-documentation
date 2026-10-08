# Collapsible Drag 'n Drop — manual setup guide

**Collapsible Drag 'n Drop** (`collapsible_dnd`) makes Drupal's draggable admin
tables **collapsible**, so parent rows with big sub-trees can be folded away.
That turns unwieldy drag-and-drop reordering — on menus, taxonomy terms, Manage
fields, Manage display, and any other tabledrag table — into something you can
actually use on a large hierarchy.

Drupal's core `tabledrag` powers those hierarchical draggable tables, but they
become a chore when a parent has more children than fit on screen: you scroll
past a hundred rows just to move one top-level item. Collapsible DnD adds
expand/collapse toggles to sub-trees and, optionally, an **Expand all**,
**Collapse all**, and a **search box** to each table's toolbar. It hooks itself
into core's tabledrag library automatically, so it applies everywhere a draggable
table appears — no per-table setup.

The module works site-wide the moment you enable it. An optional settings form
lets you scope *where* it runs (via route patterns) and switch the three toolbar
controls on. It provides one permission, **"administer collapsible dnd
settings"**, which gates that form, and it has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the optional settings form: route
   patterns and the Expand all / Collapse all / search toolbar controls.

## Where it lives in the admin menu

Once enabled, the collapse/expand toggles appear automatically on draggable
tables. Its own settings form sits at **Configuration → User interface →
Collapsible DnD** (`/admin/config/user-interface/collapsible-dnd`).

## How to use it

Enable it and go to any draggable admin table — for example **Structure → Menus →
*(a menu)*** (`/admin/structure/menu/manage/main`) — where you'll now see toggles
to fold and unfold each parent row's children. If you want to limit the feature
to (or exclude it from) specific admin screens, or turn on the Expand all /
Collapse all / search controls, visit the settings form described in
[Configuration](configuration/index.md).
