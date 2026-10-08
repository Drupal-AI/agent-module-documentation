<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types Custom Field defines

Six plugin types, each with its own manager service. The first three are the ones you extend
to add a new subfield data kind, input, or display.

| Plugin type id | Manager service | Discovery dir | Attribute | Implements |
|---|---|---|---|---|
| `custom_field_type` | `plugin.manager.custom_field_type` | `Plugin/CustomField/FieldType` | `CustomFieldType` | subfield data types (schema, property, value) |
| `custom_field_widget` | `plugin.manager.custom_field_widget` | `Plugin/CustomField/FieldWidget` | `CustomFieldWidget` | per-column form input |
| `custom_field_formatter` | `plugin.manager.custom_field_formatter` | `Plugin/CustomField/FieldFormatter` | `CustomFieldFormatter` (annotation) | per-column display |
| `custom_field_feeds` | `plugin.manager.custom_field_feeds` | `Plugin/CustomField/FeedsType` | `CustomFieldFeedsType` | Feeds import targets |
| `custom_field_component_prop_widget` | `plugin.manager.custom_field_component_prop_widget` | `Plugin/Components/PropWidget` | `PropWidget` | SDC prop mapping widgets |
| `custom_field_link_attributes` | `plugin.manager.custom_field_link_attributes` | (YAML `*.custom_field_link_attributes.yml`) | — | link attribute options |

Base classes live in `src/Plugin/`: `CustomFieldTypeBase`, `CustomFieldWidgetBase`,
`CustomFieldFormatterBase`, `CustomFieldFeedsTypeBase`, `PropWidgetBase`.

## Add a subfield **type** (`custom_field_type`)

Attribute keys: `id`, `label`, `description`, `category`, `default_widget`,
`default_formatter`. Implement `schema()`, `propertyDefinitions()`, and value handling.

```php
use Drupal\custom_field\Attribute\CustomFieldType;
use Drupal\custom_field\Plugin\CustomFieldTypeBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[CustomFieldType(
  id: 'my_rating',
  label: new TranslatableMarkup('Rating'),
  description: new TranslatableMarkup('An integer 1–5.'),
  category: new TranslatableMarkup('General'),
  default_widget: 'integer',
  default_formatter: 'number_integer',
)]
class MyRatingType extends CustomFieldTypeBase {
  public static function schema(array $settings): array {
    return [$settings['name'] => ['type' => 'int', 'unsigned' => TRUE]];
  }
}
```

## Add a **widget** (`custom_field_widget`)

Attribute keys: `id`, `label`, `category`, `field_types` (array of `custom_field_type` ids it
serves). Extend `CustomFieldWidgetBase` and implement `widget()` / `widgetSettingsForm()`.

```php
#[CustomFieldWidget(id: 'my_slider', label: new TranslatableMarkup('Slider'),
  category: new TranslatableMarkup('General'), field_types: ['my_rating', 'integer'])]
class MySliderWidget extends CustomFieldWidgetBase { /* … */ }
```

## Add a **formatter** (`custom_field_formatter`)

Uses the `@CustomFieldFormatter` annotation with `id`, `label`, and `field_types`. Extend
`CustomFieldFormatterBase` and implement `formatValue()`.

## Base field widgets & formatters (not plugins you usually add)

The parent field's own widgets (`custom_flex`, `custom_stacked`) and formatters
(`custom_formatter`, `custom_inline`, `custom_list`, `custom_table`, `flipped_table`,
`custom_template`, `custom_field_sdc`) are standard core `Field/FieldWidget` and
`Field/FieldFormatter` plugins — extend those only to change the whole-field layout.
