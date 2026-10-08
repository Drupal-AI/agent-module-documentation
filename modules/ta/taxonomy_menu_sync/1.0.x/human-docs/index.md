# Taxonomy Menu Sync — manual setup guide

**Taxonomy Menu Sync** (`taxonomy_menu_sync`) lets you build menu items directly
from the terms in a taxonomy vocabulary — and keep those menu links in sync as the
terms change. Instead of hand-building a menu that mirrors a category tree and then
maintaining it by hand, you point the module at a vocabulary and it generates the
matching menu links for you.

The problem it solves is drift: a site's navigation is often just a reflection of
its taxonomy (product categories, topic sections, departments), but Drupal has no
built-in way to keep the two in step. This module bridges that gap. It can use each
term's default taxonomy path or a custom node URL depending on your settings, and it
deliberately blocks editing a synced item's title and parent link directly in the
menu UI so your menu keeps matching the vocabulary. It is designed to coexist with
other menu modules rather than conflict with them, and it works well alongside
**Menu Item Extras**, which adds extra fields to menu items.

The module does not do anything on its own the moment you enable it — you first
create one or more sync configurations telling it which vocabulary maps to which
menu, then run a synchronization. It depends on core's **Menu Link Content**
(`menu_link_content`) and **Taxonomy** (`taxonomy`) modules, and it provides its own
permissions. It has no submodules.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead — they are terser and token-cheaper.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a sync configuration and
   synchronize terms into a menu.

## Where it lives in the admin menu

After enabling, go to **Structure** and open the term-to-menu configuration listing
at `/admin/structure/taxonomy_menu_item_extras`. From there you add, edit, and run
your sync configurations. See [Configuration](configuration/index.md) for the full
walk-through.
