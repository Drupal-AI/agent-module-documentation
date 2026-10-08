<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending & integrating

## OrderAmendEvent

`Event\OrderAmendEvent` (extends `Drupal\Component\EventDispatcher\Event`) is dispatched once per
amendment, after the order has been refreshed and saved. Event name:

```php
OrderAmendEvent::EVENT_NAME  // 'commerce_order_amend.order_amended'
```

Readonly public properties (constructor-promoted):

| property | type | populated for |
|---|---|---|
| `type` | `OrderAmendType` | always |
| `order` | `OrderInterface` | always |
| `orderItem` | `?OrderItemInterface` | swap, add (NULL for remove & coupon ops) |
| `oldVariation` | `?ProductVariationInterface` | swap, remove |
| `newVariation` | `?ProductVariationInterface` | swap, add |
| `quantity` | `float` (default 0) | swap, add, remove |
| `reason` | `string` (default '') | swap, add, remove |
| `couponCode` | `string` (default '') | add_coupon, remove_coupon |

Subscribe with a normal `EventSubscriberInterface`:

```php
public static function getSubscribedEvents(): array {
  return [OrderAmendEvent::EVENT_NAME => 'onOrderAmend'];
}

public function onOrderAmend(OrderAmendEvent $event): void {
  if ($event->type === OrderAmendType::SwapItem) {
    // e.g. return $event->oldVariation to stock, deduct $event->newVariation.
  }
}
```

Typical uses: stock adjustment, made-to-order/production sync, customer notifications, external
ERP/inventory updates, refund/capture requests. Note the order is already saved when the event fires.

## OrderAmendType enum

`Enum\OrderAmendType : string` — backed enum with five cases:
`SwapItem='swap_item'`, `AddItem='add_item'`, `RemoveItem='remove_item'`, `AddCoupon='add_coupon'`,
`RemoveCoupon='remove_coupon'`. These string values are also what gets stored in `amendment_types`.

## `amendment_types` base field

`commerce_order_amend.module`'s `hook_entity_base_field_info` adds a base field to `commerce_order`:
string, `CARDINALITY_UNLIMITED`, `max_length` 32, `setDisplayConfigurable('view', TRUE)`.
`OrderAmendManager::trackAmendmentType()` appends each op's `OrderAmendType->value` once (deduped)
and saves the order (without a refresh). Stored values are the enum strings above. Use it for Views
filters, e.g. "orders where `amendment_types` contains `swap_item`", or "not empty" for all amended
orders.

## Commerce Log templates

`commerce_order_amend.commerce_log_templates.yml` defines five templates (category
`commerce_order`), each rendered by `OrderAmendManager::log()` which injects `user` (the acting
account's display name):

- `order_amend_item_swapped` — `old_item`, `old_sku`, `new_item`, `new_sku`, `reason`, `balance_change`
- `order_amend_item_added` — `item`, `sku`, `quantity`, `reason`, `balance_change`
- `order_amend_item_removed` — same params as added
- `order_amend_coupon_added` — `coupon_code`, `balance_change`
- `order_amend_coupon_removed` — same as added

All render text prefixed **"Order Amended - …"**. To build an audit View, create a View of Commerce
Log entities, relate to the source order, and filter Template containing `order_amend_`.

## Optional integration: Commerce Stock

`AmendOrderForm::create()` injects `commerce_stock.service_manager` only if the container has it
(`$container->has(...)`), so the module works without Commerce Stock. When present and
`validate_stock` config is on, swap/add validate available stock (see
[operations.md](operations.md#validation-validateform--per-op)).
