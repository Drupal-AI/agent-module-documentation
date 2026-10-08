<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# multi_column_options_buttons widget

## Install / enable
`drush en checkbox_radio_buttons_multi_columns` (pulls in core `options`). Nothing else to configure
globally — there is no settings route.

## The plugin
`src/Plugin/Field/FieldWidget/MultiColumnOptionsButtonsWidget.php`
- `@FieldWidget(id = "multi_column_options_buttons", label = "Check boxes/radio buttons (multi-columns)")`,
  `multiple_values = TRUE`.
- `field_types`: `boolean`, `entity_reference`, `list_integer`, `list_float`, `list_string`.
- Extends core `Drupal\Core\Field\Plugin\Field\FieldWidget\OptionsButtonsWidget` — it inherits all normal
  checkbox/radio behavior and only adds a column count.

Methods:
- `defaultSettings()` → `['columns' => 1] + parent::defaultSettings()`.
- `settingsForm()` → adds one element: `columns`, a required `#type => number` field
  ("Columns" / "Amount of columns the checkboxes should be divided on.").
- `settingsSummary()` → "Number of columns: @columns".
- `formElement()` → calls `parent::formElement()`, then, only when the built element's `#type` is
  `checkboxes`, sets `$element['#checkbox_radio_buttons_multi_columns'] = $this->getSetting('columns')`.
  (Radio single-value elements are `radios`, so the extra property is attached for the multi-value
  checkboxes case.)

## Rendering (the preprocess hook)
`checkbox_radio_buttons_multi_columns.module` → `hook_preprocess_checkboxes()`:
```
$columns = $variables['element']['#checkbox_radio_buttons_multi_columns'] ?? 0;
if ($columns > 1) {
  $variables['attributes']['style'] = 'column-count: ' . $columns;
}
```
So the multi-column layout is produced purely by the browser's CSS `column-count` on the `checkboxes`
wrapper. When `columns <= 1` no style is added and rendering is identical to the core widget. No JS or
CSS library ships with the module.

## Configuration & schema
There is no module config object. The `columns` value is stored in the entity form-display component
settings for the field, e.g. exported under `core.entity_form_display.<entity>.<bundle>.<mode>` as
`content.<field>.settings.columns`. Schema lives in
`config/schema/checkbox_radio_buttons_multi_columns.schema.yml`:
```
field.widget.settings.multi_column_options_buttons:
  type: mapping
  mapping:
    columns:
      type: integer
```

To use it: Manage form display for a bundle → pick "Check boxes/radio buttons (multi-columns)" for a
supported field → open the settings gear → set Columns.

## Access / routes / services
None. The module adds no routes, permissions, services, or entities; configuration happens entirely
through core's Field UI form-display screens (gated by core's own field-UI permissions).

## Tests
`tests/src/Kernel/MultiColumnOptionsbuttonsTest.php` (`@group checkbox_radio_buttons_multi_columns`)
renders the element and a real node form and asserts the output contains `column-count: <n>`.
