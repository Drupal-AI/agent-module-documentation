# Alter Colorbox runtime options

`colorbox.api.php` documents one alter hook.

## `hook_colorbox_settings_alter(array &$settings, string &$style)`
Fires when Colorbox JS settings are assembled and attached. Mutate `$settings` (any Colorbox
JS option, e.g. `scalePhotos`, `maxWidth`) and/or swap the active `$style` plugin. Setting
`$style = 'none'` loads no Colorbox theme.

```php
function mymodule_colorbox_settings_alter(&$settings, &$style) {
  // Don't downscale large images.
  $settings['scalePhotos'] = FALSE;

  // Use a custom style on a specific path.
  if (\Drupal::service('path.current')->getPath() === '/node/123') {
    $style = 'mystyle';
  }
}
```

Settings originate from `colorbox.settings` config and are exposed to JS via `drupalSettings`.
