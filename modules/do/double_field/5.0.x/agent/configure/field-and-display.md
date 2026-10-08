<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a double_field, its widget and its formatter

No admin page (`configure: null`). Everything is per-field config in `field.storage.*`,
`field.field.*`, `core.entity_form_display.*`, `core.entity_view_display.*`.

## 1. Storage settings (`field.storage.<entity>.<field>` → `settings`)

```yaml
settings:
  storage:
    first:  { type: string, maxlength: 255, precision: 10, scale: 2, datetime_type: datetime }
    second: { type: string, maxlength: 255, precision: 10, scale: 2, datetime_type: datetime }
```

`type` is the only always-relevant key; the rest apply conditionally. All ten types come from
`DoubleField::subfieldTypes()`:

| `type` | UI label | DB column | Relevant extra keys |
|---|---|---|---|
| `boolean` | Boolean | `int` (tiny) | — |
| `string` | Text | `varchar(maxlength)` | `maxlength` |
| `text` | Text (long) | `text` (big) | — |
| `integer` | Integer | `int` | — |
| `float` | Float | `float` (big) | — |
| `numeric` | Decimal | `numeric(precision,scale)` | `precision` (10–32), `scale` (0–10) |
| `email` | Email | `varchar(254)` | — |
| `telephone` | Telephone | `varchar(maxlength)` | `maxlength` |
| `datetime_iso8601` | Date | `varchar(20)` | `datetime_type`: `datetime` \| `date` |
| `uri` | Url | `varchar(2048)` | — |

All storage keys are `#disabled` once the field has data. Changing a subfield's type afterwards
triggers a warning from `hook_field_storage_config_update()` telling you to re-check the widget.

## 2. Instance settings (`field.field.<entity>.<bundle>.<field>` → `settings`)

One block per subfield (`DoubleField::defaultFieldSettings()`):

```yaml
settings:
  first:
    label: ''            # shown by the widget and used as a default table column label
    required: true       # per-subfield; adds NotBlank (or NotEqualTo 0 for boolean)
    list: false          # limit to allowed values (only for list-capable types)
    allowed_values: {}   # key => label; stored in config as a sequence of {value, label}
    min: ''              # integer/float/numeric only -> Range constraint
    max: ''
    on_label: 'On'       # boolean only
    off_label: 'Off'
  second:
    …same keys…
```

`list` is offered only for the list-capable types (`DoubleField::isListAllowed()`):
`string`, `integer`, `float`, `numeric`, `email`, `telephone`, `uri`, `datetime_iso8601` —
i.e. **not** `boolean` and **not** `text`. Allowed values take precedence over `min`/`max`.

Note the config-vs-runtime shape difference: in the exported YAML `allowed_values` is a
**sequence of `{value, label}` mappings**, converted to/from a flat `key => label` array by
`fieldSettingsToConfigData()` / `fieldSettingsFromConfigData()`. Set it as a flat array in PHP.

## 3. Widget settings — `type: double_field`

```yaml
content:
  field_specs:
    type: double_field
    settings:
      inline: false                 # lay both sub-widgets out side by side
      first:
        type: textfield             # the sub-widget, see the matrix below
        label_display: block        # block | inline | invisible | hidden
        size: 30                    # textfield/email/tel/url
        placeholder: ''             # textfield/textarea/email/tel/url
        label: 'Ok'                 # checkbox label
        cols: 10                    # textarea
        rows: 5                     # textarea
      second: { …same keys… }
```

Legal sub-widgets per storage type (`getSubWidgets()`) — plus `select` and `radios` prepended
whenever that subfield's `list` is on:

| storage type | sub-widget `type` options |
|---|---|
| `boolean` | `checkbox` |
| `string` | `textfield`, `email`, `tel`, `url`, `color` |
| `email` | `email`, `textfield` |
| `telephone` | `tel`, `textfield` |
| `uri` | `url`, `textfield` |
| `text` | `textarea` |
| `integer` / `float` / `numeric` | `number`, `textfield`, `range` |
| `datetime_iso8601` | `datetime` |

`label_display` is hidden for `checkbox`, and `datetime` drops the `inline`/`invisible` options.

## 4. Formatter settings (`core.entity_view_display.…`)

Shared by all four formatters (`Base::defaultSettings()`), one block per subfield:

