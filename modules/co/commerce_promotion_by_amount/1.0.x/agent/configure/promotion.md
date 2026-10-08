# Configure a promotion that uses these offers

There is **no module settings form**. You configure everything on a `commerce_promotion`
entity by selecting one of the two offers. Admin route: `entity.commerce_promotion.collection`
(*Commerce → Promotions*, `/promotion`). Requires the `commerce_promotion` module.

## Via the UI

1. Go to *Commerce → Promotions → Add promotion*.
2. Fill in name, store(s) and the usual promotion fields.
3. Under **Offer**, choose *"Fixed amount off for cheapest or most expensive matching product"*
   or *"Percentage off for cheapest or most expensive matching product"*.
4. Enter the amount / percentage, then set the three radios:
   - *cheapest / most expensive item* → `type`
   - *compare order item or product amount* → `compare`
   - *apply to all the products / only one product* → `scope`
5. (Optional) add Conditions so only certain products count as candidates.
6. Save.

## As a config/content entity (drush php:eval)

A promotion is a content entity; its offer lives in the `offer` field as a plugin item with
`target_plugin_id` + `target_plugin_configuration`:

```php
use Drupal\commerce_promotion\Entity\Promotion;
$promotion = Promotion::create([
  'name' => 'Cheapest item half price',
  'display_name' => 'Cheapest item 50% off',
  'order_types' => ['default'],
  'stores' => array_keys(\Drupal::entityTypeManager()->getStorage('commerce_store')->loadMultiple()),
  'status' => TRUE,
  'offer' => [
    'target_plugin_id' => 'order_item_percentage_off_by_amount',
    'target_plugin_configuration' => [
      'percentage' => '0.5',           // 0.5 = 50% (percentage offer)
      'type' => 'cheapest',            // or 'most_expensive'
      'compare' => 'product',          // or 'order_item'
      'scope' => 'product',            // 'product' = one unit; 'order_item' = all units
    ],
  ],
]);
$promotion->save();
```

For the fixed offer use `target_plugin_id => 'order_item_fixed_amount_off_by_amount'` and a
price amount instead of a percentage:

```php
'target_plugin_configuration' => [
  'amount' => ['number' => '5.00', 'currency_code' => 'USD'],
  'type' => 'most_expensive',
  'compare' => 'order_item',
  'scope' => 'order_item',
],
```

## Read it back

```bash
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_promotion")->loadMultiple() as $p) {
    $o = $p->get("offer")->first()->getValue();
    printf("%s => %s %s\n", $p->label(), $o["target_plugin_id"], json_encode($o["target_plugin_configuration"] ?? []));
  }
'
```

The `target_plugin_id` tells you which offer is in use; `target_plugin_configuration.type`
/ `compare` / `scope` are this module's settings.
