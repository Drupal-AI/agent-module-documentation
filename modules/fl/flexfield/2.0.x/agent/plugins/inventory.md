<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin inventory + writing a custom sub-field type

All plugins use **annotations** (not PHP attributes). The module defines core-plugin instances plus
**one plugin type of its own**, `FlexFieldType`.

## Field type

| id | Class | Label | default_widget | default_formatter |
|---|---|---|---|---|
| `flex` | `Plugin\Field\FieldType\FlexItem` | Flexfield | `flex_default` | `flex_formatter` |

Every column is a `varchar(max_length)` string property (`propertyDefinitions()` / `schema()` iterate
`settings.columns`). No `mainPropertyName()`. `getConstraints()` adds a `Length.max` per column.
`isEmpty()` returns TRUE when every column with `check_empty` on is empty. `generateSampleValue()`
fills each column with a random word. The storage form's Add/Remove/Clone and the field-settings
table are all built here.

## Widgets (core `@FieldWidget`, `field_types = {flex}`)

| id | Class | Label | Settings |
|---|---|---|---|
| `flex_default` | `FieldWidget\FlexWidget` | Flexfield | `label`, `customize`, `proportions` (per column: one/two/three/four), `breakpoint` ('' / medium / small) — inline CSS-flex layout |
| `flex_stacked` | `FieldWidget\FlexStackedWidget` | Stacked | `label` — one sub-field per row |

Both extend `FlexWidgetBase` (injects the manager, adds the `label` show-field-label setting). Each
sub-widget's form array comes from `$flexitem->widget()`.

## Formatters (core `@FieldFormatter`, `field_types = {flex}`)

| id | Class | Label | Settings |
|---|---|---|---|
| `flex_formatter` | `FlexFormatter` | Flexfield (default) | `label_display` per column (above/inline/hidden/visually_hidden) → `#theme flexfield` |
| `flex_inline` | `FlexInlineFormatter` | Inline | `show_labels`, `label_separator`, `item_separator` |
| `flex_table` | `FlexTableFormatter` | Table | none; one `#theme table`, columns = labels, rows = items |
| `flex_list` | `FlexListFormatter` | HTML List | `list_type` (ul/ol) → `#theme item_list`, item = `label: value` |
| `flex_template` | `FlexTemplateFormatter` | Custom Template | `template` with `[name]` / `[name:label]` tokens, newlines → `<br>` |

All extend `FlexFormatterBase` (injects the manager, exposes `getFlexFieldItems()`). Display value for
each column comes from `$flexitem->value($item)`.

## Theme

`hook_theme()` registers `flexfield` (template `templates/flexfield.html.twig`, preprocess
`template_preprocess_flexfield` in `flexfield.theme.inc`), variables `items` + `field_name`. The
default formatter also asks for suggestion `flexfield__<field_name>`. Libraries `flexfield-admin`,
`flexfield-inline`, `flexfield-inline-admin` are CSS/JS for the admin table and inline layout.

## The `FlexFieldType` plugin type (defined by this module)

This is a genuine, discoverable plugin type — other modules can add sub-field types.

- Manager service: `plugin.manager.flexfield_type`, class
  `Plugin\FlexFieldTypeManager` (parent `default_plugin_manager`).
- Subdir: `Plugin/FlexFieldType`; interface `Plugin\FlexFieldTypeInterface`;
  base class `Plugin\FlexFieldTypeBase`; annotation `Annotation\FlexFieldType`.
- Alter hook: `hook_flexfield_info_alter()`; cache key `flexfield_type_plugins`.

### Bundled FlexFieldType plugins

| id | Class | Notes |
|---|---|---|
| `text` | `Plugin\FlexFieldType\Text` | plain `textfield` |
| `integer` | `Plugin\FlexFieldType\Integer` | extends `NumericBase`; `min`/`max` |
| `float` | `Plugin\FlexFieldType\FloatType` | `NumericBase`; `#scale: any` |
| `decimal` | `Plugin\FlexFieldType\Decimal` | `NumericBase`; adds `scale` (0–10) |
| `select` | `Plugin\FlexFieldType\Select` | `allowed_values`; formatter `render` value/key |
| `radios` | `Plugin\FlexFieldType\Radios` | extends `Select`; `radios` widget |
| `checkbox` | `Plugin\FlexFieldType\Checkbox` | `never_check_empty = TRUE`; `value_checked`/`value_unchecked` display |
| `uuid` | `Plugin\FlexFieldType\Uuid` | hidden widget, auto-generates a UUID on first save |

(`NumericBase` is a shared base, not itself a plugin.)

### Annotation keys (`@FlexFieldType`)

`id`, `label`, `description`, `check_empty` (default TRUE — the per-item empty-check default),
`never_check_empty` (default FALSE — overrides `check_empty`, e.g. `uuid`/`checkbox`).

### Interface / base contract

`FlexFieldTypeInterface` methods your plugin implements (most provided by `FlexFieldTypeBase`):
`defaultWidgetSettings()` / `defaultFormatterSettings()` (static), `widgetSettingsForm()`,
`formatterSettingsForm()`, `widget($items, $delta, $element, &$form, $form_state)` (returns the render
element for one column's input), `value(FlexItem $item)` (the displayed value), `getLabel()`,
`getName()`, `getWidgetSetting()/getFormatterSetting()`, `getWidgetSettings()/getFormatterSettings()`.
`FlexFieldTypeBase` initialises `name`, `max_length`, `widget_settings`, `formatter_settings` from
the plugin `$configuration` and defaults the label to the column name.

### Add a custom sub-field type

```php
// modules/custom/mymod/src/Plugin/FlexFieldType/Color.php
namespace Drupal\mymod\Plugin\FlexFieldType;

use Drupal\flexfield\Plugin\FlexFieldTypeBase;
use Drupal\flexfield\Plugin\Field\FieldType\FlexItem;
use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Form\FormStateInterface;

/**
 * @FlexFieldType(
 *   id = "color",
 *   label = @Translation("Color"),
 *   description = @Translation("A hex color value.")
 * )
 */
class Color extends FlexFieldTypeBase {

  public function widget(FieldItemListInterface $items, $delta, array $element, array &$form, FormStateInterface $form_state) {
    $element = parent::widget($items, $delta, $element, $form, $form_state);
    return ['#type' => 'color'] + $element;
  }

  // Optional: override value() to transform stored output,
  // widgetSettingsForm()/formatterSettingsForm() for extra settings,
  // defaultWidgetSettings()/defaultFormatterSettings() for their defaults.
}
```

Clear caches; the new type then appears in the per-column **type** select on the field settings form.
Store any custom sub-value in the same `varchar(max_length)` column — there is no schema extension
point, so values must fit a string column.
