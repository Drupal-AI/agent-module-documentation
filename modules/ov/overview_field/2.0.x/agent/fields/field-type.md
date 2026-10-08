# The overview_field field type, widget and formatter

Three field plugins under `src/Plugin/Field/`. All three are trivial glue around the two alter
hooks documented in [../hooks/extension.md](../hooks/extension.md); on their own they render nothing.

| Plugin | id | Class | Notes |
|---|---|---|---|
| Field type | `overview_field` | `FieldType/OverviewField.php` | `default_widget = overview_field_widget`, `default_formatter = overview_field_formatter` |
| Widget | `overview_field_widget` | `FieldWidget/OverviewFieldWidget.php` | a `select` |
| Formatter | `overview_field_formatter` | `FieldFormatter/OverviewFieldFormatter.php` | dispatches on the stored key |

## Stored value & schema

The field stores one property, `value`, a string. `schema()` (`OverviewField.php:39`) defines a
single column:

- `type`: `varchar_ascii` when the field storage setting `is_ascii === TRUE`, else `varchar`.
- `length`: `255`.
- `binary`: the field setting `case_sensitive` (drives case-sensitive collation).

The property definition (`propertyDefinitions()`, `OverviewField.php:26`) marks `value` required and
carries the `case_sensitive` setting. Note the module does **not** declare
`defaultStorageSettings()` / `defaultFieldSettings()`, so `is_ascii` and `case_sensitive` are unset
(effectively falsy) unless another field type reuses this — in practice you get a plain
`varchar(255)`. `isEmpty()` returns TRUE when `value` is `NULL` or `''` (`OverviewField.php:56`).

The stored value is the **option key** (e.g. `recent_content`) chosen in the widget — not the
rendered output. Rendering happens later, in the formatter.

## Widget — `overview_field_widget`

`formElement()` (`OverviewFieldWidget.php:57`) builds `$options = []`, then calls
`$this->moduleHandler->alter('overview_field_options', $options)` and produces:

```php
$element['value'] = $element + [
  '#type' => 'select',
  '#default_value' => $items[$delta]->value ?? NULL,
  '#required' => FALSE,
  '#options' => $options,            // filled by hook_overview_field_options_alter()
  '#empty_option' => $this->t('No overview'),
  '#empty_value' => '',
];
```

So with no implementing module the select shows only "No overview" and stores `''` (empty).
`settingsForm()`/`settingsSummary()` return empty arrays — the widget has no configurable settings.
`module_handler` is injected via `create()`.

## Formatter — `overview_field_formatter`

`viewElements()` iterates items and calls `viewValue()` (`OverviewFieldFormatter.php:90`):

```php
$output = [];
$value = $item->getValue();
$this->moduleHandler->alter('overview_field_output', $value['value'], $output);
return $output;                       // render array from hook_overview_field_output_alter()
```

The stored key is passed as the first alter argument and the render array is built by reference by
the implementing module. `defaultSettings()`, `settingsForm()`, `settingsSummary()` are stubs — the
formatter has no settings of its own. It renders whatever the output hook returns (an empty array
when nothing matches the key). `module_handler` is injected via `create()`.

## Attaching the field from code

```php
// Storage + instance on node.article, then wire widget and formatter.
FieldStorageConfig::create([
  'field_name' => 'field_overview',
  'entity_type' => 'node',
  'type' => 'overview_field',
])->save();
FieldConfig::create([
  'field_name' => 'field_overview',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Overview',
])->save();

\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_overview', ['type' => 'overview_field_widget'])
  ->save();
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_overview', ['type' => 'overview_field_formatter'])
  ->save();
```

Via the UI this is just the normal *Manage fields* → add field "Overview field", then *Manage form
display* / *Manage display* (no field- or widget-specific settings to fill in).

## single_content_sync round-trip

`overview_field.module` implements `hook_content_export_field_value_alter()` and
`hook_content_import_field_value_alter()`: for fields of type `overview_field` the export copies
`$field->getValue()` and the import calls `$entity->set($field_name, $field_value)`. This keeps the
stored key intact when exporting/importing content with the `single_content_sync` module.
