<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the wishlist link & shared settings

## Show the link (pseudo/extra field)

`hook_entity_extra_field_info()` adds an **`add_to_wishlist_link`** display extra field to
every `commerce_product` bundle **and** every `commerce_product_variation` bundle, hidden by
default (weight 99). Enable it per view mode exactly like the cart link:

- UI: *Manage display* of the product/variation view mode → drag **Add to wishlist link** out
  of *Disabled* → Save.
- Config/PHP:

```php
$d = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('commerce_product_variation.default.default');
$d->setComponent('add_to_wishlist_link', ['weight' => 11, 'region' => 'content'])->save();
```

On the product it links the default variation; on a variation it links that variation. The
render is produced by `AddToWishlistLink::build()` from the module's `hook_ENTITY_TYPE_view()`.

## No settings of its own — it reuses the parent's config

This submodule has **no** admin form and **no** config object. Its links are governed by the
parent module's config:

- **CSRF token protection** — via the shared **`commerce_add_to_cart_link.token`** service,
  driven by `commerce_add_to_cart_link.settings:csrf_token.roles`. A user in any listed role
  gets a token appended to their wishlist links (validated by the wishlist controller's
  `access()`), identical to cart links.
- **`redirect_back`** — `AddToWishlistController::action()` reads
  `commerce_add_to_cart_link.settings:redirect_back`; when TRUE (and a valid internal referer
  exists) it returns there after adding, else it redirects to `commerce_wishlist.page`.

So to configure wishlist-link behaviour, edit the parent's settings at
*/admin/commerce/config/add-to-cart-link* (see the parent's
[configure/display-and-settings.md](../../../../2.1.x/agent/configure/display-and-settings.md)).

## Wishlist type

The target wishlist is the default type from `commerce_wishlist.settings:default_type`
(fallback `'default'`); the controller gets or creates that wishlist and adds the variation.

## Requirements

Needs `commerce_wishlist` enabled (route requires the `access wishlist` permission). If
`commerce_wishlist` is not installed, this submodule cannot be enabled.
