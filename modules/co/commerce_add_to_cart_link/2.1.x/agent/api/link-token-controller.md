<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route, controller, link helper & token service

## Route

```
commerce_add_to_cart_link.page
  path: /add-to-cart/{commerce_product}/{commerce_product_variation}/{token}
  controller: AddToCartController::action   (token defaults to '')
  _custom_access: AddToCartController::access
  {commerce_product}, {commerce_product_variation}: \d+ (entity-upcast)
```

Query params honoured by `action()`: `quantity` (default 1), `combine` (default 1).

## `AddToCartLink` helper (`Drupal\commerce_add_to_cart_link\AddToCartLink`)

Builds the render array / URL for a variation. Not a service — instantiate it.

```php
use Drupal\commerce_add_to_cart_link\AddToCartLink;
$link = new AddToCartLink($variation, \Drupal::service('commerce_add_to_cart_link.token'));
$url  = $link->url();      // Url to commerce_add_to_cart_link.page incl. token
$build = $link->build();   // #theme commerce_add_to_cart_link render array
// Convenience by id (loads the variation, throws if missing):
$url = AddToCartLink::fromVariationId($id)->url();
```

`build()` sets `#theme => 'commerce_add_to_cart_link'`, `#url`, `#product_variation`, and
applies cache metadata (context `user.roles`, tag `config:commerce_add_to_cart_link.settings`).
Passing no token service to the constructor is **deprecated** (2.1.0) and will be required in
2.2.0 — always pass `@commerce_add_to_cart_link.token`.

## Token service (`commerce_add_to_cart_link.token`)

Service class `CartLinkToken implements CartLinkTokenInterface`
(args `@current_user`, `@config.factory`, `@private_key`):

- `generate($variation): string` — returns `''` when the current user needs no protection;
  otherwise a 16-char `Crypt::hmacBase64("cart_link:{productId}:{variationId}", privateKey . hashSalt)`.
- `validate($variation, $token): bool` — TRUE if unprotected, else `hash_equals(generate(), $token)`.
- `needsCsrfProtection(?$account): bool` — TRUE when the account shares a role with
  `commerce_add_to_cart_link.settings:csrf_token.roles`.

Tokens are **not** session-bound (they depend only on private key + salt + ids + role), so
protected links are per-role stable but unguessable.

## Controller (`AddToCartController`)

`access()` denies unless: product **and** variation are published and view-accessible, the
variation's `getProductId()` equals the product id, **and** the token validates.

`action()`: creates an order item (`cart_manager->createOrderItem`), selects the store
(`selectStore()` — single store, or current store if the variation sells from several),
resolves price via `commerce_price.chain_price_resolver`, resolves the order type, gets/creates
the cart, `addOrderItem($cart, $item, $combine)`. Then:

- **AJAX** (`use-ajax` link → XHR): returns an `AjaxResponse` that `ReplaceCommand`s
  `span.cart-block--summary__count` with the new count and `InvokeCommand`s a jQuery
  `trigger('addToCartLink.updated', [{cart_total_count, product_title, quantity_added,
  product_variation_id, product_id}])` on `html`.
- **Non-AJAX**: if `redirect_back` and a valid internal referer (not `user.login`) →
  redirect there; else redirect to `commerce_cart.page`.

## Hooks the module implements

`hook_entity_extra_field_info` (the `add_to_cart_link` pseudo field), `hook_theme`,
`hook_theme_suggestions_commerce_add_to_cart_link`, `hook_ENTITY_TYPE_view` for
`commerce_product` and `commerce_product_variation`, `hook_views_data`.
