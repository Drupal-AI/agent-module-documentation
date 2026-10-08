<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Folders: FolderManager, AdminFolderService, `dl_folders`

Folders are **not** entities — they live in the custom `dl_folders` table (schema in `dl.install`
`hook_schema`) and are managed through two services registered in `dl.services.yml`.

## `dl_folders` table

Columns: `folder_id` (PK serial), `parent_id` (0 = root), `name`, `slug`, `description`,
`path` (materialized path like `/1/5/12`), `depth`, `weight`, `status`, `uid`, `created`,
`changed`. Unique key `parent_slug = (parent_id, slug)` — slugs are unique within a parent.
`dl_update_9001` seeds default folders (Reports, Presentations, Spreadsheets, Policies, Training
Materials) on upgrade installs.

## `dl.folder_manager` — `src/FolderManager.php`

Constructor args `@database`, `@current_user`. All queries are parameterized / use the query
builder. Key methods:
- `createFolder($name, $parent_id, $description, $weight)` — inserts, computes depth from parent,
  generates a slug, then writes `path = parent_path . '/' . folder_id`. Returns new id.
- `getFolder($id)`, `getFolderTree($parent_id, $published_only)`,
  `buildFolderTree($parent_id, $published_only)` — the latter recurses, attaches owner name,
  `slug_path`, `children`, and `document_count`.
- `getFolderDocumentCount($folder_id, $published_only)` — counts rows in `document`.
- `updateFolder($id, array $fields)` — regenerates the slug when `name` changes; when `parent_id`
  changes it calls `updateFolderPath()`, which recomputes `path`/`depth` for the folder and, via
  recursion, all descendants.
- `deleteFolder($id, $move_contents_to_parent = TRUE)` — if moving: re-parents documents and child
  folders to the parent and fixes paths; if not: recursively deletes child folders and deletes the
  folder's documents through the entity storage (`accessCheck(FALSE)`, so `postDelete` file
  cleanup runs). Then deletes the folder row.
- `getFolderBreadcrumbs($id)` — parses the materialized `path` into ancestor folder objects.
- `getFolderOptions($exclude_id, $published_only)` — flat indented `folder_id => name` list for
  select widgets, excluding a subtree.
- `generateSlug($name, $parent_id, $exclude_id)` — lowercases, `preg_replace('/[^a-z0-9]+/','-')`,
  trims hyphens, then appends `-1`, `-2`… until unique within the parent (`slugExists()`).
- `getFolderByPath($path)` — walks slug segments (each a parameterized `slug + parent_id + status`
  lookup) to resolve a nested path to a folder; `getFolderSlugPath($id)` builds the reverse.

## `dl.admin_folder_service` — `src/AdminFolderService.php`

Constructor args `@database`, `@current_user`, `@dl.folder_manager`.
- `getFolderStatistics()` — total / published / unpublished / root folder counts (used by the admin
  folders page).
- `getAllFoldersWithMetadata()` + `flattenTreeWithMetadata()` — flattened folder list with owner
  name, document count and `has_children` for the admin table.
- `updateFolderHierarchy(array $folder_data)` — applies drag-and-drop reorder: for each
  `folder_id => [parent, weight]` calls `FolderManager::updateFolder()` (values cast to int).
- `getFolderInfo($id)` — single-folder detail array.

## Folder forms & admin UI

`src/Form/` provides `FolderCreateForm`, `FolderEditForm`, `FolderDeleteForm`, `FolderAdminForm`
(the drag-and-drop table, embedded by `DocumentLibraryController::adminFoldersPage` at
`/admin/content/documents/folders`, using the `dl/folder-admin` library with core tabledrag).
Folder routes in `dl.routing.yml`: `dl.folder.create[.parent]` (`create folders`),
`dl.folder.edit` (`edit folders`), `dl.folder.delete` (`delete folders`).
