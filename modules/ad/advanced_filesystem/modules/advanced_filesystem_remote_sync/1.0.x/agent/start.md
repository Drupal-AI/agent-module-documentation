<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Remote Sync (advanced_filesystem_remote_sync) — agent index

Submodule of **Advanced Filesystem Backup**. Transfers a Drupal site's files from one server to
another running the same module, over **HTTP Basic Auth**. Package `Advanced Filesystem`.
Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.27 (version dir 1.0.x).

Dependencies: core `file`, core `user`, `advanced_filesystem`, `advanced_filesystem_backup`.

Two roles in one module:
- **Source (old) server** — exposes two authenticated read-only endpoints (list + download).
- **Destination (new) server** — an admin form + Batch job that pulls files from the source.

- **The API endpoints, their authentication, and how to call them** →
  [api/endpoints.md](api/endpoints.md)
- **The admin form, config object/schema, the sync batch, and the service** →
  [config/settings.md](config/settings.md)

## What it actually provides

- **Routes** (`advanced_filesystem_remote_sync.routing.yml`):
  - `advanced_filesystem_remote_sync.api_list` → `GET /advanced-filesystem-remote-sync/list`,
    `_access: 'TRUE'`, controller `RemoteSyncApiController::listFiles`.
  - `advanced_filesystem_remote_sync.api_file` → `GET /advanced-filesystem-remote-sync/file`,
    `_access: 'TRUE'`, controller `RemoteSyncApiController::serveFile`.
  - `advanced_filesystem_remote_sync.form` → `/admin/config/media/advanced_filesystem/backup/remote-sync`,
    `_permission: 'administer advanced_filesystem_backup'`, form `RemoteSyncForm`. Local task
    "Remote Sync" (`links.task.yml`).
- **Permission** (`advanced_filesystem_remote_sync.permissions.yml`):
  `access advanced_filesystem_remote_sync api` (`restrict access: true`) — required by the two API
  endpoints.
- **Service** (`advanced_filesystem_remote_sync.services.yml`):
  `advanced_filesystem_remote_sync.service` = `Service\RemoteSyncService`
  (`@config.factory`, `@http_client`, own logger channel).
- **Batch** (not a service): `Batch\RemoteSyncBatch` — static `collect()` / `syncFiles()` /
  `finished()` operations.
- **Config object**: `advanced_filesystem_remote_sync.settings` (`connection` + `sync_options`),
  schema in `config/schema/`. No entities, no plugins, no Drush, no hooks.

## Mechanism (from source)

- The two `_access: 'TRUE'` endpoints are **not anonymous**: each controller method calls
  `RemoteSyncApiController::authenticate($request)` as its first line, which decodes HTTP Basic
  Auth (PHP_AUTH_* or the `Authorization: Basic` header), verifies the password with Drupal's
  `user.auth` service, then requires the `access advanced_filesystem_remote_sync api` permission.
- `listFiles()` recursively scans a scheme's real directory (`scanDir()`) and returns paginated
  JSON metadata (`uri`, `rel`, `size`, `mtime`); `serveFile()` streams one file resolved from a
  `uri` query param via `file_system->realpath()`.
- On the destination, `RemoteSyncForm` saves `connection`/`sync_options` and calls
  `RemoteSyncService::buildBatch()`; `RemoteSyncBatch::collect()` paginates the remote `/list`,
  then `syncFiles()` downloads each file via `/file` (Guzzle `auth` + `verify` = configured
  `verify_ssl`, default TRUE) into the matching local URI through the stream wrapper.

See the solution docs above for exact config keys, request/response shapes, and batch flow.
