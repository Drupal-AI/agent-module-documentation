<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks (`scss_compiler.api.php`)

Two hooks let code influence compilation. Implement them in a module (or theme, via
`alterForTheme`) — the service runs the module hook then the active theme's.

## `hook_scss_compiler_import_paths_alter(array &$additional_import_paths)`

Add extra directories the compiler searches for `@import`. Useful to import a Sass framework
shipped in vendor/.

```php
function my_module_scss_compiler_import_paths_alter(array &$additional_import_paths) {
  $additional_import_paths[] = \Drupal::service('file_system')
    ->realpath('vendor/zurb/foundation/scss');
}
```

Then in your `.scss`: `@import 'foundation';`.

## `hook_scss_compiler_variables_alter(\Drupal\scss_compiler\ScssCompilerAlterStorage $storage)`

Inject or override Sass variables at compile time — globally, per module/theme, or per file.

```php
function my_module_scss_compiler_variables_alter(\Drupal\scss_compiler\ScssCompilerAlterStorage $storage) {
  // All files:
  $storage->set(['mainColor' => '#f00']);

  // Only files belonging to a given module/theme namespace:
  $storage->set(['mainColor' => '#f00'], 'my_module');

  // Only a specific source file (supports @namespace tokens):
  $storage->setByFile(['mainColor' => '#f00'], 'modules/custom/my_module/styles.scss');
  $storage->setByFile(['mainColor' => '#f00'], '@my_module/styles.scss');
}
```

`ScssCompilerAlterStorage::getAll($namespace, $source_path)` (called by the compiler plugin)
merges the global, namespace and per-file overrides for the file being compiled and passes
them to the parser via `setVariables()`.
