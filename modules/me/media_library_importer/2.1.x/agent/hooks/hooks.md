# Hooks

Defined in `media_library_importer.api.php`.

## `hook_alter_media_library_importer_media_extra_fields(FileInterface $file, string $file_url, string $uri, array &$extra_fields)`

Invoked (via `moduleHandler()->invokeAll(...)`) for each file *while building the queue*, before the queue item is
created. Add key/value pairs to `$extra_fields` to have them merged into the Media entity's create array in
`createMediaEntity()` (so keys must be valid field names on the target media bundle).

```php
function mymodule_alter_media_library_importer_media_extra_fields($file, $file_url, $uri, array &$extra_fields) {
  // e.g. tag every imported media with a term or set an alt text.
  $extra_fields['field_source'] = 'bulk-import';
}
```

Notes:
- `$file` is the already-saved File entity; `$file_url` is the absolute glob path; `$uri` is the mapped
  (`public://…` or absolute) URI.
- The alter name is literally `alter_media_library_importer_media_extra_fields` (not the usual `hook_` +
  `_alter` suffix convention) — implement `mymodule_alter_media_library_importer_media_extra_fields()`.

No other hooks are defined; the module implements only `hook_help`.
