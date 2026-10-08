<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enhanced Taxonomy Manager (enhanced_taxonomy_manager) — agent index

Project machine name is **`etm`**; the **module** machine name is **`enhanced_taxonomy_manager`** —
the info file, routes, services and permissions all use the long form. Version **2.2.1**
(version dir `2.2.x`). Core `^10 || ^11`. Depends only on core **`taxonomy`**. Package `Taxonomy`.
License GPL-2.0-or-later.

## What it is

Replaces core's term overview with a lazy-loading, drag-and-drop tree at
`/admin/structure/taxonomy/{taxonomy_vocabulary}/tree`, plus a dashboard at
`/admin/structure/taxonomy/etm-dashboard` and settings at
`/admin/config/content/enhanced-taxonomy-manager`. Adds rename, merge, clone, find & replace,
bulk ops, CSV import/export, per-vocabulary stats, health check, revisions, undo and named
snapshots. Vanilla JS (no jQuery for the UI logic); bundles SortableJS (`libraries/sortablejs/`,
MIT) for drag-and-drop.

## Provides

- **~40 routes** (`enhanced_taxonomy_manager.routing.yml`), almost all AJAX JSON endpoints. See
  [agent/routes/reference.md](routes/reference.md).
- **5 controller services** — `DashboardController`, `TreeController`, `TermController`,
  `SnapshotController`, `ExportImportController`, all extending `EtmControllerBase`
  (`enhanced_taxonomy_manager.services.yml`). Shared logic in the base:
  snapshot/undo capture & restore, revision logging, cycle detection, sibling-weight
  normalization, CSRF validation. See [agent/api/controllers.md](api/controllers.md).
- **6 forms** — `SettingsForm`, `TermForm`, `TermEditForm`, `MergeTermsForm` (ConfirmForm,
  reassigns references + reparents children in a transaction), `RestoreSnapshotForm` (batch),
  `NormalizeWeightsForm`.
- **Custom access check** `_etm_access` → `EtmAccessCheck` (service
  `enhanced_taxonomy_manager.access_checker`); plus `EtmAccessCheck::exportAccess` /
  `::importAccess` used via `_custom_access`.
- **Dynamic per-vocabulary permissions** via `EtmPermissions::vocabularyPermissions`
  (`enhanced_taxonomy_manager.permissions.yml`): `etm manage terms in {vid}`,
  `etm export terms in {vid}`, `etm import terms in {vid}`. See [agent/config/settings.md](config/settings.md).
- **2 database tables** (`hook_schema` in `.install`): `enhanced_taxonomy_snapshots`,
  `enhanced_taxonomy_revisions`. Dropped on uninstall; rows purged on
  `hook_taxonomy_vocabulary_delete`.
- **Config** `enhanced_taxonomy_manager.settings` (+ schema). See [agent/config/settings.md](config/settings.md).
- **Hooks** (OO `#[Hook]` in `src/Hook/EnhancedTaxonomyManagerHooks.php`, procedural
  `#[LegacyHook]` wrappers in `.module`): `theme` (`taxonomy_tree_view`,
  `taxonomy_tree_view_term`), `entity_operation` (adds "Tree View" op to each vocabulary),
  `taxonomy_vocabulary_delete`.
- **Drush commands** `etm:generate` / `etm:purge` (`src/Drush/Commands/EtmCommands.php`). See
  [agent/drush/commands.md](drush/commands.md).
- **Libraries** `taxonomy_manager`, `dashboard`, `sortable` (`enhanced_taxonomy_manager.libraries.yml`).

## Submodule

**`etm_ai`** (separate enable; depends on `ai:ai`) — AI term generation, placement suggestions,
semantic duplicate detection, auto-description, health analysis, restructuring, template mapping,
chat commander, natural-language search, auto-tag, relationship mapping. Documented at
`modules/et/etm/modules/etm_ai/2.2.x/`.

## Solution docs

- [agent/routes/reference.md](routes/reference.md) — every route, method, controller/form and access requirement.
- [agent/api/controllers.md](api/controllers.md) — controllers, `EtmControllerBase` shared API, snapshots/undo/revisions model, merge.
- [agent/config/settings.md](config/settings.md) — config object, schema keys, permissions, access model.
- [agent/drush/commands.md](drush/commands.md) — `etm:generate`, `etm:purge`.
