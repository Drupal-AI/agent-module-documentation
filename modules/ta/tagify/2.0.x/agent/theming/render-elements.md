# Render elements

Tagify exposes two form/render elements (in `src/Element/`) you can use directly in
custom forms instead of the field widgets.

## `entity_autocomplete_tagify`
Class `Drupal\tagify\Element\EntityAutocompleteTagify` (extends core `Textfield`). Renders
a Tagify autocomplete bound to an entity type.

```php
$form['tags'] = [
  '#type' => 'entity_autocomplete_tagify',
  '#target_type' => 'taxonomy_term',
  '#selection_handler' => 'default',
  '#selection_settings' => ['target_bundles' => ['tags']],
  '#tags' => TRUE,
  '#cardinality' => -1,
];
```
A `#process` callback wires the autocomplete route, matcher, and Tagify library.

## `select_tagify`
Class `Drupal\tagify\Element\SelectTagify`. A Tagify-styled `select` element for fixed
option lists (`#options`).

Attach behavior automatically pulls in the `tagify/default` library plus the theme
variant chosen by `tagify.theme_resolver` (Claro/Gin).
