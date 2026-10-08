<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front-end & admin routes (`dl.routing.yml` + controllers)

Nearly all page logic is in `src/Controller/DocumentLibraryController.php` (services injected:
`@database`, `@file_url_generator`, `@request_stack`, `@config.factory`, `@dl.folder_manager`,
`@dl.admin_folder_service`). `src/Controller/DocumentUploadRedirectController.php` only redirects
upload URLs to the entity add form.

## Public library routes

- `dl.library` `/documents` → `libraryPage` — perm `access document library`. Stats + recent
  published documents (entity query `accessCheck(TRUE)`) + folder tree sidebar.
- `dl.search` `/documents/search` → `searchPage` — perm `access document library`. `?q=` keyword
  matched with `escapeLike()` against title/description/tags in an OR group; `?sort=` validated
  against an allow-list (`title|downloads|date`).
- `dl.favorites` `/documents/favorites` → `favoritesPage` — perm `access document library`.
- `dl.folder` `/documents/folder/{folder}` (numeric) → `folderPage`.
- Nested **slug** routes `dl.folder.path.level1|2|3` — `/documents/{seg1}[/{seg2}[/{seg3}]]` →
  `folderPageBySegments` → `folderPageByPath` → `FolderManager::getFolderByPath`. Regex
  requirements use negative lookahead to exclude reserved words (`upload`, `search`, `favorites`,
  `folder`) and numeric-only segments; these routes are declared **last** so they don't shadow the
  id/reserved routes.
- `entity.document.canonical` `/documents/{document}` → `viewDocument` (see entities doc): version
  history from `dl_versions`, favorite state from `dl_favorites`, folder breadcrumbs, a
  `document-favorite` CSRF token (cache context `session`).

## Download

- `dl.document.download` `/documents/{document}/download` → `downloadDocument` — perm
  `download documents`. Loads the entity, 404s if missing or unpublished, inserts a row into
  `dl_downloads` (document_id, uid, `time()`, client IP), increments `downloads`, and streams the
  file **bound to the document's `field_file` entity** via `BinaryFileResponse` with an
  `attachment` content-disposition. The served path is derived from `$file->getFileUri()` /
  `file_system->realpath()` — never from request input, so there is no path-traversal surface.

## Favorite toggle

- `dl.document.favorite` `/documents/{document}/favorite` → `toggleFavorite` — perm
  `access document library`. Requires a valid `X-CSRF-Token` header for the `document-favorite`
  value (returns 403 JSON otherwise), then inserts/deletes the user's `dl_favorites` row and
  returns `{favorited: bool}`.

## Upload redirects

- `dl.upload` `/documents/upload/{folder}` and `dl.upload.root` `/documents/upload` — perm
  `upload documents` → `DocumentUploadRedirectController::redirectToAdd`, which sends the user to
  `entity.document.add_form` with the folder pre-selected.

## Admin routes

- `dl.admin_documents` `/admin/content/documents` → `adminDocumentsPage` — perm
  `administer document library`. Lists all documents (incl. unpublished) + stats.
- `dl.admin_folders` `/admin/content/documents/folders` → `adminFoldersPage` — embeds
  `FolderAdminForm` and `AdminFolderService::getFolderStatistics()`.
- `dl.bulk_operations` `/admin/content/documents/bulk` (POST) → `bulkOperations` — perm
  `administer document library`. Validates an `X-CSRF-Token` header, then for each id runs
  delete/publish/unpublish **only** when `uid == currentUser` OR `manage all documents`; returns a
  JSON summary. Unknown operation → 400, exceptions logged and return 500.
- `dl.admin_settings` / `dl.settings` `/admin/config/content/document-library[/settings]` →
  `SettingsForm`; `dl.field_config` `/…/fields` → `FieldConfigRedirectForm` (redirect to Field UI).

Menu/task links: `dl.links.menu.yml` adds a `main`-menu "Document Library" link and admin menu
items; `dl.links.task.yml` adds local tasks. Libraries `dl/document-library` and `dl/folder-admin`
(`dl.libraries.yml`) attach the CSS/JS.
