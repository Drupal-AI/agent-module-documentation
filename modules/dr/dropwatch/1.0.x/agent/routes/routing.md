<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permission, menu & local tasks

## Permission (`dropwatch.permissions.yml`)

- **`administer dropwatch`** (title "Administer dropwatch") — the only permission; guards all three
  routes below.

## Routes (`dropwatch.routing.yml`)

| Route | Path | Handler | Requirement |
|-------|------|---------|-------------|
| `dropwatch.main` | `/admin/config/dropwatch` | `SystemController::systemAdminMenuBlockPage` (core menu-block page) | `_permission: administer dropwatch` |
| `dropwatch.settings` | `/admin/config/system/dropwatch/settings` | `DropWatchSettingsForm` | `_permission: administer dropwatch`, `_admin_route: TRUE` |
| `dropwatch.manual_sync` | `/admin/config/system/dropwatch/manual-sync` | `DropWatchManualSyncForm` | `_permission: administer dropwatch`, `_admin_route: TRUE` |

All routes are admin-only; both forms are standard POST forms (CSRF-protected). No `_access: TRUE`,
no anonymous/`access content` gating, no token/header self-auth.

## Menu links (`dropwatch.links.menu.yml`)

- `dropwatch.main` under `system.admin_config` (Configuration), title "DropWatch".
- `dropwatch.settings` and `dropwatch.manual_sync` under `dropwatch.main` (weights 0 and 1).

## Local tasks (`dropwatch.links.task.yml`)

Two tabs on `base_route: dropwatch.settings` — **Settings** (`dropwatch.settings`) and
**Manual sync** (`dropwatch.manual_sync`).

## Cron hook (`dropwatch.module`)

`dropwatch_cron()` calls `\Drupal::service('dropwatch.service')->sendApiRequest()` on every cron run.
