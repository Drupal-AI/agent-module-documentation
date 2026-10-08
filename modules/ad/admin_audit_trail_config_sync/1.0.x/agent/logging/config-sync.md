<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logging CLI config imports into the Admin Audit Trail

## Install & enable

```bash
composer require drupal/admin_audit_trail_config_sync
drush en admin_audit_trail_config_sync -y
```

Requires the **Admin Audit Trail** module (`drupal/admin_audit_trail ^1.0`,
dependency `admin_audit_trail:admin_audit_trail`). Nothing to configure — enabling is enough.

## Why the module exists

Admin Audit Trail records configuration changes made through the web UI, but its insert path assumes
a live web request, so imports run from the shell (`drush config:import` / `drush cim`, deploy
scripts, CI) produce **no** audit row. This module subscribes to the core config-import event and
writes the row itself using a CLI-safe writer.

## The event subscriber

`src/EventSubscriber/ConfigSyncSubscriber.php` (service
`admin_audit_trail_config_sync.config_sync_subscriber`, tag `event_subscriber`):

- `getSubscribedEvents()` registers `ConfigEvents::IMPORT` → `onConfigImport` (priority 0). This
  event fires **after** a config import has been committed, so a logged row means a successful
  import.
- `onConfigImport(ConfigImporterEvent $event)`:
  - `$event->getConfigImporter()->getStorageComparer()->getChangelist()` gives the per-operation
    change lists; the code turns them into a summary like `create: 3, update: 12, delete: 1`
    (operation name + `count()` per op).
  - Source collection name via `getSourceStorage()->getCollectionName() ?: 'default'`.
  - Builds `description = "Config sync import completed. Source: <collection>. Changes: <summary>"`.
  - If `$_SERVER['SSH_CONNECTION']` is set, appends `(SSH user: <user>)` (the 3rd space-separated
    field of that variable, the server-side login user).
  - Calls `admin_audit_trail_config_sync_db_write()` with
    `type=config_sync, operation=import_success, description=<above>, ref_char=config_import`.

**Important:** only change **counts** and metadata are logged — the imported config *values* are
never written to the audit table.

## The CLI-safe writer

`admin_audit_trail_config_sync_db_write(array $log)` in `admin_audit_trail_config_sync.module`
inserts directly into the `admin_audit_trail` table (deliberately bypassing
`admin_audit_trail_insert()`, which only runs for web requests). It fills defaults:

| Field | Default when empty |
|---|---|
| `created` | `\Drupal::time()->getRequestTime()` |
| `uid` | `0` (CLI has no authenticated user) |
| `ip` | SSH client IP (1st field of `$_SERVER['SSH_CONNECTION']`) if present, else `''` |
| `path` | `'cli'` |
| `ref_numeric` | `NULL` |
| `type` / `operation` / `description` / `ref_char` | as passed in |

After the `INSERT` it calls `Cache::invalidateTags(['config:views.view.admin_audit_trail'])` so the
audit-trail overview view reflects the new entry.

## The event-type registration

`admin_audit_trail_config_sync_admin_audit_trail_handlers()` (an Admin Audit Trail hook) returns a
`config_sync` handler with title **"Config Sync"**, which makes config-sync events a selectable
event-type filter on the audit trail overview.

## Where to see the results

Config-sync rows appear in the standard Admin Audit Trail overview (provided by the parent module),
filterable by the **Config Sync** event type. Each row shows the timestamp, `uid` 0 / `cli` path for
CLI runs, the SSH client IP when available, and the change-count description.

## Operating notes

- Fires on **every** completed config import (UI or CLI); UI imports may therefore be double-logged
  (once by Admin Audit Trail, once here) — this module's value is specifically the CLI case.
- `uid` is `0` for CLI imports because there is no logged-in Drupal user; attribution comes from the
  SSH user string when the import was run over an SSH session.
- No settings, forms, or scheduled tasks. Uninstalling simply stops new config-sync rows from being
  written.
