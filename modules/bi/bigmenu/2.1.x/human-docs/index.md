# Big Menu — manual setup guide

**Big Menu** (`bigmenu`) makes very large menus editable again. Core Drupal renders
the whole menu tree — every link, at every depth — as one giant draggable table on
the menu edit screen. On a menu with thousands of items that page can time out,
run out of memory, or simply become too slow to use. Big Menu swaps that screen for
a shallow, depth‑limited version that loads only the top level and lets you drill
into each branch on demand.

You reach the menu editor exactly as before — **Structure → Menus → Edit menu**
(`/admin/structure/menu/manage/{menu}`). Nothing about how you navigate changes;
Big Menu simply substitutes its own, lighter form for core's. Each parent that has
children shows an **Edit child items** link that reloads the same screen rooted at
that branch, with a breadcrumb back to the top, so you work through a huge menu one
level at a time instead of rendering it all at once. Reordering, enabling/disabling,
weights, and the add‑link button all still work — they are just scoped to the branch
you are looking at.

The module has a single setting, **Max depth**, which controls how many levels of
the menu render on each screen (default 1, i.e. the top level only). It depends only
on core's Menu UI module and adds no new permissions, and because it only overrides
a form, disabling the module instantly restores core's behavior.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the one setting (Max depth) and the
   menu screen it takes over.

## Where it lives in the admin menu

Big Menu takes over the existing menu edit screens under **Structure → Menus**
(`/admin/structure/menu`) — there is no new page to find them at. Its own settings
form sits at **Configuration → Big Menu** (`/admin/config/bigmenu`).
