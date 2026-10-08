<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_guardian — agent start

Config safety layer on top of core CMI: point-in-time **snapshots** (of active
config AND the sync directory), a **rollback engine** (with dry-run simulation +
risk scoring), **impact analysis** (dependency graph, 0–100 risk score), config
**sync** (export/import), and an **activity log**. Snapshots are gzip-compressed
JSON blobs in DB table `config_guardian_snapshot`; activity in
`config_guardian_activity_log`. Info name **Config Guardian**, version **1.0.3**,
core `^10.5 || ^11 || ^12`, php 8.1. Depends on core `config`, `file`.

Admin UI base: **Config → Development → Config Guardian**
(`/admin/config/development/config-guardian`, configure route
`config_guardian.dashboard`). Not a config entity — snapshots are DB rows, settings
live in `config_guardian.settings`. No plugin types, no public API hooks; extend by
calling its services.

Snapshot data is stored as JSON (not PHP serialize); legacy `unserialize` fallback
uses `allowed_classes => FALSE`. Integrity checked with SHA-256. Rollback writes
snapshot data straight to `config.storage`/`config.storage.sync` via core
`StorageComparer` (not through `ConfigImporter`), then flushes caches. All routes are
permission-gated; restore/import/synchronize/delete/administer use restrict-access
permissions — keep them to trusted operators.

## Subdocs
- Permissions (11 perms, which gate what) → [permissions/permissions.md](permissions/permissions.md)
- Services to call in code (snapshot/rollback/analyze/sync/log) → [api/services.md](api/services.md)
- Drush commands (snapshot/list/rollback/analyze/diff/export/delete) → [drush/drush.md](drush/drush.md)
- Settings, cron auto-snapshots, retention → [configure/settings.md](configure/settings.md)

## Routes (all under /admin/config/development/config-guardian)
- `` (dashboard), `/snapshots`, `/snapshot/add`, `/snapshot/{id}`,
  `/snapshot/compare/{id1}/{id2}`, `/snapshot/{id}/rollback`, `/snapshot/{id}/delete`,
  `/snapshot/{id}/export` (JSON download), `/snapshot/import`
- `/sync`, `/sync/export`, `/sync/import`, `/analyze`, `/activity`, `/settings`
- AJAX (JSON): `/ajax/status`, `/ajax/dependency-graph`, `/ajax/pending-changes`;
  `/dependency-graph-frame` (standalone iframe HTML)
- Snapshot id route params are typed `int`; loaded by integer DB lookup.

## Key facts
- Snapshot v2 format: `{version:2, active:{...}, sync:{...}}`; v1 legacy = flat
  active-only array. Excludes `system.cron`, `core.extension` by default (fnmatch).
- Pre-import snapshot: `ConfigEventSubscriber` on `ConfigEvents::IMPORT_VALIDATE`
  (type `pre_import`); post-import logged on `ConfigEvents::IMPORT`.
- Pre-rollback backup: rollback creates a `pre_rollback` snapshot first unless
  disabled (`create_backup=false` / `--no-backup`).
- Cron (`hook_cron`) creates `auto` snapshots at the configured interval and runs
  retention cleanup (age + max count, `auto` snapshots only).
- Templates are themeable (`config-guardian-*.html.twig`); D3.js dependency graph.
