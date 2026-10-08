<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Inspector (file_inspector) — agent index

Scans a stream wrapper's file system for files absent from `file_managed`, records them in its own
`file_inspector` table, classifies each as managed/unmanaged, and lets admins inspect, delete, or
import them into the Media library. Package **Media**. Core **`^11`**, PHP **>=8.1**. Depends on
core **`views`**; **`media`** is optional (suggested) and unlocks import. Version **1.0.0**.
License GPL-2.0-or-later.

- **Configuration** (settings form, config object, schema, keys) → [config/settings.md](config/settings.md)
- **Services & data model** (inspection, path validation, batch, DB table, status codes, the
  Media strategy swap) → [api/services.md](api/services.md)
- **Routes, forms & Views integration** (routes/permissions, confirm forms, custom Views
  field/filter handlers, overview page) → [views/interface.md](views/interface.md)

## What it actually provides

- **Database table** `file_inspector` (`hook_schema` in `file_inspector.install`): `id, name,
  path` (unique), `mime_type, size, status` (tinyint), `created, updated, media_id`. Not entities —
  a plain table for scalable querying and Views. Status codes in
  `src/Constants/FileStatusInterface.php`: 0 unprocessed, 1 managed, 2 unmanaged, 3 imported,
  4 deleted, 5 web_embedded. Field-name constants in `src/Constants/FileDataInterface.php`.
- **6 routes** (`file_inspector.routing.yml`), all `_admin_route`, each `_permission`-gated:
  `file_inspector.overview` (`/admin/reports/file-inspector`), `.settings`
  (`/admin/config/media/file-inspector`), `.batch` (…/batch), `.import` (`…/import/{id}`),
  `.delete` (`…/delete/{id}`), `.bulk_confirm`.
- **4 permissions** (`file_inspector.permissions.yml`): `view file inspector`,
  `administer file inspector` (restrict), `delete unmanaged files` (restrict),
  `import unmanaged files` (restrict).
- **8 services** (`file_inspector.services.yml`): `inspect_files`, `path_validator`, `data_service`,
  `manage_files` (swapped to `ManageFilesWithMedia` when Media is on, via
  `FileInspectorServiceProvider`), `batch_tracker`, `batch_processor`, plus a logger channel.
- **Views integration** (`hook_views_data` in `.module`): base table + 3 custom field handlers
  (`file_inspector_path`, `file_inspector_media`, `file_inspector_actions`, `file_inspector_status`,
  `file_inspector_bulk_select`) and 2 filters (`file_inspector_status_filter`,
  `file_inspector_mime_type_filter`) under `src/Plugin/views/`.
- **Config** object `file_inspector.settings` (schema in `config/schema/`, install defaults in
  `config/install/`), optional View `views.view.file_inspector` (`config/optional/`).
- **Forms**: `SettingsForm`, `BatchForm`, `ImportForm`, `DeleteForm`, `BulkOperationsForm`,
  `BulkConfirmForm` (`src/Form/`). One OOP hook class `FileInspectorHooks` (`hook_theme`).
- No Drush commands. No new plugin *types*. Two asset libraries (`file_inspector.libraries.yml`).

## Mechanism in one paragraph

`BatchTracker` (triggered from `BatchForm`) truncates the table, then in a two-pass sandbox
enumerates `InspectFiles::filesIterator()` + `embeddedEntriesIterator()` into a queue and drains it
`batch_size` at a time, calling `extractMetadata()` and `DataService::bulkInsertFileData()`. Every
discovered path passes `PathValidator::validatePath()` (traversal/null-byte rejection) and symlinks
are skipped. `BatchProcessor` then re-reads UNPROCESSED rows and flips each to MANAGED/UNMANAGED via
`InspectFiles::bulkCheckManagedFiles()` (an `IN` query against `file_managed.uri`). Only UNMANAGED
rows are actionable; `ManageFiles::removeFile()` / `importFile()` (or `ManageFilesWithMedia`) do the
work behind permission-gated confirmation forms. See the linked docs for detail.
