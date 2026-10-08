# `AutocompleteAttribute` plugin type

Maps a field widget to a WCAG 2.1 input purpose, applied as the HTML `autocomplete` attribute.

## Plugin machinery

- Manager service `a11y_form_helpers.autocomplete_attribute`
  (`AutocompleteAttributeManager`, extends `DefaultPluginManager`), namespace
  `Plugin/AutocompleteAttribute`, interface `AutocompleteAttributePluginBaseInterface`, annotation
  `@AutocompleteAttribute`.
- Annotation keys:
  - `id` — the plugin id **and the exact `autocomplete` attribute value** (e.g. `given-name`), per
    the WCAG input-purpose list.
  - `label` — human name shown in the "Purpose" select.
  - `field_types` — array of field types (e.g. `{"string"}`) the purpose is offered for.
- Base class `AutocompleteAttributePluginBase::fieldWidgetFormAlter()` sets
  `$element['value']['#attributes']['autocomplete'] = $this->getPluginId()`.
- `$manager->getPurposes($field_type = NULL)` returns `[id => label]` filtered to plugins supporting
  that field type (all if null).

## Built-in plugins

`given-name` and `name` (both for `string` fields). That's the full shipped set.

## How it is applied (no custom code needed to use)

- `hook_field_widget_third_party_settings_form` adds a **Purpose** select (options from
  `getPurposes($fieldType)`) to a widget's third-party settings on *Manage form display*, stored under
  third-party setting `a11y_form_helpers.purpose`.
- `hook_field_widget_form_alter` reads that purpose and, if the plugin exists, calls its
  `fieldWidgetFormAlter()` to add the `autocomplete` attribute to the rendered widget.
- `hook_field_widget_settings_summary_alter` shows the chosen purpose in the display summary.

## Adding a purpose

```php
/**
 * @AutocompleteAttribute(
 *   id = "email",
 *   label = @Translation("Email"),
 *   field_types = { "email", "string" }
 * )
 */
class Email extends AutocompleteAttributePluginBase {}
```

Place under `src/Plugin/AutocompleteAttribute/`. The `id` must be a valid `autocomplete` token. Override
`fieldWidgetFormAlter()` only if you need more than setting `autocomplete` on `$element['value']`.
