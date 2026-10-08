<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using / extending Autocomplete Flexible

## As a field widget
On an entity-reference field, go to **Manage form display** for the bundle and choose the **Autocomplete Flexible** widget (`EntityReferenceAutocompleteFlexibleWidget`). It supports single and multiple/unlimited-cardinality selection, showing chosen items as a removable list backed by a hidden value.

## As a form element (custom forms)
```php
$form['ref'] = [
  '#type' => 'autocomplete_flexible',
  '#title' => $this->t('Pick items'),
  '#autocomplete_route_name' => 'system.entity_autocomplete',
  '#autocomplete_route_parameters' => ['target_type' => 'node', 'selection_handler' => 'default'],
  '#flexible_default_value' => '',          // JS may alter before submit
  '#flexible_options' => ['minLength' => 3],// passed to the JS plugin
];
```
Values are stored in a hidden field, separated by `|`; the visible textfield triggers suggestions after `MIN_LENGTH` (3) characters. Reconfigure the JS behaviour per instance through `#flexible_options`.

## Altering the selected label
Implement the documented hook to change what text is shown for a picked entity:
```php
function mymodule_autocomplete_flexible_widget_label(string &$label, FormStateInterface $form_state, array $context): void {
  // $context = ['entity' => EntityInterface, 'field_name' => string]
  $label = $context['entity']->label() . ' (#' . $context['entity']->id() . ')';
}
```

## Reference
See the `autocomplete_flexible_examples` submodule for a working `AutocompleteController` and `ExampleForm`.
