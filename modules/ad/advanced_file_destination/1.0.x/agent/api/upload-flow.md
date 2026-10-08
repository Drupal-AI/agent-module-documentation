<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Upload-destination flow, widget & path handling

End-to-end: how a chosen folder reaches the saved file.

## 1. The selector is injected
- **Field widget** `Plugin/Field/FieldWidget/AdvancedFileDestinationWidget` (extends core `FileWidget`, id `advanced_file_destination`, for `file`+`image`): `formElement()` adds a `directory` select (options from `AdvancedFileDestinationManager::getAvailableDirectories()`), a hidden `adf_instance_id`, and a hidden `selected_directory`, and sets `#upload_location` on the element/`upload` sub-element.
- **Hook alters** in `advanced_file_destination.module` add the same selector to non-widget forms: `hook_field_widget_complete_form_alter()`, `hook_field_widget_file_generic_form_alter()`, `hook_form_media_library_add_form_alter()`, `hook_form_media_image_form_alter()`. All bail unless the user has `access advanced file destination` and the entity type is in `enabled_entity_types`.
- Each upload instance gets a unique `adf_instance_id` (`uniqid(...)`), the key under which its selection is stored.

## 2. The selection is persisted
- Widget AJAX (`updateDirectoryCallback`) and the JS-driven `DirectoryStateController::updateState()` (`POST /advanced-file-destination/ajax/update-state`, permission: any of administer / create / access) both call `AdvancedFileDestinationManager::setDestinationDirectory($dir, $adf_instance_id)`, which writes `State` key `advanced_file_destination.directory.{uid}.{adf_instance_id}`.
- `updateState()` first runs `validateDirectoryPath()`: the directory must start with the given parent, both must pass `isDirectoryInList()` (present in the built directory list AND `file_exists` + `is_writable`), and must use a valid stream wrapper (`containsNonPublicScheme()` = false).
- The create-directory modal's `mediaModal()` stores `normalizeDirectoryPath($parent_directory)` under the same State key.

## 3. Path normalization (`AdvancedFileDestinationManager::normalizeDirectoryPath()`)
Central sanitizer used before creating/storing/moving:
- Strips stacked scheme prefixes; if no scheme, prepends the configured default scheme.
- Splits scheme from subpath; lowercases; replaces every char **not** in `[a-z0-9/-]` with `-`, collapses repeated `-`, trims `-` per segment, and enforces a single trailing slash.
- Effect: dots, backslashes and colons in the subpath are replaced with `-`, so the result is always a clean `<scheme>://<sanitized-subpath>/` under a known stream wrapper.

`NewDirectoryModalForm` additionally restricts the new folder name to `[a-zA-Z0-9_\-]` before building `parent . name` and normalizing.

## 4. The file is moved to the selection
On save Drupal fires presave; the module moves the just-uploaded file into the chosen directory:
- `hook_ENTITY_TYPE_presave()` for `file` → `advanced_file_destination_file_presave()` reads the selection by `adf_instance_id`, then `advanced_file_destination_validate_file_directory()` requires `isDirectoryInList($directory)` and `file_exists`+`is_writable`, `prepareDirectory()`s it, computes `rtrim($directory,'/').'/'.basename($uri)`, de-dupes with `getDestinationFilename(..., FileExists::Rename)`, and `FileSystem::move()`s the file, updating the file URI.
- `hook_entity_presave()` handles `Media` entities similarly (moves referenced file/image files, then `$file->save()`).
- `EventSubscriber\AdvancedFileDestinationSubscriber::onFilePresave()` (subscribes to a `file.presave` event) is a second mover reading the same State key; note its service in `advanced_file_destination.services.yml` is declared with 2 constructor args while the class requires more, so this subscriber path is effectively inert on a stock install — the `hook_*_presave` functions above are the live movers.
- `getDestinationDirectory()` falls back to `getDefaultDirectory()` (settings `default_directory`, else first available) when no selection exists.

## 5. Directory list building (`getAvailableDirectories()`)
Roots = normalized `default_directory` (+ `private://` if `use_private` and the user has `access advanced file destination private files`); plus active `afd_directory` entities (status=1, sorted by weight then name, skipping non-valid schemes); plus scanned subfolders when `scan_filesystem` is on. The list is then filtered by `filterDirectoriesByPermission()` (admins see all; `private://` needs the private-files permission; per-directory `directory_permissions` config can require a specific permission).

## Integrations
- `hook_focal_point_file_paths_alter()` re-points Focal Point image-style renditions to the custom directory when one is set and differs from default.
- `FilePreRenderSubscriber::preRenderCallback()` (a trusted callback) re-forces `#upload_location`/`#file_directory` on file elements from the stored selection during pre-render.
