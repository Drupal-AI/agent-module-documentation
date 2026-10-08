# Menu Trail By Path — manual setup guide

**Menu Trail By Path** (`menu_trail_by_path`) sets the active menu trail — the
highlighted menu item and the core breadcrumb — from the **URL path hierarchy**
rather than only from direct menu links. Out of the box, Drupal highlights a menu
item only when a menu link points straight at the page you are on. That leaves the
many pages you deliberately keep out of the menu (blog articles, taxonomy pages,
referenced nodes) with no active highlighting at all.

This module fixes that by walking the current URL. For a page at `/about/team` it
looks for menu links at `about` and `about/team` and activates whichever exist —
so a "Team" page that isn't in the menu still lights up its logical parent, the
**About** menu item, and expands the menu accordingly. Because it works purely from
the URL, it pairs naturally with path-structured aliases (for example those
produced by Pathauto).

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to tuning how the
trail is resolved. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Menu Trail By Path Settings page](images/settings.png)

## Where it lives in the admin menu

The module adds a single settings page at **Configuration → System → Menu Trail By
Path** (`/admin/config/system/menu_trail_by_path/settings`). There are no tabs and
no separate list screens — everything the module exposes globally lives on that one
form. Individual menus can additionally override the behavior from their own edit
screen under **Structure → Menus**.

The module has no dependencies and defines no permissions of its own; the settings
page uses core's **Administer site configuration** permission.

## Contents

1. [Installation](installation/index.md) — install Menu Trail By Path with Composer
   and enable it.
2. [Configuration](configuration/index.md) — choose how the active trail is derived
   from the URL and bound its performance cost.
