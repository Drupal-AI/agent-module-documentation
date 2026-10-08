# Purge File hooks

Defined in `purge_file.api.php`.

## `hook_purge_file_base_urls_alter(array &$base_urls, FileInterface $file)`

Alter the list of base URLs that will be purged for a given file. Invoked (via
`ModuleHandler::alter('purge_file_base_urls', ...)`) inside `purge_file_purge()` after
the base URLs are resolved from config (or the current request host) and before the
purge URLs are built. Only affects the `url` / `wildcardurl` invalidation types (the
path types use the relative file path, not base URLs).

```php
/**
 * Implements hook_purge_file_base_urls_alter().
 */
function mymodule_purge_file_base_urls_alter(array &$base_urls, \Drupal\file\FileInterface $file) {
  // Add an extra CDN domain to purge for every file.
  $base_urls[] = 'https://cdn.example.com';

  // Or purge a different host only for a specific stream.
  if (str_starts_with($file->getFileUri(), 'private://')) {
    $base_urls[] = 'https://secure.example.com';
  }
}
```

Each entry is later combined as `rtrim($base_url, '/') . $file->createFileUrl()` (with a
trailing `*` added when a wildcard invalidation type is selected).
