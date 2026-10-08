# Hooks (commerce_license.api.php)

Two alter hooks let you modify the available plugin lists after discovery.

## `hook_commerce_license_type_info_alter(array &$plugins)`

Alter the discovered **License type** plugin definitions.

```php
function mymodule_commerce_license_type_info_alter(array &$plugins) {
  // Remove a license type you don't use (WARNING: breaks existing licenses of that type).
  unset($plugins['some_plugin']);
  // Rename one.
  $plugins['role']['label'] = t('Membership role');
}
```

Invoked by `LicenseTypeManager` (alter id `commerce_license_type_info`).

## `hook_commerce_license_period_info_alter(array &$plugins)`

Alter the discovered **License period** plugin definitions (same pattern), invoked by
`LicensePeriodManager`.

```php
function mymodule_commerce_license_period_info_alter(array &$plugins) {
  $plugins['rolling_interval']['label'] = t('Rolling period');
}
```

Note: removing a plugin that has existing data will break those licenses/variations. For
lifecycle reactions (grant/expire/renew) use the `LicenseEvents` events, not these hooks.
