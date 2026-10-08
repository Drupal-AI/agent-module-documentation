# file_replace — programmatic surface

The module exposes no service API to call directly. Its extension point is one **invited hook**.

## `hook_file_replace(\Drupal\file\FileInterface $file)`

Invoked (via `moduleHandler->invokeAll('file_replace', [$file])`) **after** a file's contents have
been overwritten and the file entity re-saved. `$file` is the existing, now-updated file entity
(same URI, same fid, new bytes/size). Return value is ignored. Use it to run side effects such as
purging a CDN, clearing caches, or notifying a service.

```php
/**
 * Implements hook_file_replace().
 */
function mymodule_file_replace(\Drupal\file\FileInterface $file) {
  \Drupal::logger('mymodule')->info('Replaced @uri', ['@uri' => $file->getFileUri()]);
  // e.g. purge a CDN path, invalidate cache tags, etc.
}
```

Built-in implementations for reference:

- **file_replace** itself flushes all image-style derivatives for the file's URI when the file is an
  image and the `image` module is enabled (so cached thumbnails regenerate).
- The **file_replace_shell_exec** submodule runs a configured shell command.

## Triggering the replace form in code / links

- **Link template:** the `file` entity gains a `replace-form` link template (added in
  `hook_entity_type_build`). Build a URL with `$file->toUrl('replace-form')`; call `->access()` to
  check the current user may replace it.
- **Form class:** `Drupal\file_replace\Form\FileReplaceForm` (form operation `replace` on the `file`
  entity, a `ContentEntityForm`). There is no API to replace a file *without* an interactive upload —
  replacement always goes through this upload form. To swap bytes purely in code, use core's
  `\Drupal::service('file_system')->copy($src, $file->getFileUri(), FileExists::Replace)` and re-save
  the file entity yourself (that is essentially what the form's `save()` does).
