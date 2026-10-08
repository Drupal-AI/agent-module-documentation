# Programmatic API — services

All services are autowirable by their interface name. Older procedural helpers
(`filefield_paths_process_string()`, `_filefield_paths_create_redirect()`,
`filefield_paths_batch_update()`, `filefield_paths_recommended_temporary_scheme()`) are
**deprecated** in 8.x-1.0 and removed in 2.0.0 — use these services instead.

## Clean a token-bearing string — `PathProcessorInterface`

`Drupal\filefield_paths\PathProcessorInterface::processString(string $value, array $data, array $settings = []): string`

Replaces tokens in `$value` using `$data` (passed to the Token service) and applies optional
cleanup. `$settings` flags: `transliterate`, `pathauto`, `slashes` (all boolean).

```php
$clean = \Drupal::service(\Drupal\filefield_paths\PathProcessorInterface::class)
  ->processString('[node:title]/[file:name]', ['node' => $node, 'file' => $file], [
    'transliterate' => TRUE,
    'pathauto' => TRUE,
    'slashes' => FALSE,
  ]);
```

## Create a redirect for a moved file — `RedirectInterface`

`Drupal\filefield_paths\RedirectInterface::createRedirect(string $source, string $path, \Drupal\Core\Language\Language $language)`

Creates a redirect from a file's old URL (`$source`) to its new URL (`$path`). Service id
`filefield_paths.redirect`; needs the Redirect module.

## Run a retroactive batch update — `BatchUpdaterInterface`

`Drupal\filefield_paths\Batch\BatchUpdaterInterface::batchUpdate(FieldConfigInterface $field_config): bool`

Sets up a batch to move/rename all existing files of the given field instance; returns TRUE if
there were paths to update. Service id `filefield_paths.batch.updater`. (This is what the field
settings form's "Retroactive update" and the `drush ffpu` command call.)

## Move-file helper — `MoveFileProcessorInterface`

`Drupal\filefield_paths\MoveFileProcessorInterface` (service by interface name) handles moving
uploaded files into their token-built path, including `recommendedFileScheme()` /
`recommendedTemporaryScheme()` for picking a sensible temporary scheme.
