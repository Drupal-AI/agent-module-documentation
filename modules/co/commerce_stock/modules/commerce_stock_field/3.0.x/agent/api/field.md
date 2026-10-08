# The stock level field

## Field type `commerce_stock_level`

Numeric storage (`value`, precision 19, scale 4). Defined in
`Plugin/Field/FieldType/StockLevel.php`. Not a plain scalar you set — saving through a widget
creates a stock **transaction** (via `StockLevelProcessor` and the stock service), so real
persistence needs `commerce_stock_local` and a variation whose service is `local_stock`.

## Widgets (field type `commerce_stock_level`)

| Widget id | Behavior | Key settings |
|---|---|---|
| `commerce_stock_level_simple` | Simple entry system; set/adjust the level | `entry_system`, `transaction_note` (bool), `context_fallback` (bool) |
| `commerce_stock_level_absolute` | Enter the exact resulting level; widget computes the adjusting transaction | `step`, `custom_transaction_note` (bool), `default_transaction_note` |
| `commerce_stock_level_simple_transaction` | Enter a signed transaction/adjustment | `step`, `custom_transaction_note` (bool), `default_transaction_note` |

## Formatter

`commerce_stock_level_simple` — renders the current available level read-only.

## Attach it (code)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_stock',
  'entity_type' => 'commerce_product_variation',
  'type' => 'commerce_stock_level',
])->save();

FieldConfig::create([
  'field_name' => 'field_stock',
  'entity_type' => 'commerce_product_variation',
  'bundle' => 'default',
  'label' => 'Stock',
])->save();

// choose a widget on the form display
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('commerce_product_variation.default.default');
$fd->setComponent('field_stock', [
  'type' => 'commerce_stock_level_simple_transaction',
  'settings' => ['step' => '1', 'custom_transaction_note' => TRUE],
])->save();

// (optional) show it read-only
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('commerce_product_variation.default.default');
$vd->setComponent('field_stock', ['type' => 'commerce_stock_level_simple'])->save();
```

Then set that variation type's stock service to `local_stock` (parent config) so the
widget-created transactions are stored and counted.

## Read back

```bash
drush cget field.field.commerce_product_variation.default.field_stock type   # commerce_stock_level
drush cget core.entity_form_display.commerce_product_variation.default.default content.field_stock.type
```
