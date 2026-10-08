<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks

Declared in `imagecache_external.api.php`. All three are `hook_..._alter` (invoked with
`\Drupal::moduleHandler()->alter()`), so implement them as `HOOK_alter` functions with the args
by reference.

| Hook | Fired in | Signature | Use |
|---|---|---|---|
| `hook_imagecache_external_needs_refresh_alter(&$needs_refresh, $filepath)` | `imagecache_external_generate_path()` before returning a cached file | set `$needs_refresh = TRUE` to force a re-fetch | Re-download changed remote images on a schedule (e.g. older than a week). The module's own default impl sets TRUE when the file doesn't exist. |
| `hook_imagecache_external_destination_alter(&$alter, $context)` | Early in `generate_path()` | `$alter = ['scheme' => …, 'directory' => …]`; `$context = ['url' => …, 'hash' => …]` | Route certain URLs to a different stream wrapper (e.g. `s3`) or directory. |
| `hook_imagecache_external_flush_filepath_alter(array &$files_to_delete)` | `imagecache_external_flush_create_queue()` | array of derivative file paths to delete | Add extra derivative paths (e.g. `.webp`, `.avif`) or remove entries from a flush. |

## Examples

```php
// Refresh cached images older than a week.
function mymodule_imagecache_external_needs_refresh_alter(&$needs_refresh, $filepath) {
  if (filemtime($filepath) < \Drupal::time()->getRequestTime() - 60 * 60 * 24 * 7) {
    $needs_refresh = TRUE;
  }
}

// Store images from example.com in a custom directory / scheme.
function mymodule_imagecache_external_destination_alter(&$alter, $context) {
  if (str_contains($context['url'], 'example.com')) {
    $alter['scheme'] = 's3';
    $alter['directory'] = 'my-custom-directory';
  }
}

// Also delete generated .webp/.avif derivatives on flush.
function mymodule_imagecache_external_flush_filepath_alter(array &$files_to_delete) {
  foreach ($files_to_delete as $filepath) {
    $files_to_delete[] = $filepath . '.webp';
    $files_to_delete[] = $filepath . '.avif';
  }
}
```