```yaml
settings:
  first:
    hidden: false             # drop this subfield from the output entirely
    link: false               # email/telephone/uri only -> mailto:/tel:/absolute link
    format_type: medium       # datetime_iso8601 only -> a core date format id
    thousand_separator: ''    # integer/float/numeric
    decimal_separator: '.'    # float/numeric
    scale: 2                  # float/numeric (forced to 0 for integer)
    key: false                # list subfields only: print the key instead of the label
  second: { …same keys… }
```

Per formatter:

| Formatter id | Label | Extra settings |
|---|---|---|
| `double_field_unformatted_list` | Unformatted List | `inline` (default TRUE) |
| `double_field_html_list` | HTML List | `inline`, `list_type`: `ul` (default) \| `ol` \| `dl` |
| `double_field_details` | Details | `open` (default TRUE) |
| `double_field_table` | Table | `number_column` (FALSE), `number_column_label` (`№`), `first_column_label`, `second_column_label` |

`inline` comes from `ListBase` and is ignored when `list_type` is `dl`. The Table formatter only
emits a `<thead>` if at least one column label is non-empty. The Details formatter puts `first`
in `#title` and `second` in `#value`.

## Create a field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

$storage = FieldStorageConfig::create([
  'field_name' => 'field_specs',
  'entity_type' => 'node',
  'type' => 'double_field',
  'cardinality' => -1,
]);
$storage->setSetting('storage', [
  'first'  => ['type' => 'string',  'maxlength' => 64,  'precision' => 10, 'scale' => 2, 'datetime_type' => 'datetime'],
  'second' => ['type' => 'numeric', 'maxlength' => 255, 'precision' => 14, 'scale' => 3, 'datetime_type' => 'datetime'],
]);
$storage->save();

FieldConfig::create([
  'field_name' => 'field_specs',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Technical Specs',
  'settings' => [
    'first'  => ['label' => 'Attribute', 'min' => '', 'max' => '', 'list' => FALSE,
                 'allowed_values' => [], 'required' => TRUE, 'on_label' => 'On', 'off_label' => 'Off'],
    'second' => ['label' => 'Value', 'min' => 0, 'max' => 1000, 'list' => FALSE,
                 'allowed_values' => [], 'required' => TRUE, 'on_label' => 'On', 'off_label' => 'Off'],
  ],
])->save();

\Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default')
  ->setComponent('field_specs', ['type' => 'double_field', 'region' => 'content'])
  ->save();

\Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default')
  ->setComponent('field_specs', [
    'type' => 'double_field_html_list',
    'label' => 'above',
    'region' => 'content',
    'settings' => ['list_type' => 'dl'] + \Drupal\double_field\Plugin\Field\FieldFormatter\HtmlList::defaultSettings(),
  ])->save();
```

A list-constrained subfield in PHP uses the **flat** shape:

```php
'first' => ['label' => 'Verdict', 'list' => TRUE,
            'allowed_values' => ['gold' => 'Gold', 'silver' => 'Silver', 'bronze' => 'Bronze'],
            'required' => TRUE, 'min' => '', 'max' => '', 'on_label' => 'On', 'off_label' => 'Off'],
```

## Read it back

```bash
drush cget field.storage.node.field_specs settings
drush cget field.field.node.article.field_specs settings
drush cget core.entity_form_display.node.article.default content.field_specs
drush cget core.entity_view_display.node.article.default content.field_specs
```

## Setting and reading values

`mainPropertyName()` is NULL, so there is no `->value`:

```php
$node->field_specs = ['first' => 'Weight', 'second' => 4.2];
$node->field_specs->appendItem(['first' => 'Material', 'second' => 1.0]);
$first = $node->field_specs->first;
$second = $node->field_specs->second;
```

For a `datetime_iso8601` subfield the stored string is UTC in `Y-m-d\TH:i:s` (or `Y-m-d` when
`datetime_type` is `date`); `$item->createDate('first')` returns a `DrupalDateTime` built with
the storage timezone.

## Validation

`DoubleField::getConstraints()` assembles a `ComplexData` constraint per subfield from the
instance settings:

| Setting | Constraint added |
|---|---|
| `list` + `allowed_values` | `AllowedValues` with the value keys as `choices` |
| type `string` / `telephone` | `Length.max` = storage `maxlength` |
| type `email` | `Length.max` = 254 |
| `min` / `max` on a numeric type and `list` off | `Range.min` / `Range.max` |
| `required` (non-boolean) | `NotBlank` |
| `required` (boolean) | `NotEqualTo` value 0 |

`isEmpty()` is TRUE only when *both* subfields are empty (a boolean subfield counts as filled
only when it equals 1).
