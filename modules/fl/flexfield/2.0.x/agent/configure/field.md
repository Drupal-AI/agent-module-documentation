<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a flex field: columns, sub-field types, widget, formatter

No admin page (`configure: null`). Everything is per-field config in `field.storage.*`,
`field.field.*`, `core.entity_form_display.*`, `core.entity_view_display.*`. The field type id is
`flex`, default widget `flex_default`, default formatter `flex_formatter`.

## 1. Storage settings (`field.storage.<entity>.<field>` → `settings`)

Declare the columns. Each column becomes a `varchar(max_length)` DB column named by `name`.

```yaml
settings:
  columns:
    value:  { name: value,  max_length: 255 }
    color:  { name: color,  max_length: 50 }
    amount: { name: amount, max_length: 20 }
```

- At least one column always exists (`FlexItem::defaultStorageSettings()` seeds `value`/255) because
  the table is built before you customise.
- On the storage form the rows live in an `items` fieldset while editing; `submitStorageConfigEditForm`
  re-keys them into `columns` on save. In stored config it is always `columns`.
- Column `name` and `max_length` inputs are `#disabled` once the field has data — you cannot rename,
  resize, add or remove columns after data exists.
- The storage form also offers **Clone Settings From** an existing flexfield of the same entity type:
  it copies that field's `columns` (and, as a starting point, its `field_settings`) into this field.
  Widget/formatter display settings are not cloned.

## 2. Instance settings (`field.field.<entity>.<bundle>.<field>` → `settings`)

`field_settings`, one block per column, assigns the sub-field type and its settings
(`FlexItem::defaultFieldSettings()` = `{'field_settings': []}`; blocks are built by
`FlexFieldTypeManager::getFlexFieldItems()`):

```yaml
settings:
  field_settings:
    color:
      type: select                # a FlexFieldType plugin id; defaults to 'text'
      widget_settings:
        label: 'Colour'           # defaults to ucfirst(column name) if unset
        description: ''
        required: false
        allowed_values: { red: Red, blue: Blue }   # select/radios only
      formatter_settings:
        render: value             # select/radios: 'value' (label) | 'key'
      check_empty: true           # if all check_empty columns are empty, the row is dropped
      weight: 0                   # drag-and-drop order on the field settings table
```

Common `widget_settings` keys (from `FlexFieldTypeBase`): `label` (required, non-empty), `description`,
`required`. Type-specific extras:

| `type` | Extra widget_settings | formatter_settings | Edit widget | Display transform |
|---|---|---|---|---|
| `text` | — | — | `textfield` (maxlength = column length) | raw value |
| `integer` | `min`, `max` | — | `number` | raw value |
| `float` | `min`, `max` | — | `number` (`#scale: any`) | raw value |
| `decimal` | `min`, `max`, `scale` | — | `number` (stepped by `scale`) | raw value |
| `select` | `allowed_values` (key/label) | `render`: value \| key | `select` (with "- Select -") | maps key → label unless `render: key` |
| `radios` | `allowed_values` | `render` | `radios` | as select |
| `checkbox` | — | `value_checked` (Yes), `value_unchecked` (No) | `checkbox` | prints checked/unchecked text; `never_check_empty` |
| `uuid` | — | — | hidden `value` (auto UUID on first save) | raw UUID |

`required` is forced FALSE while editing on the `field_config_form` so the settings form itself never
blocks. `check_empty` is forced off and disabled for `uuid`/`checkbox` (their annotation flags it).

## 3. Widget (`core.entity_form_display.…` → `content.<field>`)

Two widgets, both with a `label` setting (show the overall field label, default TRUE):

```yaml
content:
  field_specs:
    type: flex_default        # or flex_stacked
    settings:
      label: true
      # flex_default only:
      customize: false        # turn on manual proportions
      proportions: { value: two, color: one }   # one|two|three|four per column
      breakpoint: ''          # '' | medium (<769px) | small (<601px) — stack point
```

- `flex_default` lays sub-widgets out inline (CSS flex). `proportions` (only when `customize` is on)
  give relative widths — 1/1/2 → 25%/25%/50%. `breakpoint` stacks them below that width.
- `flex_stacked` renders each sub-field on its own row; no proportion settings.

## 4. Formatter (`core.entity_view_display.…` → `content.<field>`)

Five formatters, all `field_types = {flex}`:

| id | Label | Settings |
|---|---|---|
| `flex_formatter` | Flexfield (default) | `label_display`: per-column map, each `above` (default) \| `inline` \| `hidden` \| `visually_hidden`. Renders `#theme flexfield`. |
| `flex_inline` | Inline | `show_labels` (FALSE), `label_separator` (`': '`), `item_separator` (`', '`) |
| `flex_table` | Table | none — one HTML table, columns = sub-field labels, rows = items |
| `flex_list` | HTML List | `list_type`: `ul` (default) \| `ol`; each item rendered `label: value` |
| `flex_template` | Custom Template | `template`: string with `[name]` and `[name:label]` tokens; newlines → `<br>` |

```yaml
content:
  field_specs:
    type: flex_formatter
    label: above
    settings:
      label_display: { value: above, color: inline }
```

## Create a field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_specs',
  'entity_type' => 'node',
  'type' => 'flex',
  'cardinality' => -1,
  'settings' => [
    'columns' => [
      'attribute' => ['name' => 'attribute', 'max_length' => 128],
      'value'     => ['name' => 'value',     'max_length' => 255],
    ],
  ],
])->save();

FieldConfig::create([
  'field_name' => 'field_specs',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Specs',
  'settings' => [
    'field_settings' => [
      'attribute' => [
        'type' => 'text',
        'widget_settings' => ['label' => 'Attribute', 'description' => '', 'required' => TRUE],
        'formatter_settings' => [],
        'check_empty' => TRUE,
        'weight' => 0,
      ],
      'value' => [
        'type' => 'select',
        'widget_settings' => ['label' => 'Value', 'required' => FALSE,
          'allowed_values' => ['s' => 'Small', 'm' => 'Medium', 'l' => 'Large']],
        'formatter_settings' => ['render' => 'value'],
        'check_empty' => TRUE,
        'weight' => 1,
      ],
    ],
  ],
])->save();

\Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default')
  ->setComponent('field_specs', ['type' => 'flex_default', 'region' => 'content'])
  ->save();

\Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default')
  ->setComponent('field_specs', ['type' => 'flex_table', 'label' => 'above', 'region' => 'content'])
  ->save();
```

## Read config back

```bash
drush cget field.storage.node.field_specs settings
drush cget field.field.node.article.field_specs settings
drush cget core.entity_form_display.node.article.default content.field_specs
drush cget core.entity_view_display.node.article.default content.field_specs
```

## Set and read values

There is no main property; address each column by name:

```php
$node->field_specs = ['attribute' => 'Weight', 'value' => 'm'];
$node->field_specs->appendItem(['attribute' => 'Colour', 'value' => 's']);
$first = $node->field_specs->attribute;   // 'Weight'
```

An item is dropped on save when every column whose `check_empty` is TRUE is empty
(`FlexItem::isEmpty()`). A `varchar` `Length.max` constraint per column comes from
`FlexItem::getConstraints()`.
