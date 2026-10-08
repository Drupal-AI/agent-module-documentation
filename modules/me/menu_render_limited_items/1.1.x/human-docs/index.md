# Menu Render Limited Items — manual setup guide

**Menu Render Limited Items** (`menu_render_limited_items`) provides a drop‑in
replacement for Drupal core's Menu block that lets you cap how many top‑level
(level‑one) menu items are actually *rendered*. Instead of deleting or unpublishing
the extra links, you keep the whole menu intact and simply tell the block to show
only the first N items. Set the limit to `0` to display them all.

This is handy for compact navigation and "show a few, hide the rest" patterns — for
example a header that should only ever surface the first five sections of a large
menu. The limit applies to the first menu level only. The module depends on core's
**Block** and **Menu UI** modules, both of which Drupal enables automatically as
dependencies.

One important thing to know up front: enabling the module is not enough on its own.
To get any effect you must **replace the menu blocks provided by core's System
module with the menu blocks this module provides**, then set the render limit on
that block. Until you do that swap, your menus render exactly as before.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. The render limit is
configured per block, on the block's own **Configure block** page, described below.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the menu, remove (or leave in place and replace)
   the existing core menu block, and **place the equivalent menu block provided by
   Menu Render Limited Items** instead. When you click *Place block*, look for the
   menu block offered by this module rather than the stock System one.
3. On the block's **Configure block** page, find the **render limit** setting and
   enter the maximum number of level‑one items to show. Enter `0` for unlimited.
4. Save the block. The menu now renders only up to that many top‑level items, while
   all the underlying menu links remain untouched in **Structure → Menus**.
