# Configure the BigInt field

No global settings page. `bigint` behaves like any Drupal field: add a **Number (bigint)** field
to a fieldable entity (*Manage fields → Add field*), then set storage and field settings on its
edit form. It exists to give you a 64-bit `BIGINT` DB column where core's Integer (32-bit) would
overflow.

## Plugins the module registers

| Kind | id | Extends | Notes |
|---|---|---|---|
| Field type | `bigint` | `NumericItemBase` | DB column `type:int, size:big` → `BIGINT`. Label "Number (bigint)". |
| Widget | `bigint` | `NumberWidget` | Standard number input; default widget for the type. |
| Formatter | `bigint_item_default` | `IntegerFormatter` | Default formatter; string-safe thousand grouping. |
| Feeds target | `bigint` | Feeds `Integer` target | Only active when `feeds` is installed. |

## Storage settings (`field.storage_settings.bigint`)

Set once when the field is created (locked after data exists).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `unsigned` | boolean | `TRUE` | Checkbox label *"Do not allow values less than 0"*. When on, the DB column is `unsigned` **and** a `Range` constraint (`min: 0`) rejects negatives in validation. |
| `size` | string | `big` | Passed to the schema as the integer size; `big` yields a `BIGINT` column. |

`storageSettingsForm()` only exposes the `unsigned` checkbox; `size` stays `big`.

## Field settings (`field.field_settings.bigint`)

Inherits **core's integer field settings** (`field.field_settings.integer`): `min`, `max`,
`prefix`, `suffix`. Use `min`/`max` to bound the allowed range; `prefix`/`suffix` for display.

## Constraints & precision

- Unsigned fields get a typed-data `Range` constraint with `min: 0` (message includes the field
  label) in addition to the DB-level unsigned column.
- The default formatter's `numberFormat()` reverses the string, `str_split`s into groups of 3, and
  re-inserts the thousand separator — avoiding float rounding on numbers beyond PHP int precision.
- `generateSampleValue()` returns `mt_rand(min ?: 0, max ?: 999)` for generated/test content.

## Add a bigint field with Drush (example)

```php
// drush php:eval — add an unsigned bigint field "field_external_id" to node.article.
$storage = \Drupal::entityTypeManager()->getStorage('field_storage_config');
$storage->create([
  'field_name' => 'field_external_id',
  'entity_type' => 'node',
  'type' => 'bigint',
  'settings' => ['unsigned' => TRUE, 'size' => 'big'],
])->save();
\Drupal::entityTypeManager()->getStorage('field_config')->create([
  'field_name' => 'field_external_id',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'External ID',
])->save();
```

Then place the `bigint` widget on the form display and the `bigint_item_default` formatter on the
view display (they are the defaults, so a plain `setComponent()` with no explicit type also works).
