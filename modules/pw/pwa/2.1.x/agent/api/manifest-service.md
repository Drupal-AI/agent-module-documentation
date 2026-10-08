# The `pwa.manifest` service & manifest alter hook

## Service

`\Drupal::service('pwa.manifest')` (`Drupal\pwa\Manifest`, interface `ManifestInterface`),
constructed with `config.factory`, `module_handler`, `request_stack`, `theme.manager`,
`entity_type.manager`.

`->toArray(): array` builds the manifest data from `pwa.config`:

- Basic: `name`, `short_name`, `start_url`, `display`, `id` (from `app_id`).
- Recommended: `theme_color`, `background_color`, `scope`, `orientation`.
- `icons`: three entries (512/192/144) — from the uploaded file entities
  (`image_fid`/`image_small_fid`/`image_very_small_fid`) or the bundled `assets/icon-*.png`.
- Optional (added only when non-empty): `description`, `categories`, `lang`, `dir`.

Finally it invokes the module and theme alters before returning. The `pwa.manifest` route controller
JSON-encodes this array as `/manifest.json`.

```php
$data = \Drupal::service('pwa.manifest')->toArray();
```

## `hook_pwa_manifest_alter(&$manifestData)`

Alter the generated manifest before it is encoded (also available as a theme-level alter):

```php
/**
 * Implements hook_pwa_manifest_alter().
 */
function mymodule_pwa_manifest_alter(&$manifestData) {
  $manifestData['short_name'] = 'App';
  $manifestData['categories'][] = 'productivity';
}
```

`$manifestData` is passed by reference — modify it in place, no return value.
