<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works + extending

## The comparison pipeline

1. Get the list of projects and their installed versions from core's `update` module
   (`update_get_available()` / `update_calculate_project_data()`).
2. For each project, download the **official release archive** for the installed version. The
   downloader classes handle this: `HackedProjectWebDownloader` (base),
   `HackedProjectWebFilesDownloader`, `HackedProjectWebDevDownloader`.
3. Build a `HackedFileGroup` for both the downloaded ("clean") copy and the local copy, then
   hash every non-binary file with the selected hasher.
4. Compare hashes → each file is *unchanged*, *different*, or *missing*; the project rolls up
   to a status constant on `HackedProject`:
   - `HACKED_STATUS_UNHACKED` → "Unchanged"
   - `HACKED_STATUS_HACKED` → "Changed"
   - `HACKED_STATUS_UNCHECKED` → "Unchecked" (couldn't download/compare)
5. The report is cached in the `hacked` cache bin (`cache.hacked` service).

`{project}` route params are loaded by the `hacked_project` param converter
(`HackedProjectConverter`).

## File hashers

Hashing is pluggable via a hook, not a plugin manager. `hook_hacked_file_hashers_info()`
returns an array keyed by hasher id, each with `class`, `name`, `description`. Core ships:

```php
function hacked_hacked_file_hashers_info() {
  return [
    'hacked_ignore_line_endings'  => ['class' => '\Drupal\hacked\HackedFileIgnoreEndingsHasher',  'name' => t('Ignore line endings'),  'description' => t('…')],
    'hacked_include_line_endings' => ['class' => '\Drupal\hacked\HackedFileIncludeEndingsHasher', 'name' => t('Include line endings'), 'description' => t('…')],
  ];
}
```

Add your own by implementing the hook in a custom module and providing a class extending
`HackedFileHasher` (implement `performHash($filename)`):

```php
function mymodule_hacked_file_hashers_info() {
  return [
    'mymodule_normalized' => [
      'class' => '\Drupal\mymodule\MyNormalizingHasher',
      'name' => t('Normalize whitespace'),
      'description' => t('Ignore all whitespace when hashing.'),
    ],
  ];
}
```

Then select it in `hacked.settings:selected_file_hasher`. Helpers `hacked_get_file_hashers()`
and `hacked_get_file_hasher($name)` resolve the configured hasher.

## Theme hooks

`hacked_theme()` defines the report/summary/file-status templates
(`templates/hacked-*.html.twig`) — override in a theme to restyle the report.
