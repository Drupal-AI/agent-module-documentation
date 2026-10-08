<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Library (dl) — agent index

A document-management system built around a custom **`document`** content entity plus a custom
**`dl_folders`** hierarchy. Package `Content`. Core `^10 || ^11`. License GPL-2.0-or-later.
Declared dependencies: **node, file, user, views, taxonomy**. Configure route `dl.admin_settings`
(`/admin/config/content/document-library`). No composer.json, no Drush, no plugin types, no
shipped config schema (the `dl.settings` object is schema-less).

## What it provides

- **Content entity `document`** (`src/Entity/Document.php`), base table `document`. Base fields:
  `title`, `folder_id` (int, references `dl_folders`), `downloads` (read-only counter), `status`,
  `created`, `changed`, plus owner (`uid`) via `EntityOwnerTrait`. File, description, version and
  tags are **configurable fields** (`field_file`, `field_description`, `field_version`,
  `field_tags`) created in `config/install/` — `field_file` is a required File field, extensions
  `txt pdf doc docx xls xlsx ppt pptx odt ods odp rtf zip rar 7z tar gz`, max 50 MB, `public`
  scheme by default. Access handler `DocumentAccessControlHandler`; custom route provider
  `Routing/DocumentHtmlRouteProvider` (overrides canonical `/documents/{document}`, adds Field-UI
  settings route). `EntityViewsData` for Views.
- **Custom tables** (`dl.install` `hook_schema`): `dl_folders` (hierarchy: parent_id, name, slug,
  materialized `path`, depth, weight, status, uid), `dl_versions`, `dl_downloads`, `dl_favorites`.
  (An old `dl_documents` table + `hook_update_N` migrations exist from before the entity move.)
- **Services** (`dl.services.yml`): `dl.folder_manager` (`FolderManager`) and
  `dl.admin_folder_service` (`AdminFolderService`) — folder CRUD, tree building, slug paths, stats.
- **Controllers**: `DocumentLibraryController` (library/folder/search/favorites/view/download/
  bulk/admin pages), `DocumentUploadRedirectController` (redirects `/documents/upload*` to the
  entity add form).
- **12 permissions** (`dl.permissions.yml`) and config object `dl.settings` (`SettingsForm`).

## Solution docs

- **The `document` entity, its fields, access control, permissions and entity routes** →
  [entities/document.md](entities/document.md)
- **Folders: `FolderManager` / `AdminFolderService`, `dl_folders`, slug paths, admin folder UI** →
  [services/folders.md](services/folders.md)
- **Front-end & admin routes/controllers (library, search, favorites, download, bulk, nested slug paths)** →
  [routing/pages.md](routing/pages.md)
- **Settings (`dl.settings`), file-field/Field-UI configuration, install/uninstall** →
  [config/settings.md](config/settings.md)
