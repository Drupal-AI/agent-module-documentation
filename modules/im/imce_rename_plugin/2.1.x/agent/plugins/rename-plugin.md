<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Rename IMCE plugin

This module **implements** IMCE's `ImcePlugin` plugin type (it does not define a new plugin type).

```php
// src/Plugin/ImcePlugin/Rename.php
/**
 * @ImcePlugin(
 *   id = "rename",
 *   label = "Rename",
 *   operations = { "rename" = "opRename" }
 * )
 */
class Rename extends ImcePluginBase implements ContainerFactoryPluginInterface { … }
```

Injected services (via `create()`): `messenger`, `database`, `transliteration`, `file.repository`.

## Lifecycle

- **`permissionInfo()`** returns the two IMCE permissions: `rename_files`, `rename_folders`
  (see [permissions/rename-permissions.md](../permissions/rename-permissions.md)).
- **`buildPage(&$page, ImceFM $fm)`** — if the user has `rename_files` OR `rename_folders`, attaches
  the JS library `imce_rename_plugin/drupal.imce.rename`. That library (`js/plugins/imce.rename.js`)
  adds a **Rename** toolbar button (title "Rename", shortcut **Ctrl+Alt+W**, icon `file-text`) and a
  "New name" form; on submit it fires the `rename` AJAX operation on the current selection.
- **`opRename(ImceFM $fm)`** — the operation handler mapped from `operations.rename`. It reads the
  selection, checks the item `type` (`file` or `folder`), validates, and dispatches to `renameFile()`
  or `renameFolder()`.

## Name sanitization — `getNewName()`

The posted `new_name` is cleaned before use:

1. `mb_substr($name, 0, 50)` — crop to 50 characters.
2. `transliteration->transliterate()` — transliterate to ASCII.
3. spaces replaced with dashes (`-`).
4. `preg_replace('/[^\w_-]+/u', '', $name)` — strip anything that is not a word char, `_` or `-`.
5. if the result is empty, fall back to `time()` (a timestamp).

For **files** the original extension (`pathinfo($old_name, PATHINFO_EXTENSION)`) is re-appended, so
only the base name changes.

## Renaming a file — `renameFile()`

- Computes `$old_uri` / `$new_uri` from the active folder URI (handles the `public://` root).
- Refuses if `$new_uri` already exists (`file_exists`) → error message.
- Checks write access; if not writable, tries `chmod($old_uri, 0664)`; on failure → error.
- Loads the file entity (`Imce::getFileEntity`) or creates one (`Imce::createFileEntity`) if none,
  then `file.repository->move($file, $new_uri, FileExists::Error)`, `setFilename()`, `save()`.
- On success updates the IMCE JS list (adds new, removes old) and shows a success message.

## Renaming a folder — `renameFolder()`

- Same existing-name guard, then PHP `rename($old_uri, $new_uri)`.
- On success updates the IMCE JS list, then rewrites stored URIs: `UPDATE file_managed SET uri =
  REPLACE(uri, '<old>/', '<new>/') WHERE uri LIKE '<old>/%'`, and invalidates the affected files'
  cache tags (`Cache::invalidateTags(Cache::buildTags('file', $file_ids))`). Reports the count.

## Validation — `validateRename()`

`$items && $fm->validatePermissions($items, 'rename_files', 'rename_folders') &&
$fm->validatePredefinedPath($items)` — the selection must carry the right IMCE permission and be
inside the profile's predefined path. Client-side `imce.validateRename()` also blocks empty names.
