<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Audit Trail Config Sync (admin_audit_trail_config_sync) — agent index

An add-on to **Admin Audit Trail** that logs **configuration imports run from the CLI**
(`drush config:import`), which Admin Audit Trail itself skips because its insert path only fires on
web requests. Package `Administration`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version 1.0.1.

- **How it hooks the import event, the CLI-safe DB writer, and what a row contains** →
  [logging/config-sync.md](logging/config-sync.md)

## What it actually is

- Depends on **`admin_audit_trail:admin_audit_trail`** (composer `drupal/admin_audit_trail ^1.0`).
- **No** routes, permissions, config, config schema, plugins, or Drush commands of its own. It has
  exactly three moving parts:
  - **Event subscriber** `ConfigSyncSubscriber` (service
    `admin_audit_trail_config_sync.config_sync_subscriber`, `src/EventSubscriber/ConfigSyncSubscriber.php`)
    — listens on `ConfigEvents::IMPORT` and calls `onConfigImport()`.
  - **Hook** `admin_audit_trail_config_sync_admin_audit_trail_handlers()` in the `.module` —
    registers the `config_sync` event type (title "Config Sync") so it appears as a filter in the
    audit overview.
  - **Helper** `admin_audit_trail_config_sync_db_write(array $log)` in the `.module` — a CLI-safe
    writer that inserts straight into the `admin_audit_trail` table (bypassing the web-only guard in
    `admin_audit_trail_insert()`) and invalidates the audit view cache.

## Mechanism (from source)

- On a completed import, `onConfigImport()` reads the `StorageComparer` changelist, builds a
  `create: N, update: N, delete: N`-style summary string plus the source collection name, appends
  the SSH user when `$_SERVER['SSH_CONNECTION']` is set, and writes a row of
  `type=config_sync, operation=import_success, ref_char=config_import`.
- `admin_audit_trail_config_sync_db_write()` defaults `created`, `uid` (0 for CLI), `ip` (SSH client
  IP if present), and `path` (`cli`), then `INSERT`s into `admin_audit_trail` and
  `Cache::invalidateTags(['config:views.view.admin_audit_trail'])`.
- Logged content is **change counts and metadata only** — it never records the imported config
  values themselves.
