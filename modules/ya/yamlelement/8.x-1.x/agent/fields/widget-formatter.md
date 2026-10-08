# `map` field widget and formatter

The module ships one widget and one formatter, both plugin id `yamlelement`, both for the core
**`map`** field type. Neither has any settings (empty `settingsForm()` / `settingsSummary()`, empty
config-schema mappings `field.widget.settings.yamlelement` / `field.formatter.settings.yamlelement`).

## Widget — `yamlelement` (`YamlWidget`)

`src/Plugin/Field/FieldWidget/YamlWidget.php`, `@FieldWidget(id="yamlelement", field_types={"map"})`,
extends `WidgetBase`. `formElement()` builds the `yaml` element (see
[../forms/yaml-element.md](../forms/yaml-element.md)) for each field item: it appends an empty item
when the list is empty, then for each item renders a `#type => 'yaml'` element keyed by the item's
`mainPropertyName()` (or the whole item value when the item has no main property), seeded with the
current value as `#default_value`. Because the underlying element parses on validate, the value
stored back to the `map` field is the **parsed PHP structure**, not the YAML text.

## Formatter — `yamlelement` (`YamlFormatter`)

`src/Plugin/Field/FieldFormatter/YamlFormatter.php`,
`@FieldFormatter(id="yamlelement", field_types={"map"})`, extends `FormatterBase`. `viewElements()`
unsets `$item->_attributes` (works around core issue node/2155247), reads the item's main-property
value (or whole value), runs `Yaml::dump($value, 999, 2, …)` and outputs it as `#markup` wrapped in
`#prefix => '<pre>'` / `#suffix => '</pre>'`.

## Attach from code

```php
// Widget (form display):
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_data', ['type' => 'yamlelement'])
  ->save();

// Formatter (view display):
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_data', ['type' => 'yamlelement'])
  ->save();
```

## Note on `map` fields

The `map` field type is not offered in the *Add field* UI by default, so this widget/formatter is
primarily useful for `map` fields defined in code (a base field, a computed field, or a `map` field
provided by another module). Once such a field exists, the two plugins appear on *Manage form
display* and *Manage display* for its entity/bundle.
