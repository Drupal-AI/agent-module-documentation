# Menu Condition — manual setup guide

**Menu Condition** (`menu_condition`) adds a new **"Menu position"** visibility
condition, so you can show or hide a block based on where the visitor is in a
menu. Instead of writing brittle URL-pattern rules, you pick a menu link, and the
block appears on that link's page **and every page beneath it** in the menu tree.

This is the natural way to build section-aware layouts. Choose the "Products"
menu link and a block shows across the whole Products branch of the site; choose a
top-level navigation item and a contextual sidebar follows that entire section.
You can also select a whole menu, in which case the condition matches on any page
reached through that menu. Because it keys off your site's menu structure rather
than paths, it keeps working as URLs change.

The module is deliberately tiny: it provides a single condition plugin and
nothing else — no settings page, no permissions, no configuration object of its
own. It plugs into Drupal's standard condition system, so it shows up wherever
conditions are evaluated — most commonly the **Block layout** visibility tab, and
it also handles cache correctness automatically so blocks vary properly per menu
trail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the plugin id, the stored
value format, and the evaluation logic — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module adds a condition to existing forms rather than a settings page of its
own, so there is no separate configuration page — using it is covered below.

## Where it lives in the admin menu

Menu Condition has no admin page of its own. Its "Menu position" condition appears
inside the **Visibility** settings of any block, at **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`) and place or
   configure a block.
2. In the block's configuration, open the **Visibility** section and select the
   **Menu position** tab.
3. Use the **Menu parent** dropdown to pick the menu link you want to key off.
   The list contains every menu and every link within it. You can choose a
   specific link, or select a whole menu.
4. Save the block.

The block will now appear only on the chosen menu item and all of its child
pages. Selecting a whole menu shows the block on any page in that menu's active
trail; leaving the selection empty applies no restriction. As with any core
condition, you can tick **Negate the condition** to *hide* the block within that
menu branch instead, and combine it with other visibility rules (roles, content
types) to fine-tune exactly where the block appears.
