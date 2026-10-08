<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `libraries_ui` service

`Drupal\libraries_ui\LibrariesUiService` (service id `libraries_ui`), constructed with
`module_handler`, `theme_handler`, `library.discovery`.

## `getAllLibraries(): array`

Returns all discovered asset libraries as a nested array:

```
[
  'core'          => [ '<library name>' => <definition>, ... ],
  '<module_name>' => [ '<library name>' => <definition>, ... ],
  '<theme_name>'  => [ '<library name>' => <definition>, ... ],
]
```

- Always includes `core`.
- For every installed module and (rebuilt) theme that ships a `<name>.libraries.yml`, it calls
  `LibraryDiscovery::getLibrariesByExtension($extension_name)` and includes the result.
- Each `<definition>` is the standard core library array (`version`, `css`, `js`, `dependencies`,
  `license`, ...).

Example:

```php
$libs = \Drupal::service('libraries_ui')->getAllLibraries();
$version = $libs['core']['drupal']['version'] ?? NULL;
foreach ($libs['system'] as $name => $def) {
  // inspect $def['dependencies'], $def['css'], ...
}
```

The module reads through core's library discovery only — it never caches or persists library data
itself.
