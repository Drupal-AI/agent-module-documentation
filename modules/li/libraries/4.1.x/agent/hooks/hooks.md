# Hooks (libraries.api.php)

### Alter hooks (current)
Swap the class used for a built-in plugin without subclassing the manager.

```php
function hook_libraries_library_type_info_alter(array &$library_types) {
  $library_types['asset']['class'] = 'Drupal\mymodule\ExternalLibrary\BetterAssetLibraryType';
}
function hook_libraries_locator_info_alter(array &$locators) {
  $locators['stream']['class'] = 'Drupal\mymodule\ExternalLibrary\BetterStreamLocator';
}
function hook_libraries_version_detector_info_alter(array &$version_detectors) {
  $version_detectors['line_pattern']['class'] = 'Drupal\mymodule\...\BetterLinePatternDetector';
}
```
Each `&$info` array is keyed by plugin ID; entries have `id`, `class`, `provider`.

### `hook_libraries_info()` — DEPRECATED
The Drupal 7-style array declaration (name, vendor url, files js/css/php, version callback,
variants, versions, dependencies, callbacks). Documented in `libraries.api.php` for migration
reference but **deprecated**; new integrations should ship a JSON/YAML **definition** + typed
library plugins instead (see [../plugins/plugin-types.md](../plugins/plugin-types.md)).
