<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot (menu_autopilot) — agent index

**Automatic content-driven navigation menus** (children build themselves). Version **1.4.x** (release 1.4.1). Core `^10.6 || ^11.3`, PHP `>=8.1`. Depends on core `menu_link_content` and `node`.

You curate a menu's top level; each curated link can become a **dynamic parent** whose children are generated from published content and kept in sync automatically. Generated child links are ordinary `menu_link_content` entities storing a canonical `entity:node/<id>` URI (never `/node/N`), so every consumer — GraphQL, JSON:API, a Twig theme — sees one coherent tree. Headless-ready: multilingual, canonical URLs.

Per-link config and managed-child bookkeeping live in an **internal** `menu_autopilot` map base field on `menu_link_content`, with a queryable `menu_autopilot_dynamic` boolean marker (both installed in code by `menu_autopilot_install()`). The heavy lifting is in `NavSourceResolver` (source → published node ids) and `NavSyncManager` (reconcile).

- **Configure a dynamic parent + module settings** → [configure](configure/settings.md) — the menu-link "Menu Autopilot: children of …" section, the "Existing children" policies, the "Keep current order" sort, the "Child menu label" token pattern, and the settings page (managed menus, default sort/limit).
- **Drush commands** → [drush](drush/commands.md) — `ma:rebuild` (reconcile all + report disabled children), `ma:fix-uris` (normalize editorial URIs).
- **Programmatic API** → [api](api/sync-manager.md) — the `menu_autopilot.sync_manager` and `menu_autopilot.source_resolver` services (reconcile, sync a node/parent, normalize URIs, `parentStatus()`).
- **Permission** → [permissions](permissions/permissions.md) — `administer menu autopilot`.
- **Optional MCP submodule** → [menu_autopilot_mcp](../../modules/menu_autopilot_mcp/1.4.x/agent/start.md) — three MCP Sentinel-governed Tool API plugins (status, link-info, normalize-uris).

## Diff 1.2.x → 1.4.x

Real changes (from `CHANGELOG.md`, releases 1.3.0–1.4.1):

- **Internal fields locked down (1.4.0).** `menu_autopilot_entity_field_access()` now forbids `view` and `edit` on `menu_autopilot` and `menu_autopilot_dynamic` for every account, closing an API-client write path (the `setInternal(TRUE)` flag kept them out of output but did not stop a PATCH). The module's own in-code writes are unaffected.
- **Disabled-by-save handling (1.4.0).** When another module forces a managed child to disabled during the sync's own save, `NavSyncManager` reloads after each save, logs a warning (parent, node, acting account), records `disabled_by_save` in the map, and a later sync by an account that may enable menu links re-enables it (once per account per request). A sync never enables a link an editor disabled. `disabledManagedChildren()` and `parentStatus()` surface these; `ma:rebuild` and the parent form list them.
- **New public method `NavSyncManager::parentStatus()`** — a bounded, read-only report of dynamic parents and their child counts (the method the MCP tools read).
- **Optional `menu_autopilot_mcp` submodule added (1.4.0)** — three Tool API plugins governed by MCP Sentinel. Base module gains no dependency.
- **1.3.x:** dynamic parents found via the queryable `menu_autopilot_dynamic` marker (added in `menu_autopilot_update_10201`) instead of hydrating every link; children loaded once and partitioned in memory; clearing a source releases (keeps) owned children; deleting a dynamic parent deletes its generated children; term source made genuinely optional (no taxonomy widgets/queries when Taxonomy is absent) and leftover term sources no longer wipe children when Taxonomy is gone.
- **1.4.1:** an empty `managed_menus` list now means *no* menus (only a missing value falls back to `main`).

Two new sync-manager service arguments (`@current_user`, `@logger.channel.menu_autopilot`); an empty post-update rebuilds the container. Run `drush updb` (or a cache rebuild) after updating code.
