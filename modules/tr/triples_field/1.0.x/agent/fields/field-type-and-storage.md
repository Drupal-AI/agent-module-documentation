<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, storage and settings

Class `\Drupal\triples_field\Plugin\Field\FieldType\TriplesField` (`@FieldType id = "triples_field"`,
`default_widget = "triples_field_table"`, `default_formatter = "triples_field_table"`).

## The three columns come from config

The sub-field machine names are **not hard-coded**. They are read at runtime from the config
object `triples_field.settings`:

```yaml
# config/install/triples_field.settings.yml
fields:
  first: First subfield
  second: Second subfield
  third: Third subfield
```

Every method (`schema()`, `propertyDefinitions()`, `defaultStorageSettings()`, constraints, the
widgets and formatters) iterates `array_keys(\Drupal::config('triples_field.settings')->get('fields'))`.
There is **no admin form** to change this object, and the config schema/`field.value.triples_field`
default-value schema list exactly `first` / `second` / `third`, so in practice the columns are
fixed at those three keys. Editing the config object (via config import) to add/rename keys is
technically what the loops read, but is unsupported and would desync the fixed schema.

## Properties

`propertyDefinitions()` defines, per column: a data property named after the column, plus a
companion `<column>_format` (`filter_format`) property used only when the storage type is
`text_long`. Typed-data types are normalized: `text` / `telephone` / `text_long` → `string`,
`numeric` → `float`. **`mainPropertyName()` returns `NULL`** — there is no `->value`; read
`$item->first`, `$item->second`, `$item->third`.

## Storage types (field-storage settings form)

`storageSettingsForm()` renders a `details` group per column. Each column's **type** is one of
(`subfieldTypes()`):

| Stored type          | Label (UI)            | DB column                                   |
| -------------------- | --------------------- | ------------------------------------------- |
| `boolean`            | Boolean               | `int` tiny                                  |
| `string`             | Text                  | `varchar(maxlength)`                        |
| `text`               | Text (long)           | `text` big                                  |
| `text_long`          | Text (formatted, long)| `text` big + `<col>_format` `varchar_ascii(255)` |
| `integer`            | Integer               | `int` normal                                |
| `float`              | Float                 | `float` big                                 |
| `numeric`            | Decimal               | `numeric(precision, scale)`                 |
| `email`              | Email                 | `varchar(254)` (`Email::EMAIL_MAX_LENGTH`)  |
| `telephone`          | Telephone             | `varchar(maxlength)`                        |
| `datetime_iso8601`   | Date                  | `varchar(20)`                               |
| `uri`                | Url                   | `varchar(2048)`                             |

Per-type storage inputs: `maxlength` (string/telephone), `precision`/`scale` (numeric),
`datetime_type` = `datetime`|`date`. All storage inputs are **`#disabled` once the field holds
data** (`$has_data`). On a brand-new field the form defaults cardinality to unlimited (-1).
Changing a column's storage type after the fact triggers `hook_field_storage_config_update`,
which warns the admin to re-check the widget config.

## Instance settings (field settings form)

`fieldSettingsForm()` renders per column: **Label**, **Required** (default TRUE), and — for types
where `isListAllowed()` (string, integer, float, numeric, email, telephone, uri,
datetime_iso8601) — a **Limit allowed values** checkbox plus a `key|label` **Allowed values**
textarea (validated by `validateAllowedValues()` against the column type: string length, integer
regex, numeric `is_numeric`). Numeric types also get **Min**/**Max**. Boolean gets **On/Off
labels**. Allowed values are stored as a `[{value,label}]` sequence
(`fieldSettingsToConfigData()` / `...FromConfigData()`).

## Constraints (`getConstraints()`)

Assembled into a single `ComplexData` constraint per item:

- List columns with allowed values → `AllowedValues`.
- `string` / `telephone` → `Length` max = maxlength; `email` → `Length` max = 254.
- Non-list numeric columns → `Range` min/max when set.
- Required columns → `NotBlank`, except **boolean** required → `NotEqualTo` value 0 (via
  `hook_validation_constraint_alter`, which points `NotEqualTo` at the Symfony constraint, so
  `'0'` counts as empty).

`isEmpty()` returns TRUE only when every column is NULL/`''` (a boolean counts as filled only
when `== 1`). `generateSampleValue()` produces realistic random values per column type.

## Create a field programmatically

```php
// Storage: pick a type per column. Locked after data exists.
FieldStorageConfig::create([
  'field_name' => 'field_spec',
  'entity_type' => 'node',
  'type' => 'triples_field',
  'cardinality' => -1,
  'settings' => [
    'storage' => [
      'first'  => ['type' => 'string',  'maxlength' => 255, 'precision' => 10, 'scale' => 2, 'datetime_type' => 'datetime'],
      'second' => ['type' => 'numeric', 'maxlength' => 255, 'precision' => 10, 'scale' => 2, 'datetime_type' => 'datetime'],
      'third'  => ['type' => 'datetime_iso8601', 'maxlength' => 255, 'precision' => 10, 'scale' => 2, 'datetime_type' => 'date'],
    ],
  ],
])->save();

FieldConfig::create([
  'field_name' => 'field_spec',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Spec',
  'settings' => [
    'first'  => ['label' => 'Attribute', 'required' => TRUE,  'list' => FALSE, 'allowed_values' => [], 'min' => '', 'max' => '', 'on_label' => 'On', 'off_label' => 'Off'],
    'second' => ['label' => 'Value',     'required' => TRUE,  'list' => FALSE, 'allowed_values' => [], 'min' => 0,  'max' => '', 'on_label' => 'On', 'off_label' => 'Off'],
    'third'  => ['label' => 'As of',     'required' => FALSE, 'list' => FALSE, 'allowed_values' => [], 'min' => '', 'max' => '', 'on_label' => 'On', 'off_label' => 'Off'],
  ],
])->save();

// Write a value:
$node->field_spec->appendItem(['first' => 'Weight', 'second' => '12.5', 'third' => '2026-01-31']);
```
