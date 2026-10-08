<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced FileSystem (advanced_filesystem) — agent index

Enterprise file-management framework. **Core module only** — controls on-disk file paths, migrates/reorganizes files, and keeps `file_managed` in sync with disk. Version `1.0.27`, core `^10 || ^11 || ^12`, PHP `>=8.1`, license GPL-2.0-or-later, package Media.

- **Dependencies:** none (core only). Optional: `drush/drush` (CLI), `ext-gd`/`ext-exif` (image/EXIF hooks).
- **Configure:** `advanced_filesystem.strategy` → `/admin/config/media/advanced_filesystem/strategy`.
- **Permission:** all routes require `administer advanced filesystem` (`restrict access: true`), defined in `advanced_filesystem.permissions.yml`.
- **Config object:** `advanced_filesystem.settings` (schema in `config/schema/advanced_filesystem.schema.yml`).

## Provides

- **Plugin type `PathStrategy`** (annotation `@PathStrategy`, interface `AdvancedFilesystemPathManagerInterface`, manager service `plugin.manager.advanced_filesystem_path_strategy`, directory `src/Plugin/PathStrategy/`). 13 built-in strategies: `default`, `counted`, `flat`, `flat_named`, `date_hash`, `cdn_hash`, `content_type`, `mime_type`, `entity_bundle`, `field_name`, `user_role`, `locale_path`, `year`.
- **Routes** (`advanced_filesystem.routing.yml`, all `administer advanced filesystem`): `strategy`, `strategy_simulator`, `cron_migration`, `upload_migration`, `rollback`, `rewrite`, `dashboard`, `report`, `report_export`, `integrity`, `dry_run_results`, `ghost_scan`, `ghost_results`, `ghost_results_csv`, `ghost_delete_confirm`.
- **Services** (`advanced_filesystem.services.yml`): `path_strategy_manager`, `path_manager` (factory: active strategy), `audit_logger`, `orphan_checker`, `retention_runner`, `rollback`, `integrity_checker`, `deduplicator`, `perceptual_hasher`, `body_rewriter`, `duplicate_alert`, `sanitizer`, `duplicate_filename_resolver`, `metadata_stripper`, `content_aware_file_access`, `folder_size_reporter`, `preflight`, `doctor`, `storage_growth_reporter`, `dead_image_style_detector`, `file_dependency_resolver`, `duplicate_cleanup`.
- **Hooks** (`src/Hook/AdvancedFilesystemHooks.php`, legacy shims in `advanced_filesystem.module`): `file_validate`, `file_presave`, `file_insert`, `file_update`, `file_delete`, `file_download`, `entity_presave`, `cron`, `mail`.
- **Drush** (`drush.services.yml`, `src/Commands/AdvancedFilesystemCommands.php`): `advanced_filesystem:migrate-files`, `:check-orphans`, `:run-retention`, `:rollback`, `:check-integrity`, `:dedupe`, `:rewrite`, `:folder-report`, `:doctor`.
- **QueueWorker** `advanced_filesystem_rewrite` (`src/Plugin/QueueWorker/AdvancedFilesystemRewriteWorker.php`).
- **DB tables** (`advanced_filesystem.install`): `advanced_filesystem_migration_map`, `advanced_filesystem_file_hashes`, `advanced_filesystem_phash`, plus ghost-scan results table.

## Submodules (documented separately)

The project ships 26 optional submodules under `modules/` — NOT covered here: `advanced_filesystem_access`, `advanced_filesystem_ai_alt_text`, `advanced_filesystem_ai_embeddings`, `advanced_filesystem_ai_smart_image`, `advanced_filesystem_ai_transcription`, `advanced_filesystem_antivirus`, `advanced_filesystem_archive`, `advanced_filesystem_audio_processor`, `advanced_filesystem_backup`, `advanced_filesystem_cdn`, `advanced_filesystem_cleanup`, `advanced_filesystem_dedup`, `advanced_filesystem_document_processor`, `advanced_filesystem_image_optimizer`, `advanced_filesystem_lgpd_gdpr`, `advanced_filesystem_lifecycle_manager`, `advanced_filesystem_metadata`, `advanced_filesystem_pdf_processor`, `advanced_filesystem_presentation_processor`, `advanced_filesystem_quota`, `advanced_filesystem_remote_sync`, `advanced_filesystem_reports`, `advanced_filesystem_smart_image`, `advanced_filesystem_upload_directory`, `advanced_filesystem_video_processor`, `advanced_filesystem_webhooks`.

## Solution docs

- [config/settings.md](config/settings.md) — install, the `advanced_filesystem.settings` config object, feature toggles, routes and permission.
- [plugins/path_strategy.md](plugins/path_strategy.md) — the `PathStrategy` plugin type, built-in strategies, and writing your own.
- [api/services.md](api/services.md) — core services, hooks, migration/rollback flow, and Drush commands.
