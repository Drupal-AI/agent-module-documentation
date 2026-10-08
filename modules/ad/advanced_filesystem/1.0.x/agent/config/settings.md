<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & permission

## Install / enable

```
drush en advanced_filesystem -y
```

No module dependencies (Drupal core only). PHP `>=8.1`. `ext-gd` is needed for EXIF stripping and perceptual hashing; `drush/drush` for the CLI commands. Enabling `hook_install`/`hook_schema` (`advanced_filesystem.install`) creates the tables `advanced_filesystem_migration_map` (fid → original/new path, timestamp), `advanced_filesystem_file_hashes` (fid → SHA-256), `advanced_filesystem_phash` (fid → perceptual hash), and the ghost-scan results table.

## Permission

One permission, in `advanced_filesystem.permissions.yml`:

- `administer advanced filesystem` — `restrict access: true`. **Every** route in `advanced_filesystem.routing.yml` requires it; there are no anonymous or lower-privilege routes.

## Config object: `advanced_filesystem.settings`

Single config object (default values in `config/install/advanced_filesystem.settings.yml`, typed schema in `config/schema/advanced_filesystem.schema.yml`). Key groups:

- `path_strategy` (string) — active strategy plugin id (default `default`).
- Per-strategy setting maps: `default`, `counted` (`max_files_per_dir`), `flat`, `flat_named` (`folder`), `entity_bundle`, `cdn_hash`, etc. — each has a `scheme` (stream-wrapper override; empty = use the field's `uri_scheme`).
- `sanitizer` — `enabled`, `lowercase`, `separator`, `strip_dots_in_name`, `max_length`.
- `duplicate_resolver.enabled` — auto-rename colliding filenames on upload.
- `metadata_stripper` — `enabled`, `mime_types`, `jpeg_quality`.
- `dedup_on_upload` / `phash_on_upload` — `enabled`, `action` (`warn`|`block`), `threshold` (phash Hamming distance, clamped 0–30).
- `duplicate_alert` / `orphan_check` — `enabled`, `threshold`, `interval`, `notify_interval`, `recipients`, `notify_role`, plus optional `email.subject`/`email.body`.
- `cron_migration` — `enabled`, `interval`, `strategy`, `strategy_settings`, `delete_original`, `max_per_run`, `field_rules` (per entity_type/field rules with own interval).
- `upload_migration` — `enabled`, `strategy`, `delete_original`, `field_rules` (per-field rules applied in `hook_entity_presave`).
- `retention` — `enabled`, `age_days`, `action` (`delete`|move), `move_destination`, `max_per_run`, `interval`, `dry_run`, `notify`, `recipients`, `notify_role`, `rules`.
- `private_file_access` — `enabled`, `log_denials`, `allow_uid1`, `allow_permission` (see below).
- `storage_growth` — `enabled`, `max_snapshots`.

## Content-aware private file access

When `private_file_access.enabled` is TRUE, `hook_file_download` (delegated to `ContentAwareFileAccessChecker`) grants a private file only if the requesting user has `view` access to at least one content entity that references the file through a file/image field; it denies when references exist but none are viewable, and abstains (lets other modules decide) when the feature is off or the file is unreferenced. `allow_uid1` grants user 1 unconditionally; `allow_permission` names a permission that bypasses the check. This is opt-in and off by default.

## Routes

Configuration (`/admin/config/media/advanced_filesystem/…`): `strategy` (main config form — the `configure` route), `simulator`, `cron-migration`, `upload-migration`, `rollback`, `rewrite`, `ghost-scan`, `ghost-results` (+ `/csv`), `ghost-delete-confirm`, `dry-run-results`.

Reports (`/admin/reports/advanced_filesystem/…`): `dashboard`, `files` (report), `export/{format}` (`format` matched by `\w+`; only `csv` produces CSV, anything else returns JSON), `integrity`.

Menu links: `advanced_filesystem.links.menu.yml` (Configuration + Reports entries) and `advanced_filesystem.links.task.yml` (local tabs). Dashboard CSS library `advanced_filesystem/dashboard` (`advanced_filesystem.libraries.yml`).
