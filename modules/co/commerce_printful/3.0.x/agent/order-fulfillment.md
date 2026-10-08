<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Order fulfillment (push to Printful)

Paid Commerce orders are pushed to Printful automatically.

## Trigger

`src/EventSubscriber/OrderEventSubscriber.php` subscribes to `commerce_order.order.paid` →
`OrderIntegrator::createPrintfulOrder($order)`. (Payment itself is handled by a separate Commerce
payment gateway; this module only forwards the fulfillment request after the order is paid.)

## Mapping (`src/Service/OrderIntegrator.php` + `src/OrderItemsTrait.php`)

`createPrintfulOrder()` iterates the order's **shipments**. For each shipment whose shipping method
plugin id is `printful_shipping`:
1. `OrderItemsTrait::getRequestData($shipment, TRUE)` builds the request:
   - `recipient` — from the shipment's shipping-profile `address` (address1/2, city, country_code,
     state_code, zip; plus name/company when creating).
   - `items` — for each shipment item whose purchased entity has a `printful_reference->printful_id`:
     `external_variant_id`, `quantity`, and (for creation) `name`, `retail_price`, `sku`. Prices are
     converted to the Printful store currency via `commerce_currency_resolver` when they differ.
   - `_printful_store` — resolves which `printful_store` matches the product bundle and sets its api
     key (this is how multi-store api keys are selected).
2. Request assembled: `update_existing => TRUE`, `confirm => !draftOrders`, `body.shipping =
   $shipment->getShippingService()`, `body.external_id = $shipment->id()`.
3. `Printful::createOrder($request)` → POST `orders`. Success/error logged to the
   `commerce_printful` logger channel (Printful order id on success).

## Draft vs. confirmed

`printful_store.draftOrders` — when set, orders are created as Printful **drafts** (`confirm =
FALSE`) for manual review/approval; otherwise confirmed for automatic fulfillment. Toggled per store
on the store form ("Export orders as drafts"); `syncOrders` ("Enable order synchronization") gates
whether paid orders are sent at all.

## Note

Printful `external_id` is the **shipment** id, not the order id — an order with multiple shipments
produces multiple Printful orders. Only `printful_shipping` shipments are pushed.
