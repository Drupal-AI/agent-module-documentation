# Admin Menu Levels — manual setup guide

**Admin Menu Levels** (`admin_menu_levels`) makes Drupal's **menu administration
screens** easier to work with when a menu is large or deeply nested. On sites with big
menu trees, the full list of menu links on the menu‑edit page can be unwieldy to scroll
through and reorder. This module adds options to filter which menu items are shown — for
example limiting the displayed depth so you only see the levels you care about.

It is an admin‑UI convenience for the menu editing screens only. It changes how the
menu list is *presented* while you edit; it does not change your menus, your content, or
anyone's access — it simply shows a more manageable subset of items at a time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings form. The filtering options appear directly on the menu
administration screens under **Structure → Menus** (`/admin/structure/menu`) when you
edit a menu.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Menus** and edit a large menu.
3. Use the added filtering options to narrow which menu items are shown — for instance
   limiting the number of levels — so you can focus on the part of the tree you are
   editing.

This is most useful on sites where the menu tree is deep or has many items and the full
list is otherwise hard to manage.
