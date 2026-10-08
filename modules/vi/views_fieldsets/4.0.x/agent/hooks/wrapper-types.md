<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_views_fieldsets_wrapper_types_alter()

Add or change the wrapper types offered in the Fieldset field's **Wrapper type**
select. Defined in `views_fieldsets.api.php`; invoked from
`Fieldset::getWrapperTypes()` (statically cached, via `moduleHandler()->invokeAll()`).

Default types: `details`, `fieldset`, `div` (keyed `key => label`).

```php
/**
 * Implements hook_views_fieldsets_wrapper_types_alter().
 */
function mymodule_views_fieldsets_wrapper_types_alter(array &$data) {
  // Key = machine name = theme-hook suffix, value = human label.
  $data['modal-group'] = 'modal-group';
}
```

To make a new wrapper actually render, also provide a matching theme hook +
template named `views_fieldsets_<key>` (see [templates](../theming/templates.md)).
`RowFieldset::getWrapperType()` falls back to the first available type if the
selected one is unknown, so a wrapper without a template will not render your markup.
