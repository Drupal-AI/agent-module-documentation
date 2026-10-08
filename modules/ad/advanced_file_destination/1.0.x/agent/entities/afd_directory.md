<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `afd_directory` directory entity & admin UI

## Entity
`Entity\AdvancedFileDestinationDirectory` — `@ContentEntityType(id = "afd_directory")`, revisionable (`afd_directory` / `afd_directory_revision` tables), `admin_permission = "administer advanced file destination"`, implements `RevisionableInterface` + `EntityOwnerInterface`.

Base fields (`baseFieldDefinitions()`): `name` (string, label key), `path` (string — the destination directory URI, e.g. `public://reports`), `status` (boolean, active), `weight` (integer, sort order), `roles` (multi entity_reference → `user_role`, intended per-directory targeting), `uid` (owner), `created`, `changed`, `revision_log`. Handlers: storage `AFDDirectoryStorage`, list_builder `Controller\DirectoryListBuilder`, forms add/edit `Form\AdvancedFileDestinationDirectoryForm` + delete `Form\AdvancedFileDestinationDeleteForm`, access `Entity\Access\DirectoryAccessControlHandler`, route provider `AdminHtmlRouteProvider`.

`postSave()` clears the manager's static directory cache. `NonModeratedAdvancedFileDestinationDirectory` is swapped in by `hook_entity_type_build()` to keep Content Moderation from attaching to the entity. `getFilesAndDirectories()` renders up to 20 items found under the directory path (admin display helper).

## Routes (`advanced_file_destination.routing.yml`, all `_admin_route`)
- `entity.afd_directory.collection` → `/admin/content/directories` — `administer advanced file destination`.
- `entity.afd_directory.add_form` → `/admin/content/directories/add` — `administer advanced file destination`.
- `entity.afd_directory.edit_form` → `/admin/content/directories/{afd_directory}/edit` — `administer advanced file destination`.
- `entity.afd_directory.delete_form` → `/admin/content/directories/{afd_directory}/delete` — `delete advanced file destination` **and** `_entity_access: afd_directory.delete`.
- `entity.afd_directory.version_history` → `/admin/content/directories/{afd_directory}/revisions` — `DirectoryRevisionController::revisionOverview`.
- `advanced_file_destination.bulk_confirm` → `/admin/content/directories/bulk-confirm` — `Form\AdvancedFileDestinationBulkConfirmForm`, `administer advanced file destination`.

## Permissions (`advanced_file_destination.permissions.yml`, all `restrict access: true`)
`administer advanced file destination`, `access advanced file destination`, `create advanced file destination directories`, `access advanced file destination private files`, `create advanced file destination`, `delete advanced file destination`, `enable advanced file destination`, `disable advanced file destination`.

## Creating directories
Two paths create `afd_directory` records and the real folder (via `FileSystem::prepareDirectory(... CREATE_DIRECTORY)`):
- `AdvancedFileDestinationManager::createDirectory($path, $name)` — requires `create advanced file destination directories`; refuses `private://` without `access advanced file destination private files`.
- `Form\NewDirectoryModalForm::submitDirectoryFormAjax()` — the in-upload modal; requires `create advanced file destination` or `administer advanced file destination`; validates the name against `[^a-zA-Z0-9_\-]` and normalizes the full path before creating.

The bulk-confirm form re-checks `delete` / `enable` / `disable` permissions per operation before acting.
