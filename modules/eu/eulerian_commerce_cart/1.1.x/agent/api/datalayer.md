<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cart datalayer

## Install & enable

```bash
drush en eulerian_commerce_cart -y
```

Requires `commerce_cart` and `eulerian_commerce_product` (which pulls in the base `eulerian`). The
base module must have a configured domain and the cart page must be tracked. No config, routes or
permissions.

## How it hooks in

`eulerian_commerce_cart.module` implements `hook_page_attachments_alter`, delegating to
`Hook\EulerianCommerceCartHooks::pageAttachmentsAlter()` (`#[Hook('page_attachments_alter')]`,
autowired). It returns early unless the base module already set
`$attachments['#attached']['drupalSettings']['eulerian']['datalayer']`, then merges the helper's
array with `+=`.

## Helper (`Services\CommerceCartHelper::supplyDatalayer()`)

Service `eulerian_commerce_cart.helper`, args `@current_route_match`, `@commerce_cart.cart_provider`.

- Returns `[]` unless the current route is **`commerce_cart.page`**.
- `supplyCartDatalayer()` builds:

```php
[
  'scart'      => 1,   // this is a cart event
  'scartcumul' => 0,   // 0 = products accumulation (vs 1 = entire cart)
  'products'   => [ ['ref' => …, 'amount' => …, 'quantity' => …], … ],
]
```

- It iterates `cartProvider->getCarts()` (the current session/user's carts) and each cart's order
  items. For every item whose purchased entity is a `PurchasableEntityInterface` and whose product
  is a `ProductInterface`, it appends:
  - `ref` = `$product->uuid()`
  - `amount` = `$productVariation->getPrice()->getNumber()` (variation unit price)
  - `quantity` = `$item->getQuantity()`

Items without a purchasable entity or product are skipped. The `products` list is later flattened by
the base module's `EA_prepare2Push()` into Eulerian `prdref`/`prdamount`/`prdquantity` triples.
