<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emporiqa — alter hooks

Documented in `emporiqa.api.php`. All are `\Drupal::moduleHandler()->alter()` invocations from the
services noted; implement in your `MODULE.module` (or an OOP `#[Hook]` class).

- `hook_emporiqa_entity_sync_alter(bool &$sync, EntityInterface $entity, string $entity_type, string $operation)`
  — veto syncing an entity. `$entity_type` is `product`/`variation`/`page`; `$operation` is
  `create`/`update`/`delete`. Invoked from `EmporiqaHooks::shouldSyncEntity()`.
- `hook_emporiqa_data_alter(array &$data, array $context)` — reshape the full product/variation/page
  payload before queueing/sending; set `$data = []` to skip. `$context`: `entity`, `entity_type`,
  `identification_number`. From `SyncProcessor` and `WebhookQueueWorker`.
- `hook_emporiqa_availability_alter(array &$data, array $context)` — reshape the lightweight
  `product.availability` payload (`identification_number`, `sku`, `availability_statuses`,
  `stock_quantities`); `$data = []` to skip. From `WebhookQueueWorker::formatAvailabilityEvents()`.
- `hook_emporiqa_channels_alter(array &$channels, ProductInterface $product)` — assign sales channels
  (default `['']` store-wide). From `DataFormatter::getChannels()`.
- `hook_emporiqa_price_entry_alter(array &$entry, array $context)` — populate tax-inclusive/exclusive
  prices etc. `$context`: `variation`, `store`, `price`. From `DataFormatter::buildPriceEntry()`.
- `hook_emporiqa_tier_prices_alter(array &$tier_prices, array $context)` — supply volume/tier pricing
  (`min_quantity`, `price`, `currency`). `$context`: `variation`, `currency`.
- `hook_emporiqa_min_order_quantity_alter(int &$min, array $context)` /
  `hook_emporiqa_max_order_quantity_alter(?int &$max, array $context)` — override per-variation
  order-quantity limits (`$context`: `variation`, `field_name`). From `DataFormatter::getMin/MaxOrderQuantity()`.
- `hook_emporiqa_available_for_order_alter(bool &$available, array $context)` — mark catalog-only
  (non-orderable) products. `$context`: `product`, optional `variation`. From `DataFormatter::formatProduct/formatVariation()`.
- `hook_emporiqa_checkout_route_alter(string &$route_name)` — override checkout route (default
  `commerce_checkout.form`). From `CartController::buildCheckoutUrl()`.
- `hook_emporiqa_order_tracking_alter(?array &$response, string $order_identifier, array $body)` —
  provide custom order-tracking data (e.g. from an ERP); a non-NULL `$response` bypasses the default
  Commerce lookup. Custom implementations must do their own verification. From `OrderTrackingController::track()`.
- `hook_emporiqa_cart_alter(array &$context)` — cancel/modify a cart operation. `$context`:
  `operation` (`add`/`update`/`remove`/`clear`/`view`/`checkout`), `items`, `cancel`, `cancel_message`.
  From `CartController`.
