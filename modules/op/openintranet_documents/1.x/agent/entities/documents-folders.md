<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, routes, permissions

## Install & enable

```bash
composer require drupal/openintranet_documents
drush en openintranet_documents -y
drush cr
```

Requires core `file`, `user`, `views` and the contrib `alpine_js` module. Intended for the
Open Intranet distribution. `hook_install()` does nothing; `hook_uninstall()` deletes all
`oi_document` and `oi_folder` entities.

## The two entities

Both are `EditorialContentEntityBase` (revisionable + publishable) with `EntityOwnerTrait`,
defined via PHP attributes.

### `oi_document` — `src/Entity/OiDocument.php`

`base_table` `oi_document`, revision table `oi_document_revision`, admin permission
`administer oi_document`. Base fields (`baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `title` | string (255) | Entity label, required, revisionable |
| `description` | string_long | optional |
| `folder` | entity_reference → `oi_folder` | containing folder (autocomplete) |
| `source_type` | string (64) | plugin id, default `local_file`, hidden widget |
| `source_url` | string (2048) | external doc URL (for non-local sources), hidden widget |
| `file` | file | **optional**; `file_extensions = pdf doc docx xls xlsx ppt pptx txt rtf odt ods odp jpg jpeg png gif`, `max_filesize = 50 MB`, `file_directory = documents/[date:custom:Y]/[date:custom:m]` |
| `status` | boolean | published flag, default TRUE |
| `uid` | entity_reference → user | author; `preSave()` defaults owner to 0 when unset |
| `created` / `changed` | created / changed | timestamps |

Accessor helpers on the class: `getTitle/setTitle`, `getDescription`, `getFolder/setFolder`,
`getFolderId`, `getFile/setFile`, `getSourceType/setSourceType`, `getSourceUrl/setSourceUrl`.

Handlers: list builder `OiDocumentListBuilder`, `EntityViewsData`, forms
`OiDocumentForm` (add/edit) and `OiDocumentModalForm` (add_modal/edit_modal), core delete /
delete-multiple / revision-delete / revision-revert forms, `AdminHtmlRouteProvider` +
`RevisionHtmlRouteProvider`. `show_revision_ui: TRUE`.

### `oi_folder` — `src/Entity/OiFolder.php`

Fields `name`, `description`, `parent` (self-reference → `oi_folder`) for nesting. Access handler
`OiFolderAccessControlHandler`, forms `OiFolderForm` / `OiFolderModalForm`. Its
`collection` link `entity.oi_folder.collection` is the module `configure` route in info.yml.

## Routes (`openintranet_documents.routing.yml`)

Custom / controller routes:

| Route | Path | Access | Controller |
|---|---|---|---|
| `openintranet_documents.settings` | `/admin/config/content/documents` | `administer oi_document` | `DocumentSettingsForm` |
| `openintranet_documents.browser` | `/documents` | `view oi_document` | `DocumentBrowserController::browse` |
| `openintranet_documents.search` | `/documents/search` | `view oi_document` | `SearchController::search` |
| `openintranet_documents.folder.view` | `/documents/folder/{oi_folder}` | `_entity_access: oi_folder.view` | `FolderController::view` |
| `entity.oi_document.canonical` | `/documents/document/{oi_document}` | `_entity_access: oi_document.view` | `OiDocumentController::view` |
| `openintranet_documents.download` | `/documents/document/{oi_document}/download` | `_entity_access: oi_document.view` | `DocumentBrowserController::download` |

Entity form routes (all `_admin_route: FALSE`, front theme): folder add / add-modal /
add-subfolder(+modal) / edit(+modal) / delete gated by `create oi_folder` or
`_entity_access: oi_folder.{update,delete}`; document add / add-modal / add-in-folder(+modal) /
edit(+modal) / delete gated by `create oi_document` or `_entity_access: oi_document.{update,delete}`.
The `add_modal` routes take a `{source_type}` param (default `local_file`).

## Permissions (`openintranet_documents.permissions.yml`)

Folder: `administer oi_folder` (restrict access), `view oi_folder`, `edit oi_folder`,
`delete oi_folder`, `create oi_folder`.
Document: `administer oi_document` (restrict access), `view oi_document`, `edit oi_document`,
`delete oi_document`, `create oi_document`, `download oi_document`, plus revision perms
(`view / revert / delete oi_document revision`).

## How access is enforced

`OiDocumentAccessControlHandler::checkAccess()` (and the folder equivalent) grant the admin
permission holder everything, then map operations to a **flat, site-wide** permission:

- `view` → `view oi_document`; `update` → `edit oi_document`; `delete` → `delete oi_document`;
  revision ops → the matching revision permissions.
- `checkCreateAccess()` → `create oi_document` OR `administer oi_document`.

There is **no per-folder or per-owner** narrowing — the permission is all-or-nothing across every
document/folder (the distribution ships a separate `openintranet_access` module for per-document
ACLs; `OiDocumentController::view()` only links to its form when that module is enabled and the
user has `administer openintranet access`). The `download oi_document` permission exists but the
download route is actually gated by `oi_document.view` (see below).

## Download flow — `DocumentBrowserController::download()`

Route `openintranet_documents.download` upcasts `{oi_document}` and checks
`_entity_access: oi_document.view`. For `source_type === 'local_file'` it streams the managed file
via `downloadLocalFile()` — resolves `$file->getFileUri()` to a realpath and returns a
`BinaryFileResponse` with `Content-Disposition: attachment`. For external sources it calls the
source plugin's `getDownloadUrl()` and returns a `RedirectResponse` to that URL (or 404).

## Services & managers

- `OiFolderManager` (`openintranet_documents.folder_manager`) — `getChildren()`, `getAncestors()`,
  `getPath()`, `hasChildren()`, `countDocuments()` (optionally recursive), `getFolderStats()`
  (single grouped SQL count of subfolders/documents), `search()`. Entity-query paths use
  `accessCheck(TRUE)`.
- `OiDocumentManager` (`openintranet_documents.document_manager`) — `getByFolder()`, `getRecent()`,
  `search()` (raw DB `select` on `oi_document` LEFT JOIN `file_managed`, LIKE on
  title/description/filename, parameterized), `getReferencingContent()` (finds nodes whose
  entity_reference fields target a document, `accessCheck(TRUE)`).
- `OiDocumentBreadcrumbBuilder` (breadcrumb_builder, priority 100) — builds crumbs from the folder
  path.

## Hooks (`.module`)

- `hook_theme` — `oi_folder`, `oi_document`, `oi_documents_browser`, `oi_document_view`,
  `oi_documents_search` (templates in `templates/`, CSS/JS in `css/` + `js/`; library
  `openintranet_documents/documents`).
- `hook_user_cancel` — `block_unpublish` unpublishes the user's documents; `reassign` sets owner
  to 0 on their documents and folders.
- `hook_user_predelete` — deletes the user's documents (and revisions) and folders.
