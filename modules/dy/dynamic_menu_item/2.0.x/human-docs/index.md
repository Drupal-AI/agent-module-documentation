# Dynamic Menu Item — manual setup guide

**Dynamic Menu Item** (`dynamic_menu_item`) lets you create a custom menu item and
then **assign nodes to it from the node editing screen**, so the menu link's target
follows content rather than pointing at one fixed URL. In practice you make a special
menu item once, and then — while editing any node — you tick a box to make that menu
link point to the current node. It's a lightweight way to keep a menu link
context‑aware without hand‑editing menus every time.

It's a **site‑structure / navigation** feature. The menu link resolves its target
from context (respecting normal access rules), and the module provides its own
**permission** that controls who sees the "assign this node" option while editing
content. It builds on core's **Menu UI** and **Menu Link Content** modules and
targets Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** — you create the dynamic menu item under the
Menus admin and then assign nodes from the node edit form, described in "How to use
it" below.

## Where it lives in the admin menu

You create the dynamic menu item at **Structure → Menus → Dynamic menu item**
(`/admin/structure/menu/dynamic_menu_item`). The per‑node assignment then happens on
the **node edit form**, for users who hold the module's permission.

## How to use it

1. After enabling, go to **`/admin/structure/menu/dynamic_menu_item`** and **create
   the menu item**.
2. Grant the **Edit dynamic menu item** permission (under **People → Permissions**)
   to the roles that should be able to point the menu link at content while editing
   nodes.
3. Edit any node. Users with that permission will see the dynamic menu item option —
   **tick the box and save the node**, and the menu link updates to point at that
   node.
