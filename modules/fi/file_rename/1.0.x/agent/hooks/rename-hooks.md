<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rename mechanism & the hooks it invites

## What happens on save (`FileRenameForm::save`)

1. Build new basename = `<new_filename>.<original_extension>` (extension is not editable).
2. Validate: source file exists on disk; the value has no path/slash; it passes core's
   `FileUploadSanitizeNameEvent`; and no file with the target name already exists in the
   same directory.
3. `\Drupal::moduleHandler()->invokeAll('file_prerename', [$file])` — **before** the move.
4. `FileSystem::move($oldUri, $newUri, FileSystemInterface::EXISTS_REPLACE)`.
5. `$file->setFilename(...)`, `$file->setFileUri(...)`, `$file->save()`.
6. `\Drupal::moduleHandler()->invokeAll('file_rename', [$file])` — **after** the move+save.

The new URI is derived by replacing the old filename stem inside the existing URI, so the
directory (stream wrapper + path) is preserved; only the base name changes.

## Hooks you can implement

These are ordinary `invokeAll` hooks (no `.api.php` file ships, but the invocations above are
the contract). Implement in `yourmodule.module`:

```php
/**
 * Runs just before the file is moved/renamed. Good for cache flushing.
 */
function yourmodule_file_prerename(\Drupal\file\FileInterface $file) {
  // $file still has its OLD filename/URI here.
}

/**
 * Runs after the file has been moved, renamed and re-saved.
 */
function yourmodule_file_rename(\Drupal\file\FileInterface $file) {
  // $file now has its NEW filename/URI.
}
```

The module's own `file_rename_file_prerename()` uses this to flush every image style
derivative (`ImageStyle::flush($uri)`) for image files so stale derivatives regenerate.

## Route / entity integration (for programmatic links)

- `hook_entity_type_build()` registers form class `rename` and link template `rename-form`
  on the `file` entity type, so `$file->toUrl('rename-form')` and `$file->access('rename')`
  work.
- `hook_entity_operation()` adds a **Rename** operation link to permanent files.
- Rename URL: `Url::fromRoute('entity.file.rename_form', ['file' => $fid], ['query' => ['destination' => ...]])`.
