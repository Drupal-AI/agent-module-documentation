<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provus Mega Menu — manual setup guide

**Provus Mega Menu** (`provus_mega_menu`) is a presentation module for the **Provus**
base theme (the theme behind Provus Gov). It renders your site's main menu as a
full-width, multi-column "mega menu," with optional callout image and link panels on
top-level dropdowns and small icons next to child links. It is aimed squarely at
government and institutional sites that need a structured, accessible mega menu without
building one from scratch.

This is a thin theming layer, not a configurable feature. It ships a single Twig
template that overrides how [Menu Item Extras](https://www.drupal.org/project/menu_item_extras)
renders the menu, plus a Bootstrap-style CSS/JS library for the layout, column
behavior, and keyboard/hover interactions. It also tidies up the menu-link edit form so
the right fields appear in the right place: the callout image and link fields only show
on **top-level** menu items, and the icon field only shows on **child** items.

One important thing to understand: the callout and icon fields it reads
(`field_provus_menu_callout_image`, `field_provus_menu_callout_link`,
`field_provus_menu_icon`) are **not created by this module**. They come from the Provus
distribution/recipe and are attached to your menu link content. This module simply
renders them. That is also why it is designed to run **inside the Provus base theme** —
outside it, the expected CSS/JS and fields will be missing and the menu will not look
or behave as intended.

There is no settings form, no permission, and no Drush command. You "configure" the
menu by editing your menu links and filling in the callout/icon fields; the module
handles the rest through its template and assets. This guide therefore folds the
"how to use it" details into this page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Menu Item Extras, within a Provus theme).

## Where it lives in the admin menu

The module adds no admin page of its own. Its effect appears on your rendered main
menu, and the callout/icon fields it toggles appear on the menu-link edit form at
**Structure → Menus → Main navigation** (`/admin/structure/menu`) when you add or edit
a link.

## How to use it

1. Make sure your site runs the **Provus base theme** and that the Provus callout/icon
   fields exist on the main menu's link content (they come with the Provus
   distribution/recipe).
2. Enable this module. The main menu is now rendered with the mega-menu template and
   assets.
3. Edit a **top-level** main-menu link (**Structure → Menus → Main navigation**). You
   can fill in a **callout image** and **callout link** — these appear in the
   right-hand panel of that item's dropdown. These fields are hidden on child items.
4. Edit a **child** menu link. You can set an **icon** (`field_provus_menu_icon`),
   which renders next to the link. This field is hidden on top-level items.
5. View the site — the main menu now displays as a full-width, multi-column mega menu
   with your callouts and icons. The callout panel is intentionally hidden on small
   screens and shown on large ones.
