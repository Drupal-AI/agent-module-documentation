<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trash (trash) — agent index

Soft-deletes SQL-backed content entities into a recycle bin instead of removing them, so they
can be restored or permanently purged later. No module dependencies. Core requirement
`^11.3.3 | ^12`. License GPL-2.0-or-later. Version 3.1.0.

Settings UI: **Admin → Configuration → Content authoring → Trash** (`/admin/config/content/trash`,
route `trash.settings.form`, permission `administer trash`). Trash listing:
`/admin/content/trash` and `/admin/content/trash/{entity_type_id}`
(route `trash.admin_content_trash[_entity_type]`, permission `access trash+administer trash`).

## What it actually is (from source)

- On `hook_entity_type_alter` (`src/Hook/TrashEntityInfoHooks.php`) Trash renders a storage
  **subclass** for each enabled entity type (Twig template `templates/TrashStorage.php.twig`,
  cached via `PhpStorageFactory::get('trash')`) that overrides `delete()` to stamp a
  translatable/revisionable `deleted` timestamp base field instead of removing the row. So
  `$entity->delete()` — and deletions from any other module — are intercepted. Limited to
  `SqlContentEntityStorage`-based types (`TrashManager::isEntityTypeSupported()`).
- A global **trash context** (`active` / `inactive` / `ignore`) on `TrashManager` decides
  whether entity and Views queries hide trashed rows and whether a delete soft-deletes or
  hard-deletes. See [api/trash-manager.md](api/trash-manager.md).
- Per-entity-type **trash handlers** (tagged `trash_handler`) hold the type-specific
  delete/restore logic; core ships handlers for node, taxonomy_term, menu_link_content, file,
  path_alias, redirect (`src/Hook/TrashHandler/`). See [extend/trash-handler.md](extend/trash-handler.md).

## Capabilities

- Enable entity types/bundles, auto-purge, compact overview → [configure/settings.md](configure/settings.md)
- Soft-delete / restore / purge / context API in code (`TrashManager`, static `Trash`) → [api/trash-manager.md](api/trash-manager.md)
- Add trash support to a custom entity type (handler) → [extend/trash-handler.md](extend/trash-handler.md)
- React to trash/restore events (hooks in `trash.api.php`) → [hooks/hooks.md](hooks/hooks.md)
- Drush commands (restore / purge / export-views) → [drush/commands.md](drush/commands.md)
- Permissions (static + dynamic per-type/per-translation) → [permissions/permissions.md](permissions/permissions.md)
- Restore/purge forms, bulk actions, Views field & search integration → [plugins/operations.md](plugins/operations.md)

## Provides

- Services: `trash.manager` (`TrashManagerInterface`), `TrashEntityPurger`, `TrashViewBuilder`,
  `TrashCliActions`, decorators for `entity_type.manager`, `cache.entity`, `entity.memory_cache`,
  a trash-aware `UniqueFieldValueValidator`, event subscribers, a route subscriber, a
  `route_processor_outbound`, a `TrashEntityConverter` param converter, and an uninstall validator.
- Plugins: actions `entity:restore_action` / `entity:purge_action` (per-type derivatives),
  queue worker `trash_entity_purge`, Views field `TrashOperations`, field formatter
  `trash_label`, search plugin `TrashNodeSearch`, search_api processor `TrashStatus`,
  validation constraint `ValidAutoPurgePeriod`, local-task derivative `TrashLocalTasks`.
- Config object `trash.settings` (+ schema). Permissions in `trash.permissions.yml`.
- Static helper `Drupal\trash\Trash` (`entityIsDeleted()`, `entityHasDeletedTranslations()`,
  `entityHasAllTranslationsDeleted()`, `restoreEntity()`).
