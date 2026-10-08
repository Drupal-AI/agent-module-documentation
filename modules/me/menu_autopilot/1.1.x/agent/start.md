<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — agent index

**Automatic content-driven navigation menus** (children build themselves). Version **1.1.x**. Core `^10.6 || ^11.3`, PHP `>=8.1`. Depends on core `menu_link_content` and `node`.

You curate a menu's top level; each curated link can become a **dynamic parent** whose children are generated from published content and kept in sync automatically. Generated child links are ordinary `menu_link_content` entities storing a canonical `entity:node/<id>` URI (never `/node/N`), so every consumer — GraphQL, JSON:API, a Twig theme — sees one coherent tree. Headless-ready: multilingual, cache-tag revalidation.

- **Configure a dynamic parent + module settings** → [configure](configure/settings.md) — the menu-link "Automatic children" section, the 1.1 "Existing children" policies, and the settings page (managed menus, default sort/limit).
- **Drush commands** → [drush](drush/commands.md) — `ma:rebuild` (reconcile all), `ma:fix-uris` (normalize editorial URIs).
- **Programmatic API** → [api](api/sync-manager.md) — the `menu_autopilot.sync_manager` service (reconcile, sync a node/parent, normalize URIs).
- **Permission** → [permissions](permissions/permissions.md) — `administer menu autopilot`.
