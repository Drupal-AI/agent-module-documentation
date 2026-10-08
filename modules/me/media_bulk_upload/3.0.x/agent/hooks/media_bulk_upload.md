# Hooks

## `hook_media_bulk_upload_file_ids_alter(array &$file_ids, string $media_bulk_config_id)`

Invoked in `MediaBulkUploadForm::submitForm()` (via `\Drupal::moduleHandler()->alter('media_bulk_upload_file_ids', …)`)
after the form is submitted but before the batch that creates media entities. `$file_ids` initially holds the value
of the `file_upload` form element; rewrite it to a flat array of `file` entity IDs to control which files become media.

The DropzoneJS submodule uses this hook: the DropzoneJS widget returns uploaded file *paths* under
`$file_ids['uploaded_files']`, so its implementation creates permanent `file` entities from those paths and replaces
`$file_ids` with the resulting IDs.

```php
function mymodule_media_bulk_upload_file_ids_alter(array &$file_ids, string $media_bulk_config_id) {
  // Example: skip processing for a specific configuration.
  if ($media_bulk_config_id === 'archive') {
    $file_ids = [];
  }
}
```

If `$file_ids` is empty after alteration, the submit handler returns without creating any media.

## Entity CRUD hooks

`media_bulk_config` is a config entity and each upload creates a core `media` content entity, so the standard generic
`hook_entity_*` / `hook_media_*` hooks fire on save/insert of the created media. Use these to react to media produced by
a bulk upload (e.g. tagging, notifications).
