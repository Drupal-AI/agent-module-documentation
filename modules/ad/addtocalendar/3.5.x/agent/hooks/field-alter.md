<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter emitted event values

`addtocalendar.api.php` invites two hooks that let you rewrite the value the module emits for a
field before it is turned into the calendar entry. Both receive the value by reference and the
source entity.

```php
/**
 * Alter any field's emitted add-to-calendar value.
 */
function hook_addtocalendar_field_alter(&$value, \Drupal\Core\Entity\EntityInterface $entity) {
  $value = 'This field was altered.';
}

/**
 * Alter one specific field's value (replace FIELD_NAME with the machine name).
 */
function hook_addtocalendar_field_FIELD_NAME_alter(&$value, \Drupal\Core\Entity\EntityInterface $entity) {
  $value = 'This field was altered.';
}
```

Use the generic form to touch every field the button pulls in (title, description, location,
organizer, dates); use the `_FIELD_NAME_` variant to target a single field, e.g.
`hook_addtocalendar_field_field_venue_alter()`. Typical uses: append a suffix to the location,
strip HTML from a description, or compute an organizer string from multiple entity properties.
