<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wishlist route, controller & link helper

## Route

```
commerce_add_to_wishlist_link.page
  path: /add-to-wishlist/{commerce_product}/{commerce_product_variation}/{token}
  controller: AddToWishlistController::action   (token defaults to '')
  _permission: 'access wishlist'
  _custom_access: AddToWishlistController::access
  {commerce_product}, {commerce_product_variation}: \d+ (entity-upcast)
```

## `AddToWishlistLink` (extends the parent `AddToCartLink`)

`Drupal\commerce_add_to_wishlist_link\AddToWishlistLink extends AddToCartLink`. It overrides
only two methods:

- `build()` — `#theme => 'commerce_add_to_wishlist_link'`, `#url`, `#product_variation`.
- `url()` — `Url::fromRoute('commerce_add_to_wishlist_link.page', [...])` with the token from
  the shared token service.

Everything else (`metadata()`, `fromVariationId()`, the shared token) is inherited:

```php
use Drupal\commerce_add_to_wishlist_link\AddToWishlistLink;
$url = (new AddToWishlistLink($variation, \Drupal::service('commerce_add_to_cart_link.token')))->url();
$url = AddToWishlistLink::fromVariationId($id)->url(); // inherited convenience ctor
```

## Controller (`AddToWishlistController`)

Injects `@commerce_add_to_cart_link.token`, `@commerce_wishlist.wishlist_manager`,
`@commerce_wishlist.wishlist_provider`, `@path.validator`.

`access()` — identical logic to the cart controller: denies unless product **and** variation
are published & view-accessible, the variation's product id matches, and the shared token
validates.

`action()` — resolves the wishlist type from `commerce_wishlist.settings:default_type`
(fallback `'default'`), gets or creates that wishlist, calls
`wishlistManager->addEntity($wishlist, $variation, $quantity)` (`quantity` query param,
default 1), then redirects to the referer (when `commerce_add_to_cart_link.settings:redirect_back`
is on and the referer is valid, not the login route) or to `commerce_wishlist.page`.

There is **no** AJAX branch and **no** Views field in this submodule (the parent has both).

## Hooks & theming

Implements `hook_entity_extra_field_info` (`add_to_wishlist_link` pseudo field), `hook_theme`
(`commerce_add_to_wishlist_link` with `url` + `product_variation`),
`hook_theme_suggestions_commerce_add_to_wishlist_link`
(`__{bundle}`, `__{id}`), and `hook_ENTITY_TYPE_view` for `commerce_product` and
`commerce_product_variation`. Override
`templates/commerce-add-to-wishlist-link.html.twig` in your theme (add `use-ajax` yourself if
wanted — the controller does not return an AjaxResponse).
