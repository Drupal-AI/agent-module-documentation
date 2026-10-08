<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: bypass validation for a field

Declared in `url_friendly_options.api.php`.

## `hook_url_friendly_options_bypass_field_validation($field_name, $entity_type_id)`

Return `TRUE` to exempt a specific field storage from **both** the field-form URL-friendly
validation and the `hook_requirements()` status check. Return `FALSE` (or nothing) to keep it
enforced.

```php
/**
 * Implements hook_url_friendly_options_bypass_field_validation().
 */
function mymodule_url_friendly_options_bypass_field_validation($field_name, $entity_type_id) {
  // Let this one legacy field keep its underscore keys.
  if ($field_name === 'field_legacy_status' && $entity_type_id === 'node') {
    return TRUE;
  }
  return FALSE;
}
```

## How it is invoked

Both call sites use `\Drupal::moduleHandler()->invokeAll('url_friendly_options_bypass_field_validation', $context)`
with `$context = ['field_name' => …, 'entity_type_id' => …]`, and bypass if **any** module returned
`TRUE` (`in_array(TRUE, $hooks_return, TRUE)`):

- `url_friendly_options_validate()` — skips the form error for that field.
- `url_friendly_options_requirements()` — skips that field storage in the status-report scan.

Notes:
- The hook receives the field storage **name** and the **entity type id** (not the bundle), so an
  exemption applies to the field storage across all bundles.
- `invokeAll` passes the `$context` array's values as positional arguments, matching the
  `($field_name, $entity_type_id)` signature.
