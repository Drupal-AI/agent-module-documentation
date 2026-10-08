# Menu Block — manual setup guide

**Menu Block** (`menu_block`) provides highly configurable blocks of menu links.
Drupal core can already place a whole menu as a block, but it gives you very
little control over *which part* of the menu tree is shown. Menu Block fills that
gap: it lets you start a block at any level of the menu, limit its depth, pin it
to a fixed parent item, make it follow the visitor as they navigate, give it a
dynamic title, and target its own theme template — all from the block's settings
form.

Under the hood it adds a `menu_block` block plugin, derived once per menu and
extending core's own menu block, that exposes many more options. You can set the
**initial visibility level** and the **maximum number of levels**, optionally make
the initial level **follow the active menu item**, and root the tree at a **fixed
parent** so the block only shows that item's children. It can expand every item,
show or hide the parent item, hide itself on pages that aren't in the menu, and
show or suppress an empty block. The block title can be replaced with a dynamic
value — the menu title, the active item, the active trail's parent or root, or the
fixed parent — and optionally turned into a link.

You configure Menu Block **per block**, in the Block layout UI, so there is a
little setup each time you place one — but it works entirely through the standard
block placement flow. It only depends on core's **Menu UI** module, has no
settings page of its own, and requires Drupal 10.1+ or 11. Because its settings
are stored as configuration, the blocks you build export and deploy between
environments like any other block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the settings keys and theme
suggestions — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place a menu block and work through
   its settings, field by field.

## Where it lives in the admin menu

Menu Block has **no central settings page** (`configure` is null). You use it when
placing blocks, at **Structure → Block layout** (`/admin/structure/block`): click
**Place block** in a region and choose one of your menus from the **Menus**
category (each menu appears as its own Menu Block option). It also works inside
**Layout Builder** if your site uses it. The rich options described in
[Configuration](configuration/index.md) appear on that block's own settings form.
