<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Temporary Storages Killer (tsk) — agent index

**Drush command (+ optional `tsk_admin` UI) to delete Drupal private/shared tempstore collections and key/value-expirable items.**

- **Version:** 1.0.x
- **Core:** ^9.2 || ^10 || ^11
- **Submodule:** `tsk_admin` (config entity `tsk_entity` + admin UI), dep `tsk`
- **Service:** `tsk` → `TskService::kill(collection, type, kill_all, key)`; types `private`/`shared`; typed exceptions in `src/Exception/`
- **Drush:** `src/Commands/TskCommands.php` (base), `tsk_admin/src/Commands/TskAdminCommands.php`
- **tsk_admin routes:** `/admin/config/development/tsk[...]` and `/admin/reports/tsk[...]` — all `_permission: 'administer tsk'`

**Security:** All web routes are in `tsk_admin` and every one requires **`administer tsk`** (declared `restrict access: true`). No anonymous / `_access:TRUE` / `access content` routes. Kill controllers take `collection`/`type`/`key` URL args but are fully behind the admin permission, so no unauthorized deletion. Base `tsk` is CLI-only. Deletion is destructive (clears users' unsaved tempstore data).

See [drush/kill.md](drush/kill.md)
