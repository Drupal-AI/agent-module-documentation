<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — agent index

**Automatic content-driven navigation menus** (children build themselves). Version **1.2.x** (release 1.2.3). Core `^10.6 || ^11.3`, PHP `>=8.1`. Depends on core `menu_link_content` and `node`.

You curate a menu's top level; each curated link can become a **dynamic parent** whose children are generated from published content and kept in sync automatically. Generated child links are ordinary `menu_link_content` entities storing a canonical `entity:node/<id>` URI (never `/node/N`), so every consumer — GraphQL, JSON:API, a Twig theme — sees one coherent tree. Headless-ready: multilingual, cache-tag revalidation.

- **Configure a dynamic parent + module settings** → [configure](configure/settings.md) — the menu-link "Menu Autopilot: children of …" section, the "Existing children" policies, the "Keep current order" sort, the "Child menu label" token pattern, and the settings page (managed menus, default sort/limit).
- **Drush commands** → [drush](drush/commands.md) — `ma:rebuild` (reconcile all), `ma:fix-uris` (normalize editorial URIs).
- **Programmatic API** → [api](api/sync-manager.md) — the `menu_autopilot.sync_manager` service (reconcile, sync a node/parent, normalize URIs).
- **Permission** → [permissions](permissions/permissions.md) — `administer menu autopilot`.

## Diff 1.1.x → 1.2.x

Real changes in this branch (from `CHANGELOG.md`, releases 1.2.0–1.2.3):

- **Keep current order (`preserve`) sort** added on term and bundle sources. Automatic children are still added, removed, and retitled from the source, but existing weights are left alone so editors can drag the menu overview into a custom order; newly matching children append after the current maximum weight. A→Z and date sorts still rewrite weights on every sync. Manual (hand-picked) sources always follow the node list and ignore a leftover `preserve` value.
- **"Child menu label"** is the new name for the token pattern field (was "Child link title"), with an example that includes a subtitle field: `[node:title] [node:field_subtitle]`.
- The parent-link settings section is now titled **"Menu Autopilot: children of [this item]"** (was "Automatic children"), so it is obvious which module owns the controls. The menu-overview form and the managed-child form also point editors at the parent's section.
- **Token label rendering switched to plain text** (`Token::replacePlain`) so an ampersand in a node title or subtitle is no longer stored as `&amp;` on the menu link (1.2.2).
- **Node-edit-form integration reworked.** The node form no longer treats an automatic child as that node's own "Provide a menu link" item; label and order stay on the parent. Node-form sync is deferred until after menu_ui's submit handler (via `#after_build` + a queued flush), fixing fatals when archiving/unpublishing a node (1.2.0) and a pending-revision menu constraint plus `#parents` warnings when saving fields on an automatic child (1.2.1, 1.2.3).

No new routes, permissions, services, config keys, or Drush commands were added versus 1.1.x — the changes are behavior and UI refinements. The `sort` option set gains `preserve`.
