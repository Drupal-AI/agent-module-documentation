<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_guardian — settings, cron, retention

Config object `config_guardian.settings` (schema in `config/schema/`, defaults in
`config/install/`). Edited at `/admin/config/development/config-guardian/settings`
(`administer config guardian`). Read via `SettingsService`.

| Key | Default | Meaning |
|---|---|---|
| `auto_snapshot_enabled` | `true` | Enable cron-driven `auto` snapshots |
| `auto_snapshot_before_import` | `true` | Create a `pre_import` snapshot on config import |
| `auto_snapshot_interval` | `daily` | `hourly` / `daily` / `weekly` |
| `max_snapshots` | `50` | Retention: max `auto` snapshots kept |
| `retention_days` | `90` | Retention: delete `auto` snapshots older than N days |
| `compression` | `gzip` | `gzip` / `bzip2` / none (falls back if ext missing) |
| `exclude_patterns` | `[system.cron, core.extension]` | fnmatch patterns skipped when capturing |

## Cron behavior (`hook_cron`)
- If `auto_snapshot_enabled`, creates an `auto` snapshot when
  `now - state('config_guardian.last_auto_snapshot') >= interval` (3600/86400/604800s).
- Then runs retention: `cleanupOldSnapshots(cutoff, max_snapshots)` — deletes `auto`
  snapshots older than `retention_days`, and trims oldest `auto` snapshots beyond
  `max_snapshots`. Manual/pre_import/pre_rollback snapshots are NOT auto-deleted.

## Requirements / install
- `hook_requirements` (runtime) reports snapshot count and whether `gzcompress` is
  available (warning if not — snapshots stored uncompressed).
- `hook_uninstall` deletes `config_guardian.settings` and clears
  `temporary://config_guardian`. Snapshot/log tables are dropped by core on uninstall
  (defined in `hook_schema`).
- Exclude patterns are applied on capture via `fnmatch`; on rollback, excluded
  configs are filtered out of delete lists so they are not removed on restore.
