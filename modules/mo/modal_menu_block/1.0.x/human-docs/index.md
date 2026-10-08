# Modal Menu Block — manual setup guide

**Modal Menu Block** (`modal_menu_block`) provides a block that displays any of
your site's menus inside a modal/overlay. Instead of showing a menu inline in a
region, the block renders a trigger (typically a button) that opens the chosen
menu in a pop-up modal — a common pattern for a full-screen mobile navigation
menu or an overlay "hamburger" menu.

The module is intentionally small. It adds a new block type you place through
the normal Block Layout UI, it has no dependencies beyond Drupal core, and it
works on Drupal 9.4, 10, and 11. The menu it displays follows Drupal's normal
menu access — links a visitor cannot reach are not shown — so the module itself
plays no access-control role; it is purely a navigation/UI feature.

There is no global settings page. All of the setup happens on the block itself
when you place and configure it, so this guide folds the "how to use it" steps
into this page rather than a separate configuration chapter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **A note on release status:** at the time of writing this project is at an
> alpha release (1.0.0-alpha5) and is **not covered by Drupal's security
> advisory policy**. Test it on a non-production environment first and keep that
> in mind before relying on it for a public site.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You configure everything on
the block itself, as described in "How to use it" below.

## Where it lives in the admin menu

Modal Menu Block adds no admin settings page of its own. You work with it
entirely from **Structure → Block layout** (`/admin/structure/block`), where you
place the modal menu block into a region and choose which menu it shows.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Choose the region where the trigger should appear (for example a header or
   navigation region) and click **Place block**.
3. Find the **Modal Menu Block** in the list and place it.
4. In the block's configuration, pick the **menu** you want to display in the
   modal, set the block title/label, and adjust the usual block visibility
   settings (pages, roles, content types) as needed.
5. Save the block. Visitors now see the trigger in that region; activating it
   opens the selected menu in a modal overlay.

Because the block renders a standard Drupal menu, the links it shows honor each
visitor's menu access automatically.
