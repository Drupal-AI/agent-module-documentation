# Menu Autopilot — manual setup guide (1.0.x)

**Menu Autopilot** (`menu_autopilot`) turns Drupal navigation into an automatic,
content-driven system. You curate your top-level menu the way you always have,
then let each item's children build and maintain themselves from your published
content. Publish a new product, article, or landing page and it appears under the
right menu item automatically; unpublish it and it disappears. It is to
navigation what Pathauto is to URL aliases: the automatic, config-driven default.

The problem it solves is the busywork and fragility of hand-curated menus. On
content-heavy or decoupled sites, editors spend real time redoing navigation to
mirror content, and in a headless build a hand-placed link is easy to point at the
wrong URL. Existing taxonomy-menu modules generate items from *terms*; Menu
Autopilot generates children from *content nodes* under a curated parent, with
clean, headless-ready URLs. You choose the source per item — a taxonomy term, a
content type, or a hand-picked ordered list of nodes — and control the order and
labels. Generated links use canonical entity references, so they resolve to your
real path alias, never `/node/123`.

Because it produces ordinary menu links, the composed tree is exposed by any
consumer — GraphQL, JSON:API, or a classic Drupal theme — with no extra work, and
synced links are translatable and language-aware. It depends on core's **Menu
Link Content** (`menu_link_content`) and **Node** (`node`) modules, and requires
Drupal 10.6+ or 11.

> **Branch note (1.0.x).** This is the initial release branch. It manages a
> parent's children from the menu-link edit form and reconciles on demand with
> `drush menu-autopilot:rebuild`. The later **1.1.x** branch adds a dedicated
> settings page (choosing which menus are managed, plus default sort/limit),
> explicit "existing children" policy options and a reparent option on the
> menu-link form, a `drush menu-autopilot:normalize-uris` command, and a
> documented permission and API. If you need those, install 1.1.x.

Menu Autopilot does not do anything on enable alone — you have to mark a menu link
as a dynamic parent and choose its source. That setup is covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — turn a menu link into a dynamic
   parent, choose its content source, and keep menus in sync.

## Where it lives in the admin menu

You work entirely from the standard menu system at **Structure → Menus**
(`/admin/structure/menu`): edit a top-level menu link and open its **Menu
Autopilot: children of …** section to choose a content source.
