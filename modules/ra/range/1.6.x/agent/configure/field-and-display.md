<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a range field, its widget and its formatter

The module has **no admin page** (`configure: null`). Everything is per-field config:
`field.storage.*`, `field.field.*`, `core.entity_form_display.*`, `core.entity_view_display.*`.

## 1. Storage settings (`field.storage.<entity>.<field>`)

| Field type | Storage settings | Column type |
|---|---|---|
| `range_integer` | *(none)* | `int` × 2 |
| `range_float` | *(none)* | `float` × 2 |
| `range_decimal` | `precision` (10–32, default 10), `scale` (0–10, default 2) | `numeric` × 2 |

Both columns are named **`from`** and **`to`**. `precision`/`scale` are locked once the field
has data (`#disabled => $has_data`).

## 2. Field (instance) settings (`field.field.<entity>.<bundle>.<field>`)

Identical for all three types (`RangeItemBase::defaultFieldSettings()`):

```yaml
settings:
  min: ''          # '' = no minimum; integer for range_integer, float otherwise
  max: ''          # '' = no maximum
  field:     { prefix: '', suffix: '' }   # wraps the whole rendered range
  from:      { prefix: '', suffix: '' }   # wraps the FROM value
  to:        { prefix: '', suffix: '' }   # wraps the TO value
  combined:  { prefix: '', suffix: '' }   # used when FROM == TO and range_combine is on
```

`min`/`max` only bound the widget's `#min`/`#max`; the hard guarantees are the two constraints
(see below). The four prefix/suffix pairs are stored here but **displayed only if the formatter
enables the matching `*_prefix_suffix` checkbox**.

## 3. Widget settings — `type: range` (`core.entity_form_display.…`)

```yaml
content:
  field_price:
    type: range
    settings:
      label:       { from: From, to: to }   # required, defaults 'From' / 'to'
      placeholder: { from: '',   to: '' }
```

Renders two `#type: number` inputs in a fieldset (a plain container when cardinality > 1),
attaches the `range/range.field-widget` library, and sets `#step` to `pow(0.1, scale)` for
`range_decimal` and `'any'` for `range_float`.

## 4. Formatter settings (`core.entity_view_display.…`)

Shared by **all five** formatters (`RangeFormatterBase::defaultSettings()`):

```yaml
settings:
  range_separator: '-'          # string placed between FROM and TO
  range_combine: true           # collapse to one value when FROM == TO
  field_prefix_suffix: false    # render the FIELD prefix/suffix pair
  from_prefix_suffix: false
  to_prefix_suffix: false
  combined_prefix_suffix: false # only meaningful when range_combine is true
```

Plus, per formatter:

| Formatter id | Label | Extra settings |
|---|---|---|
| `range_integer` | Default | `thousand_separator` (`''`) |
| `range_decimal` | Default | `thousand_separator`, `decimal_separator` (`.`), `scale` (2) |
| `range_integer_sprintf` | Formatted string | `format_string` (`%d`) |
| `range_decimal_sprintf` | Formatted string | `format_string` (`%.2f`) |
| `range_unformatted` | Unformatted | *(none — prints the raw number)* |

Prefix/suffix resolution when the range is **combined** (`RangeFormatterBase::viewElementCombined()`):
COMBINED wins if enabled; else FROM's pair if only FROM is enabled; else TO's pair if only TO is;
else FROM's prefix + TO's suffix if both are; else no affixes.

## Create a field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_price',
  'entity_type' => 'node',
  'type' => 'range_decimal',
  'settings' => ['precision' => 10, 'scale' => 2],
])->save();

FieldConfig::create([
  'field_name' => 'field_price',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Price Range',
  'settings' => [
    'min' => 10, 'max' => 5000,
    'field' => ['prefix' => '', 'suffix' => ' per night'],
    'from' => ['prefix' => '$', 'suffix' => ''],
    'to' => ['prefix' => '$', 'suffix' => ''],
    'combined' => ['prefix' => 'flat $', 'suffix' => ''],
  ],
])->save();

\Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default')
  ->setComponent('field_price', ['type' => 'range', 'region' => 'content'])
  ->save();

\Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default')
  ->setComponent('field_price', [
    'type' => 'range_unformatted',
    'label' => 'above',
    'region' => 'content',
    'settings' => [
      'range_separator' => ' to ',
      'range_combine' => TRUE,
      'field_prefix_suffix' => FALSE,
      'from_prefix_suffix' => FALSE,
      'to_prefix_suffix' => FALSE,
      'combined_prefix_suffix' => TRUE,
    ],
  ])->save();
```

## Read it back

```bash
drush cget field.field.node.article.field_price settings
drush cget core.entity_form_display.node.article.default content.field_price
drush cget core.entity_view_display.node.article.default content.field_price
```

## Setting and reading values

There is **no `value` property** — `mainPropertyName()` returns NULL:

```php
$node->field_price = ['from' => 80, 'to' => 220];   // or ->appendItem(['from' => …, 'to' => …])
$from = $node->field_price->from;
$to   = $node->field_price->to;
```

## Validation

Both constraints are declared on every range field type and always apply:

- **`RangeBothValuesRequired`** — "Both range values (FROM and TO) are required."
- **`RangeFromGreaterTo`** — "The FROM value is higher than the TO value."

`isEmpty()` treats an item as empty only when *both* ends are empty (`'0'` counts as filled).

## Views

`hook_field_views_data()` (in `range.views.inc`) adds, per range field, a **`<label> range filter`**
and a **`<label> range argument`** (both `id: range`, plus `-revision_id` variants on revisionable
entities). Operators are `within` ("Range contains") and `not within`; options are `value` and
`include_endpoints`. The filter asks *"does the stored range contain this number?"*, which is the
inverse of a normal numeric filter.
