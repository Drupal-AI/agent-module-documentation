# Active menu item by path — manual setup guide

**Active menu item by path** (`active_menu_item_by_path`) fixes a common
annoyance with Drupal navigation: sometimes a menu link *should* look "current"
but doesn't, because Drupal's built-in active-trail detection didn't match the
page you are on. This happens with deep URL aliases, Views pages, and other
routes where the link's path and the current page's path don't line up exactly.

This module adds a second way to decide whether a menu link is in the active
trail: if the **current page's URL alias contains the link's path**, the link is
marked active. When that happens the link gets the standard active-trail flag,
which themes turn into the usual `menu-item--active-trail` class you can style.
It also adds a `url.path` cache context so the highlighting is calculated
correctly per page.

You choose which menus this applies to, so it only runs where you need it. It is
purely presentational — it changes nothing except whether a link is flagged as
current — and it requires Drupal 10. One thing to design around: matching is done
by substring, so a link path like `/a` would match a page at `/about`. Pick your
link paths with that in mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Active menu
settings** (`/admin/config/content/active-menu-settings`), reachable by users who
hold the **Access active menu settings** (`access active menu settings`)
permission.

## How to use it

1. Enable the module and grant **Access active menu settings** to the
   administrators who should manage it (**People → Permissions**).
2. Go to **`/admin/config/content/active-menu-settings`**. You'll see a checkbox
   for each of your site's menus.
3. **Tick the menus** that should get path-based active detection — for example
   your main navigation if its links are missing the active state on aliased or
   Views pages. Leave the rest unchecked so the module does no extra work for
   menus that don't need it.
4. **Save**, and clear the cache if the change doesn't appear immediately.

Only the menus you tick are processed, including their nested child items. Note
that the front-page (`<front>`) link is deliberately *not* highlighted by this
logic unless the current path is `/node/1`, so confirm this suits how your site's
front page is configured. To style the result, target the
`.menu-item--active-trail` class in your theme's CSS.
