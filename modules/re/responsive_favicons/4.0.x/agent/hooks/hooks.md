# Hooks (`responsive_favicons.api.php`)

Two alter hooks let other modules modify the module's output.

## `hook_responsive_favicons_tags_alter(array &$tags)`

Alter the loaded tags array before it is attached to the page head. `$tags` is the
structure returned by `responsive_favicons.manager::loadAll()` — it contains `links`
(head `<link>` attribute arrays), `metatags` (`<meta>` attribute arrays), and `missing`.

```php
function mymodule_responsive_favicons_tags_alter(array &$tags) {
  // e.g. drop or add a specific link/meta tag.
  unset($tags['metatags'][0]);
}
```

## `hook_responsive_favicons_icon_path_alter(string &$icon_path, \Drupal\Core\Config\Config $config)`

Alter the normalised icon path as the module rewrites each icon reference. `$config` is the
(possibly not-yet-saved) `responsive_favicons.settings` config.

```php
use Drupal\Core\Config\Config;

function mymodule_responsive_favicons_icon_path_alter(string &$icon_path, Config $config) {
  $icon_path = ltrim($icon_path, '/');
}
```

## Hooks the module itself implements (for reference, not to override)

`hook_page_attachments()` and `hook_page_attachments_alter()` (add tags / remove the default
favicon), `hook_preprocess_maintenance_page()` (cover the maintenance page),
`hook_help()`, `hook_requirements()`, `hook_uninstall()` (delete the upload dir), and
`hook_update_8001()`.
