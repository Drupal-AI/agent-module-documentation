<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoint: `/direct-checkout-by-url`

Route `direct_checkout_by_url.redirect` → `CheckoutByUrlController::build()`.
Requirement: `_permission: 'use direct checkout'`. Method: GET (a plain link).

## `products` parameter — two shapes

**String (comma-separated SKUs), quantity 1 each:**

```
/direct-checkout-by-url?products=SKU1,SKU2
```

Internally each SKU becomes `['sku' => SKU, 'quantity' => 1]` and is handled by the
array path below.

**Array (per-item quantity):**

```
/direct-checkout-by-url?products[0][sku]=SKU1&products[0][quantity]=2&products[1][sku]=SKU2&products[1][quantity]=1
```

Each entry must contain both `sku` and `quantity`; entries missing either key are
skipped (`continue`).

## Behaviour per entry

1. `variationStorage->loadBySku($sku)` loads the `commerce_product_variation`.
   - Not found + `allow_unknown_skus` off → `NotFoundHttpException` (404).
   - Not found + `allow_unknown_skus` on → entry skipped.
2. `selectStore($variation)` — single store used directly; multiple stores use the
   current store if the variation is sold there, else throws.
3. Availability check via the availability manager. If unavailable, the entry is skipped.
4. Cart resolved: `cartProvider->getCart('default', $store, $currentUser)` or a new cart.
5. If `reset_cart` is on, `cartManager->emptyCart($cart)` first.
6. `cartManager->addEntity($cart, $variation, $quantity)` — quantity comes from the URL;
   **price is resolved server-side from the variation**.

## Responses

- Missing `products` → 404 (`NotFoundHttpException`).
- `products` neither string nor array → 400 (`BadRequestHttpException`).
- Nothing added (all entries skipped) → redirect to `commerce_cart.page` (the cart).
- At least one item added → redirect to `commerce_checkout.form` for the cart order.

## Redirect override with `destination`

The controller returns a normal internal `RedirectResponse`, so Drupal core's
`destination` query parameter takes precedence over the checkout target:

```
/direct-checkout-by-url?products=SKU1&destination=cart      # ends on /cart
```

Core sanitises `destination` to same-origin internal paths, so it is not an
open-redirect to external hosts.

## Views "add to cart" button (from README)

Using a Views global custom-text field:

```html
<a href="/direct-checkout-by-url?products={{ sku }}" class="btn btn-default">Add to cart</a>
```
