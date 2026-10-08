# Menu Hide Parent — manual setup guide

**Menu Hide Parent** (`menu_hide_parent`) automatically hides placeholder parent
menu items when they have no visible children left after access checks. If a
top-level entry like *Create*, *Manager*, or *Settings* exists only to group
sub-items, and a given user cannot reach any of those sub-items, Menu Hide Parent
removes the empty parent from that user's navigation — keeping menus clean,
contextual, and role-aware.

The problem it solves is dead-end navigation. A parent menu item that only serves
as a container looks broken when all of its children are hidden by permission or
publication status: the user sees a heading that leads nowhere. This module prunes
those empty parents so restricted roles get a tidy menu instead of orphaned
headers.

It is careful about performance and correctness. It respects role- and
permission-based access controls, adds `user.roles` as a cache context so each
role gets the right variant, and is **cache-safe** — it runs only when the menu
tree is rebuilt, not on every page load. Under the hood it uses
`hook_menu_tree_alter()` to prune the tree at build time, and it is fully
compatible with cached menu rendering and configuration-managed menus. It supports
Drupal 10.4+ and 11 and has no dependencies beyond core.

Menu Hide Parent needs a small amount of configuration: you choose **which menus**
it applies to. That is covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which menus should hide empty
   placeholder parents.

## Where it lives in the admin menu

Its settings form is at **Configuration → User interface → Menu Hide Parent**
(`/admin/config/user-interface/menu-hide-parent`).
