# Field widget: existing_autocomplete_field_widget

Class: `Drupal\existing_values_autocomplete_widget\Plugin\Field\FieldWidget\ExistingAutocompleteFieldWidget`
(extends core `StringTextfieldWidget`).

| Property | Value |
| --- | --- |
| Plugin id | `existing_autocomplete_field_widget` |
| Label | "Autocomplete: existing values" |
| Applies to field type | `string` (single-line text) only |
| Base class | `Drupal\Core\Field\Plugin\Field\FieldWidget\StringTextfieldWidget` |

It renders exactly like the standard textfield widget, but adds an autocomplete callback to the
`value` element. In `formElement()` it sets, on top of the parent element:

- `#autocomplete_route_name` = `existing_values_autocomplete_widget.autocomplete`
- `#autocomplete_route_parameters` = `entity_type_id`, `bundle`, `field_name`, where
  `bundle` falls back to the entity type id when the field has no target bundle (base field /
  non-bundleable entity): `$items->getFieldDefinition()->getTargetBundle() ?? $entity_type_id`.

## Settings

| Setting | Type | Default | Notes |
| --- | --- | --- | --- |
| `suggestions_count` | integer | `15` | Max suggestions returned. Form field is `#type => number`, `#required => TRUE`, `#min => 1`. |

`defaultSettings()` returns `['suggestions_count' => 15] + parent::defaultSettings()`.
`settingsSummary()` appends "Suggestions count: N". Config schema:
`field.widget.settings.existing_autocomplete_field_widget` extends
`field.widget.settings.string_textfield` and maps `suggestions_count` (integer).

## Enable it on a field (UI)

1. Add or reuse a single-line text (`string`) field on a bundle.
2. Go to the bundle's **Manage Form Display** and change that field's widget to
   "Autocomplete: existing values".
3. Set "How many autocomplete suggestions to show?" (`suggestions_count`).

Note: this does not work on base fields such as node `title` (see issue #3586007) — only on
configurable `string` fields whose form-display component uses this widget.

## Enable it via config / PHP

The widget lives in the entity form display config
(`core.entity_form_display.<entity_type>.<bundle>.<form_mode>`) under
`content.<field_name>.type`. Set it programmatically:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_department', [
    'type' => 'existing_autocomplete_field_widget',
    'settings' => ['suggestions_count' => 10],
  ])
  ->save();
```

The corresponding form-display YAML fragment:

```yaml
content:
  field_department:
    type: existing_autocomplete_field_widget
    settings:
      suggestions_count: 10
    weight: 0
    region: content
```

Because the autocomplete controller re-reads the form display and only serves fields whose
active widget is `existing_autocomplete_field_widget`, the widget must be the one actually
saved on the form display for suggestions to appear.
