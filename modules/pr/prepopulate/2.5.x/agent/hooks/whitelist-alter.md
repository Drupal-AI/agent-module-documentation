<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_prepopulate_whitelist_alter()`

The only hook the module invites (`prepopulate.api.php`). It runs **once, in the `Populate`
service constructor**, so the altered list applies to every populate call in that request.

```php
/**
 * Implements hook_prepopulate_whitelist_alter().
 */
function mymodule_prepopulate_whitelist_alter(array &$whitelisted_types) {
  $whitelisted_types[] = 'my_custom_element';   // allow a custom #type
  $whitelisted_types[] = 'radios';              // re-enable radios (see warning)
}
```

Signature: `hook_prepopulate_whitelist_alter(array &$whitelisted_types)` — a flat, numerically
indexed array of render-element `#type` strings. Add with `[] =`; remove with
`array_diff`/`unset` + `array_values`.

**Security warning.** `radios` and `checkboxes` are excluded on purpose: with them whitelisted, a
crafted link handed to an administrator can pre-tick options on any admin form. Only add them for
forms you control, ideally combined with a `hook_form_alter()` that removes
`prepopulate_after_build` from `#after_build` on admin routes.

Put the implementation in a normal module file (`mymodule.module`) or an OOP hook class
(`src/Hook/…` with `#[Hook('prepopulate_whitelist_alter')]` on Drupal 11).

Verify it took effect:

```bash
drush cr
drush ev '$s=\Drupal::service("prepopulate.populator");
$p=(new ReflectionClass($s))->getProperty("whitelistedTypes"); $p->setAccessible(TRUE);
var_dump(in_array("radios", $p->getValue($s)));'
```
