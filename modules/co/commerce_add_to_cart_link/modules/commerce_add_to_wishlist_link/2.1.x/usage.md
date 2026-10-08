<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce add to wishlist link is the wishlist counterpart of Commerce Add To Cart Link: it renders an add-to-**wishlist** link (GET `/add-to-wishlist/{product}/{variation}/{token}`) instead of a form, for use in product listings, blocks and AJAX views. It requires both `commerce_add_to_cart_link` and `commerce_wishlist`.

---

The submodule mirrors its parent almost exactly. `hook_entity_extra_field_info()` adds an `add_to_wishlist_link` **pseudo (extra) field** to every Commerce product and product variation view display (hidden by default); enable it per view mode on *Manage display*. Its `AddToWishlistLink` class **extends** the parent's `AddToCartLink` (overriding only `build()` and `url()` to target the wishlist theme hook and route), and it reuses the parent's shared **`commerce_add_to_cart_link.token`** service — so wishlist links get the same per-role CSRF token protection driven by `commerce_add_to_cart_link.settings:csrf_token.roles`, and the same `redirect_back` behaviour read from that same config object. Clicking a link hits `commerce_add_to_wishlist_link.page` (`AddToWishlistController::action()`), which requires the `access wishlist` permission, validates the token and publish/ownership just like the cart controller, resolves the default wishlist type (`commerce_wishlist.settings:default_type`, fallback `default`), gets/creates the wishlist, `addEntity()`s the variation, then redirects to the wishlist page (or the referer when `redirect_back` is on). The link is themeable via the `commerce_add_to_wishlist_link` Twig template with `__BUNDLE` / `__ID` suggestions. It defines no settings form or config of its own — all configuration is the parent's settings plus Manage display. Note: this submodule has no admin settings page and, unlike the parent, does **not** ship a Views field plugin.

---

- Add an "Add to wishlist" link to a product catalog/teaser view mode instead of a form.
- Put wishlist buttons in a "Recommended products" block that changes per request.
- Enable add-to-wishlist inside an AJAX-paginated View without the forms breaking.
- Show a wishlist link for the default variation on the product display (simple products).
- Show per-variation wishlist links on the variation display (multi-variation products).
- Let shoppers save items for later directly from listing pages with one click.
- Protect wishlist links for logged-in users with the shared CSRF token (per role).
- Leave anonymous wishlist links unprotected for cache-friendly listings.
- Redirect the shopper back to the listing after adding, instead of the wishlist page.
- Reuse the parent's `commerce_add_to_cart_link.settings` config for wishlist protection/redirect.
- Build "save for later" links programmatically via `AddToWishlistLink::fromVariationId($id)->url()`.
- Add wishlist links to the same view modes you use for add-to-cart links.
- Customize wishlist link text/markup per variation type or id via template suggestions.
- Gate wishlist adds behind the `access wishlist` permission (route requirement).
- Add items to the site's default wishlist type without a full wishlist form.
- Provide a cart link and a wishlist link side by side on a product teaser.
- Offer wishlist adds on cached pages where a fresh form token is undesirable.
- Deny wishlist adds for unpublished products/variations or mismatched product/variation pairs.
- Support multi-store catalogs where wishlist links must respect product/variation access.
- Keep the wishlist "add" out of the full product page while using it only on listings.
