# The `multiselect` Form API element

Multiselect registers a render/form element `@FormElement("multiselect")`
(`Drupal\multiselect\Element\Multiselect`, a subclass of core's `Select`). Use it in any custom
form to get the two-box UI without a field:

```php
$form['colors'] = [
  '#type' => 'multiselect',
  '#title' => $this->t('Colors'),
  '#options' => ['r' => 'Red', 'g' => 'Green', 'b' => 'Blue'],
  '#default_value' => ['r', 'b'],   // selected keys
];
```

Behaviour / defaults from `getInfo()`:
- `#input => TRUE`, `#multiple => TRUE`, `#theme => 'multiselect'`, wrapped in `form_element`.
- Processed with core `Select::processSelect`; attaches library `multiselect/drupal.multiselect`.
- The submitted value is an array of the selected option keys, in the order they were selected
  (the widget preserves selection order via `Multiselect::getOptions()`).

## Theming

`hook_theme()` defines the `multiselect` theme hook, template `multiselect.html.twig`.
`template_preprocess_multiselect()` splits `#options` into two lists — `available` (unselected) and
`selected` — each rendered as a `<select multiple size=...>` with classes
`multiselect-available` / `multiselect-selected` and `form-multiselect`, plus Add/Remove labels.
Override the template in your theme to customise the markup.

## Field-widget internals (for reference)

`MultiselectWidget` (`@FieldWidget id="multiselect"`, extends `OptionsWidgetBase`,
`multiple_values = TRUE`) builds the same `#type => 'multiselect'` element from the field's allowed
options and, in `validateElement()`, transposes the selected keys back into Drupal field items
(dropping the `_none` option). There is no plugin type to implement — to add the UI elsewhere, reuse
the `#type => 'multiselect'` element above.
