<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia DAM Asset Importer (acquiadam_asset_import) — agent index

Bulk-imports assets from named **Acquia DAM (Widen) categories** into Drupal **media entities** on cron.
Package `Media`. Core `^10.1 || ^11`. License GPL-2.0-or-later. Version 2.0.0-beta2.
**Deprecated / obsolete** (absorbed into the Acquia DAM project).

- **Config form, cron importer, and queue worker — how to set it up and operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- A thin extension of **`media_acquiadam`** (its only dependency, `>=2.0`; composer `drupal/media_acquiadam:^2.0`).
  All DAM authentication and asset/file downloading live in `media_acquiadam` — this module only queries category
  listings and creates media entities.
- **No permissions, no Drush, no plugin types, no config schema, no public routes.** One admin settings route.

## Pieces it provides (from source)

- Service **`acquiadam_asset_import.damimporter`** → `src/DamImporter.php` (`DamImporter`). Args:
  `@media_acquiadam.acquiadam`, `@queue`, `@database`, `@config.factory`.
- Queue worker plugin **`dam_worker`** → `src/Plugin/QueueWorker/DamWorker.php` (`cron = {"time" = 120}`);
  `processItem()` creates a `media` entity.
- Config form **`DamImport`** (form id `dam_categories`) → `src/Form/DamImport.php`, at route
  **`acquiadam_asset_import.dam_import`** = `/admin/config/media/damimport`, permission
  **`administer site configuration`** (menu link under *Configuration → Media*).
- `hook_cron()` in `acquiadam_asset_import.module` → calls `DamImporter::import()`.
- `hook_update_8001()` in `.install` → renames config key `folders` → `categories`.

## Config & fields

- Config object **`acquiadam_asset_import.config`** (no schema/install shipped): `categories` (newline-separated
  category names), `bundle` (target media type), `enable` (bool).
- Expects an **`acquiadam_asset` media source** bundle with a **`field_acquiadam_asset_id`** field (provided by
  `media_acquiadam`); imports are deduped against `media__field_acquiadam_asset_id`.

Details, mechanism, and operating notes → [config/settings.md](config/settings.md).
