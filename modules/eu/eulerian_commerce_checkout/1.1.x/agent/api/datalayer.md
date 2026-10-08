<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout-complete (conversion) datalayer

## Install & enable

```bash
drush en eulerian_commerce_checkout -y
```

Requires `commerce_checkout` and the base `eulerian` module (with a configured domain, and the
checkout page tracked). No config, routes or permissions.

## How it hooks in

`eulerian_commerce_checkout.module` implements `hook_page_attachments_alter`, delegating to
`Hook\EulerianCommerceCheckoutHooks::pageAttachmentsAlter()` (`#[Hook('page_attachments_alter')]`,
autowired). It returns early unless the base module already set
`$attachments['#attached']['drupalSettings']['eulerian']['datalayer']`, then merges the helper's
array with `+=`.

## Helper (`Services\CommerceCheckoutHelper::supplyDatalayer()`)

Service `eulerian_commerce_checkout.helper`, args `@current_route_match`,
`@commerce_checkout.checkout_order_manager`.

- Reads the routed `commerce_order` parameter. If it is an `OrderInterface`, it takes the `step`
  route parameter and resolves the effective step via
  `CheckoutOrderManager::getCheckoutStepId($order, $requested_step_id)`.
- Fires **only** when `$requested_step_id === $step_id && $requested_step_id === 'complete'` — i.e.
  the actual checkout-complete page, not an arbitrary step guess. Otherwise returns `[]`.
- `supplyCheckoutCompletedDatalayer($order)` builds:

```php
[
  'ref'      => $order->uuid(),
  'amount'   => $order->getTotalPrice()->getNumber(),
  'currency' => $order->getTotalPrice()->getCurrencyCode(),
  'products' => [ ['ref' => productUuid, 'amount' => variationPrice, 'quantity' => qty], … ],
]
```

- Products come from `$order->getItems()`; items without a `PurchasableEntityInterface` purchased
  entity or a `ProductInterface` product are skipped.

The `products` list is flattened client-side by the base module's `EA_prepare2Push()` into Eulerian
`prdref`/`prdamount`/`prdquantity` triples, and the whole datalayer is pushed on the confirmation
page as the transaction/conversion event. Access to the order is enforced by the Commerce checkout
route itself; this submodule only reads the already-authorised order.
