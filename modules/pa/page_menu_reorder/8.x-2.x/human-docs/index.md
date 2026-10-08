# Page Menu Reorder — manual setup guide

**Page Menu Reorder** (`page_menu_reorder`) lets editors rearrange menu links by
drag‑and‑drop, in context, rather than through the central menu administration
page. When a page has menu links, the module adds a **Reorder menu** tab to that
page; an editor drags items into the order they want and saves. It is the Drupal 8+
successor to the old Drupal 7 *Submenu Reorder* module.

This solves two everyday problems. On a large site the main menu admin page
(`/admin/structure/menu/manage/main`) can hold hundreds of links, which makes
reordering awkward — reordering in context is far quicker. And in setups where you
must **restrict access to the global menu admin page**, this module lets trusted
editors reorder links without handing them the keys to menu administration. Out of
the box it works with the primary **Main navigation** menu.

Because reordering navigation is a privileged action, the module ships its own
permission — grant it only to editors you trust.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant the reorder permission and open
   the module's settings.

## Where it lives in the admin menu

The module's settings form is provided at the config route
`page_menu_reorder.admin_settings`. Day‑to‑day, editors use the **Reorder menu**
tab that appears on pages that have menu links. The permission is set under
**People → Permissions** (`/admin/people/permissions`).
