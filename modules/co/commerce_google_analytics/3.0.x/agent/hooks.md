<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Google Analytics — alter hooks

All three are declared in `commerce_google_analytics.api.php` and invoked from
`SendOrderAnalyticsSubscriber::buildGaPushParams()` via the module handler's `alter()`. They let
you reshape the GA e-commerce payload before it is passed to `ga_push_add_ecommerce()`. The order
is provided for reference only — hooks must not mutate it.

## `hook_commerce_google_analytics_transaction_alter(array &$transaction, array $context)`

Alter the transaction array (`order_id`, `affiliation`, `total`, `currency`, `total_tax`,
`total_shipping`, `city`, `region`, `country`). `$context['order']` is the `OrderInterface`.

```php
function mymodule_commerce_google_analytics_transaction_alter(array &$transaction, array $context) {
  $transaction['affiliation'] = 'Custom store or affiliation';
  /** @var \Drupal\commerce_order\Entity\OrderInterface $order */
  $order = $context['order'];
  $transaction['order_id'] = $order->getOrderNumber();
}
```

## `hook_commerce_google_analytics_item_alter(array &$item, OrderItemInterface $order_item, array $context)`

Alter a single item entry. `$context` keys: `transaction`, `order`. **Emptying `$item`
(`$item = []`) removes that item** from the final payload (the subscriber skips empty items).

```php
function mymodule_commerce_google_analytics_item_alter(array &$item, OrderItemInterface $order_item, array $context) {
  $item['name'] = $order_item->getTitle();
  $item['order_id'] = $context['order']->getOrderNumber();
}
```

## `hook_commerce_google_analytics_items_alter(array &$items, array $context)`

Alter the final items array after every per-item hook has run. `$context` keys: `transaction`,
`order`. Use it to rebuild or filter the whole set.

```php
function mymodule_commerce_google_analytics_items_alter(array &$items, array $context) {
  /** @var \Drupal\commerce_order\Entity\OrderInterface $order */
  $order = $context['order'];
  // e.g. rebuild $items from $order->getItems() ...
}
```
