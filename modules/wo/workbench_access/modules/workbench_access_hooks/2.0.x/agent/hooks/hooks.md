<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks: `hook_workbench_access_scheme_update_alter()`

The parent module declares this hook in `workbench_access.api.php`; this submodule is its
reference implementation.

```php
/**
 * Implements hook_workbench_access_scheme_update_alter().
 */
function workbench_access_hooks_workbench_access_scheme_update_alter(array &$settings, \Drupal\Core\Config\Config $config) {
  if ($config->get('scheme')) {
    $settings = [
      'test' => 'test',
    ];
  }
}
```

- **Signature:** `(array &$settings, \Drupal\Core\Config\Config $config)`.
- **Purpose:** rewrite an access scheme's `scheme_settings` — usually during an update/migration
  path — to match the array shape your AccessControlHierarchy plugin's
  `defaultConfiguration()` returns.
- **No return value:** mutate `$settings` by reference.
- **Guard on your plugin:** check `$config->get('scheme')` and only act on schemes your
  module owns, so you do not clobber other plugins' settings. (This test module acts on any
  non-empty scheme, which is fine for a test but not for production.)
