<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inventory sync, fulfillment flow, workflow mapping & events

## Cron: inventory + fulfillment sync (`hook_cron`)

`commerce_amazon_sp_api_cron()` loops enabled marketplaces. Per marketplace it keeps a
"next run" timestamp in the `commerce_amazon_sp_api` key-value store; when due it runs
`commerce_amazon_sp_api.inventory::sync()` then
`commerce_amazon_sp_api.fulfillment_order::syncFulfillments()`, then schedules the next run
`now + getInventorySyncPeriod()` (sync period is chosen on the integration form: 10/15/30/60 min).

### Inventory sync (`Amazon/Inventory`)

`sync(marketplace)` pages `ApiClient::getInventorySummaries()` (following `nextToken`, `sleep(1)`
between pages for rate limits; passes `startDateTime` when the marketplace has `incremental_sync`).
For each summary it `updateBySku()` — a `merge()` into the plain `commerce_amazon_inventory` table
(keyed by `sku` + `marketplace`, storing `fulfillableQuantity` + `timestamp`). If the marketplace
has `sync_items` on and no `commerce_amazon_item` exists yet for that SKU, `syncItem()` looks up a
Commerce product variation by SKU, dispatches `AMAZON_ITEM_SYNC` (payload-alterable), and creates
the Amazon Item only when a purchasable entity was matched. Read helpers `getBySku()` /
`getByItem()` return the stored quantity. All DB access is via the parameterized query builder;
SKUs come from Amazon's response, not request input.

## Order placement → Amazon fulfillment order

`EventSubscriber/OrderPlaceSubscriber` subscribes to `commerce_order.place.post_transition`
(priority −500, runs last). For each marketplace `loadAvailable($order)` where
`isEligible($order)` (country match + Commerce conditions), it calls
`FulfillmentOrder::createOrder()`. If the marketplace has `preview_fulfillment` on and the order has
shipments, it also fetches `getFulfillmentPreview()` and stores it on each shipment's data.

### `FulfillmentOrder::createOrder(order, marketplace)`

1. `validateOrderItemsEligibility()` — per order item dispatches
   `AMAZON_FULFILLMENT_ORDER_ITEM_VALIDATION`; a subscriber must mark items eligible/mapped/in
   stock. Any unvalidated item aborts (returns FALSE, logs `order_not_eligible` via Commerce Log).
2. Builds the `createFulfillmentOrder` payload: `sellerFulfillmentOrderId = AMA-DC-{order id}`,
   marketplace id, displayable order id/date/comment, shipping speed + policy (from the
   marketplace mapping), `destinationAddress` (from the order's shipping profile — name, address
   lines, city, region, postal, country, phone), `fulfillmentAction=Ship`, items, and
   `notificationEmails = [order email]`. Dispatches `AMAZON_FULFILLMENT_CREATE_ORDER` to let other
   modules alter the payload before sending.
3. Calls `ApiClient::createFulfillmentOrder()`. On API error, logs to Commerce Log and returns
   FALSE. On success, creates a `commerce_amazon_fulfillment` entity (state `new`), then
   `getFulfillmentOrder()` and applies the returned Amazon status as a state transition.

Missing shipping address ⇒ logs `order_not_eligible` and aborts.

### `syncFulfillments()` / `syncFulfillment()`

Cron loads open fulfillments (`loadOpenFulfillmentIds()`, chunked by 10), and for each calls
`ApiClient::getFulfillmentOrder()`, stores returned `fulfillmentShipments`, and — when Amazon's
status differs from the local state — logs a `fulfillment_order_transition` Commerce Log entry and
applies the matching state-machine transition.

## Fulfillment state → Commerce order transition

`EventSubscriber/FulfillmentWorkflowSubscriber` subscribes to
`commerce_amazon_fulfillment.post_transition`. If the marketplace's integration mapping enables
`workflow` for the order's bundle, it looks up the configured Commerce order transition for that
fulfillment transition and, if allowed, applies it to the order and saves. This is what "automates
Commerce order workflow based on Amazon fulfillment status".

## Integration / settings forms

- `Form/AmazonMarketplaceIntegrationForm` (`.../marketplace/{id}/integration`) — per order type:
  enable automatic workflow integration and map each `fulfillment_default` transition to a Commerce
  order transition; plus fulfillment policy (`FillOrKill`/`FillAll`/`FillAllAvailable`/custom),
  shipping speed (`Standard`/`Expedited`/`Priority`/custom), low-inventory threshold, and inventory
  `sync_period`. Persisted into the marketplace `mapping` map field.
- `Form/AmazonAppSettingsForm`, `AmazonItemSettingsForm`, `AmazonMarketplaceSettingsForm`,
  `AmazonFulfillmentSettingsForm` — the `field_ui_base_route` settings pages (mostly Field-UI
  anchors; the App settings form is a placeholder).

## Events (`Event/AmazonEvents`)

`AMAZON_ITEM_SYNC`, `AMAZON_FULFILLMENT_CREATE_ORDER`, `AMAZON_FULFILLMENT_PREVIEW_ORDER`,
`AMAZON_FULFILLMENT_ORDER_ITEM_VALIDATION`, `AMAZON_PUT_LISTINGS` — each carries the relevant
entity + a mutable payload so other modules can alter outbound data or supply item-validation
logic (order-item validation must be implemented by a subscriber for `createOrder` to proceed).
