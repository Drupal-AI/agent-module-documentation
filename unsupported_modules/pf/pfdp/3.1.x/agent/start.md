<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Files Download Permission (`pfdp`) — agent index

Project `private_files_download_permission`, **module machine name `pfdp`** (all routes, config,
permissions and file names use `pfdp`). One `hook_file_download()` implementation + a
`pfdp_directory` config entity + five boolean settings.

- **Directory entities, the settings keys, routes and how to create them** →
  [configure/directories.md](configure/directories.md)
- **The access algorithm in `pfdp_file_download()` — exact order of checks, return values,
  gotchas** → [api/file-download.md](api/file-download.md)
- **The three permissions and what they bypass** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- Config entity: `pfdp.pfdp_directory.<id>` — `id, path, bypass, grant_file_owners, users, roles`.
- Settings object: `pfdp.settings` — `by_user_checks`, `cache_users`, `attachment_mode`,
  `override_mode`, `debug_mode` (all booleans).
- **Packaging bug in 3.1.x:** the default config file is named `config/install/pfdp.settings`
  (no `.yml`) and is empty, so `pfdp.settings` **does not exist after install** — `drush config:get
  pfdp.settings` errors and every setting reads as `NULL` (i.e. by-user checks off) until the
  settings form is saved or the object is created manually.
- `configure` route = `pfdp.settings` → `/admin/config/media/private-files-download-permission/settings`;
  the directory list is `entity.pfdp_directory` → `/admin/config/media/private-files-download-permission`.
- Paths are **relative to `$settings['file_private_path']`**, need a leading `/`, no trailing `/`,
  no `//`. Matching is longest-prefix, case-insensitive (`stripos`).
- Only affects the **private** (and `temporary://`) stream; `public://` URIs return early.
