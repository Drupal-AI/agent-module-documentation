<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install & configure — ai_vdb_provider_sqlite

## Requirements (ai_vdb_provider_sqlite.install)
`hook_requirements()` (install + runtime):
- ERROR if PHP `sqlite3` extension is not loaded (`extension_loaded('sqlite3')`).
- WARNING if `ini_get('sqlite3.extension_dir')` is empty (the `vec0` extension may not load); otherwise
  reports the directory.

You must separately download the sqlite-vec release (`vec0.so` on Linux/macOS) and place it in the
directory named by PHP's `sqlite3.extension_dir`, readable by the web server. It is loaded via
`SQLite3::loadExtension()` in `SQLiteVectorClient::getConnection()`.

## Enable
`ai:ai` and `key:key` are dependencies (info.yml). Runtime also needs `ai_search` + `search_api`.
Enable with `drush en ai_vdb_provider_sqlite`.

## Config object: `ai_vdb_provider_sqlite.settings`
Schema (`config/schema/ai_vdb_provider_sqlite.schema.yml`) + install defaults (both empty strings):
- `db_path` (string, required) — directory where SQLite files are written, e.g. `private://vdb`.
  Must be a writable directory **not** reachable from the web.
- `ext_file` (string, required) — the sqlite-vec extension filename, e.g. `vec0.so` (filename only;
  resolved under `sqlite3.extension_dir`). Note: the schema calls the second key `ext_path`, but the
  form and client read `ext_file` — the schema key name does not match the code.

## Settings form (src/Form/SQLiteConfigForm.php)
- Route `ai_vdb_provider_sqlite.settings_form` → `/admin/config/ai/vdb_providers/sqlite`,
  permission `administer ai providers` (`*.routing.yml`). Menu link `ai_vdb_provider_sqlite.settings_menu`
  under `ai.admin_vdb_providers`.
- `SqliteConfigForm extends ConfigFormBase`; form id `ai_vdb_provider_sqlite_settings`; editable config
  `ai_vdb_provider_sqlite.settings`. Fields: `db_path`, `ext_file`.
- `validateForm()`:
  - rejects bare `private://` (asks for a sub-directory); requires an existing, writable directory.
  - creates a throwaway `verify-downloadable.sqlite.sql`, then `isFilePubliclyAccessible()` does a HEAD
    request to the guessed public URL (only if the file resolves under the Drupal root) and errors with
    "Security risk: The database file is publicly accessible" if it returns 200; the test file is
    `@unlink`ed afterward.
  - if an extension filename is given, checks it exists/readable under `sqlite3.extension_dir` and tries
    `loadExtension()`. (Note: it reads a local `$ext_file` variable that is never assigned in this method,
    so this extension-validation branch is effectively skipped at save time.)

## Download protection (ai_vdb_provider_sqlite.module)
`hook_file_download($uri)` returns `-1` (deny) and logs a notice for any `$uri` whose prefix matches the
configured `db_path`, so managed-file download routes cannot serve the vector DB. Storing `db_path` under
`private://` is the recommended setup.

## Operate
Point an AI Search server (Search API backend "AI Search") at "SQLite vector DB", set the collection
(main table) name and database file name in the backend's `database_settings`, and choose the similarity
metric. Saving the server/index triggers collection + relation-table creation (see plugins/api docs).
