# The `choices_widget` field widget

Source: `src/Plugin/Field/FieldWidget/ChoicesWidget.php` (extends core `OptionsSelectWidget`,
`multiple_values = TRUE`). Choose it on an entity's **Manage form display**
(`admin/structure/…/form-display`) for a supported field, then set its options via the widget cog.

## Supported field types

`entity_reference`, `list_integer`, `list_float`, `list_string`. (It is a select-based widget, so the
field must expose an options list.)

## Widget setting

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `configuration_options` | string (JSON) | `''` | Per-field [Choices options](https://github.com/Choices-js/Choices#configuration-options). Validated as a JSON object (`validateConfigOptions`), same rule as the global form. |

Stored in the `entity_form_display` component under `settings.configuration_options` (schema
`field.widget.settings.choices_widget`).

## Options merge order

In `formElement()` the widget deep-merges its own options over the global ones:

```
widget configuration_options  >  global choices.settings.configuration_options  >  Choices defaults
```

Merge is `array_merge_recursive(global, widget)` (widget wins on duplicate deepest keys). The result is
attached as `drupalSettings.choices.widget.fields[<field_name>].configurationOptions` (cast to a JS
object) and the `choices/widget` library is attached. `js/choices_widget.js` instantiates Choices on that
field's select.

## Set the widget with Drush (example)

```php
// ddev drush php:eval
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_tags', [
  'type' => 'choices_widget',
  'region' => 'content',
  'settings' => ['configuration_options' => '{"removeItemButton": true, "searchFields": ["label"]}'],
])->save();
```

Note: the global mode and the widget are independent — the widget works even when `enable_globally` is
off. Both consume the same `choices/library` (local or CDN per `use_cdn`).
