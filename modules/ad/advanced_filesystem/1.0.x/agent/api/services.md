<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, hooks & CLI

All services are declared in `advanced_filesystem.services.yml`; hook logic lives in `src/Hook/AdvancedFilesystemHooks.php` (OO hooks via `#[Hook]`) with `#[LegacyHook]` shims in `advanced_filesystem.module`.

## Core services

- `advanced_filesystem.path_strategy_manager` (`AdvancedFilesystemPathStrategyManager`) — resolves/instantiates the active strategy; `path_manager` is a factory service returning `getActiveStrategy()`.
- `advanced_filesystem.audit_logger` (`AuditLogger`) — records migration/rollback/dedupe/retention actions (DB + logger channel `advanced_filesystem`).
- `advanced_filesystem.orphan_checker` (`OrphanChecker`) — finds files not referenced by any entity; `runCron()` throttles by `orphan_check.interval` and emails `recipients`/`notify_role`.
- `advanced_filesystem.retention_runner` (`RetentionRunner`) — applies age-based delete/move rules on cron; dispatches events and audit entries.
- `advanced_filesystem.rollback` (`RollbackService`) — reverts recorded migrations using `advanced_filesystem_migration_map`.
- `advanced_filesystem.integrity_checker` (`IntegrityChecker`) — compares every `file_managed` row's URI and size against disk.
- `advanced_filesystem.deduplicator` (`Deduplicator`) — SHA-256 hashing (`computeHashForFid`), `findDuplicateGroups()`, `pruneStaleHashRows()`.
- `advanced_filesystem.perceptual_hasher` (`PerceptualHasher`) — dHash + union-find grouping of visually similar images.
- `advanced_filesystem.body_rewriter` (`BodyReferenceRewriter`) — rewrites old→new file URLs embedded in text/link fields after a migration (backs the `advanced_filesystem_rewrite` queue worker).
- `advanced_filesystem.sanitizer` (`FilenameSanitizer`), `.duplicate_filename_resolver` (`DuplicateFilenameResolver`), `.metadata_stripper` (`MediaMetadataStripper`) — the three on-upload `hook_file_presave` transforms.
- `advanced_filesystem.content_aware_file_access` (`ContentAwareFileAccessChecker`) — private-file `hook_file_download` decisions (see config/settings.md).
- Reporting helpers: `.folder_size_reporter`, `.storage_growth_reporter`, `.file_dependency_resolver`, `.dead_image_style_detector`, `.duplicate_alert`, `.preflight` (`MigrationPreflightChecker`), `.doctor` (`DoctorService`, a health check over stream wrappers, config, routes and system binaries).

## Hooks

- `hook_file_validate` — exact-duplicate (SHA-256) and perceptual-similarity checks; `warn` adds a message, `block` rejects the upload (only when the respective `*_on_upload.enabled` toggle is on).
- `hook_file_presave` — filename sanitize → duplicate-name resolve → metadata strip → global on-upload migration (`_advanced_filesystem_migrate_file_on_upload()`), only for files transitioning to permanent.
- `hook_entity_presave` — per-field on-upload migration rules (`upload_migration.field_rules`); only newly-attached fids are moved.
- `hook_file_insert`/`hook_file_update` — cache SHA-256 hash for permanent files.
- `hook_file_delete` — remove hash + phash rows for the deleted fid.
- `hook_file_download` — content-aware private file access.
- `hook_cron` — orphan check, retention run, storage-growth snapshot, global + per-field cron migration, duplicate alert (each interval-throttled via State).
- `hook_mail` — `orphan_alert`, `duplicate_alert`, `retention_report` message bodies.

## Migration / rollback flow

1. Pick a strategy on `advanced_filesystem.strategy`; optionally dry-run (`AdvancedFilesystemDryRunBatch`) → results at `advanced_filesystem.dry_run_results`.
2. Run the migration batch (`AdvancedFilesystemMigrationBatch`) — moves files with `FileExists::Rename`, updates `file_managed` URIs, records each move in `advanced_filesystem_migration_map`.
3. Optionally rewrite embedded URLs (`advanced_filesystem.rewrite` / `AdvancedFilesystemRewriteBatch`).
4. Roll back via `advanced_filesystem.rollback` (`AdvancedFilesystemRollbackBatch`) to restore original paths from the map.

Ghost files: `advanced_filesystem.ghost_scan` runs `AdvancedFilesystemGhostScanBatch` (records missing/orphan rows), results paginate at `advanced_filesystem.ghost_results` with CSV export; deletion goes through the `AdvancedFilesystemGhostDeleteForm` confirmation step (a `ConfirmFormBase`, IDs held in PrivateTempStore) which removes DB rows for `missing` entries and unlinks disk files for `orphan` entries.

## Drush commands (`src/Commands/AdvancedFilesystemCommands.php`)

`advanced_filesystem:migrate-files` (`--strategy`, `--choose-strategy`, `--delete`, `--dry-run`, `--target_field`), `:check-orphans` (`--notify`), `:run-retention` (`--dry-run`, `--list`, `--list-rules`), `:rollback` (`--since`, `--until`, `--dry-run`, `--force`, `--rewrite-bodies`), `:check-integrity`, `:dedupe` (`--skip-hash`, `--no-mark-temporary`, `--dry-run`), `:rewrite` (`--dry-run`, `--all-revisions`, `--entity-type`, `--field`, `--list`), `:folder-report` (`--scheme`, `--depth`, `--files`, `--ext`, `--top`), `:doctor` (`--strict`).

## Events

`src/Event/AdvancedFilesystemEvents.php` defines event name constants; `AdvancedFilesystemEvent` is the dispatched object. Retention, rollback, dedupe and body-rewrite services dispatch these so other code can react to file operations.
