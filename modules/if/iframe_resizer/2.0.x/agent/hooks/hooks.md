<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# iFrame Resizer hooks

Two alter hooks (declared in `iframe_resizer.api.php`) let a module override the settings the module emits to `drupalSettings` at page-attachment time. Both receive the settings array by reference.

## `hook_iframe_resizer_host_settings_alter(array &$settings)`

Alters the **host**-mode settings (the site embedding resizable iframes) before they are written to `drupalSettings.iframeResizer.advanced`. `$settings` contains `targetSelectors`, `override_defaults`, and `options` (the full option map — see configure/settings.md).

```php
function mymodule_iframe_resizer_host_settings_alter(array &$settings) {
  $settings['override_defaults'] = TRUE;
  $settings['options']['log'] = FALSE;
  $settings['options']['bodyBackground'] = 'green';
}
```

## `hook_iframe_resizer_hosted_settings_alter(array &$settings)`

Alters the **hosted**-mode settings (the site shown inside another site's iframe) before they are written to `drupalSettings.iframeResizer.advancedHosted`. `$settings` contains `targetOrigin`, `heightCalculationMethod`, `widthCalculationMethod`.

```php
function mymodule_iframe_resizer_hosted_settings_alter(array &$settings) {
  $settings['targetOrigin'] = 'https://parent.example.com';
  $settings['heightCalculationMethod'] = 'max';
}
```

Both hooks are invoked via `\Drupal::moduleHandler()->alter(...)` inside `iframe_resizer_page_attachments()`, so they run on every page where the corresponding usage mode is enabled.
