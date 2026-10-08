<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Add To Cart Link replaces Drupal Commerce's add-to-cart **form** with a plain **link** (a GET request to `/add-to-cart/{product}/{variation}/{token}`) that adds a product variation to the cart, ideal for product listings, blocks and AJAX views where a form would break.

---

The module exposes an `add_to_cart_link` **pseudo (extra) field** on every Commerce product and product variation view display via `hook_entity_extra_field_info()` — hidden by default, you enable it per view mode on *Manage display*. On the product it links the default variation; on a variation it links that variation. The link is rendered through the themeable `commerce_add_to_cart_link` Twig template (with `__BUNDLE` / `__ID` suggestions) so themers control markup and text. Clicking it hits the `commerce_add_to_cart_link.page` route; `AddToCartController::action()` creates an order item, resolves the price/order-type/store, adds it to the cart and redirects to the cart page (or back to the referer when `redirect_back` is on, or returns an `AjaxResponse` updating the cart count when the link carries `use-ajax`). Links can be hardened with a per-user **CSRF token**: the `commerce_add_to_cart_link.token` service HMACs the product/variation ids with the site private key + hash salt for users in the roles selected under *Configuration → Commerce → Commerce Add To Cart Link* (`csrf_token.roles`); the controller's `access()` callback validates it and also checks publish status and that the variation belongs to the product. A Views field plugin (`commerce_add_to_cart_link`) offers the same link inside views, with per-field options for quantity, cart combining and an optional destination. This solves two core limitations: add-to-cart forms silently fail when the rendered product changes between page load and submit, and AJAX-enabled views "steal" embedded forms. The bundled **Commerce add to wishlist link** submodule mirrors all of this for Commerce Wishlist.

---

- Add an "Add to cart" link to a product teaser/catalog view mode instead of the full form.
- Put add-to-cart buttons in a "Related products" or "Bestsellers" block that changes per request.
- Enable add-to-cart inside an AJAX-paginated View without the forms breaking after the first click.
- Show a link for the default variation on the product entity display (simple products).
- Show per-variation add-to-cart links on the variation display (products with many variations).
- Add an "Add to cart" Views field to a product listing view, controlling quantity per row.
- Create separate cart line items (uncheck "Combine") when the same product is added twice.
- Add a fixed quantity (e.g. add 6 at once) via the Views field's quantity option.
- Protect cart links against bots/CSRF for authenticated users by enabling token protection per role.
- Leave anonymous users unprotected (no token) for cacheable, guessable-safe catalog links.
- Redirect the shopper back to the listing they came from after adding, instead of the cart page.
- Turn cart links into AJAX by adding `use-ajax` in the Twig template, updating the cart count live.
- Handle a custom `addToCartLink.updated` JS event to show a toast or update a custom cart widget.
- Customize link text/markup per variation type or variation id via template suggestions.
- Build "buy now" style one-click links from anywhere using `AddToCartLink::fromVariationId($id)->url()`.
- Generate the add-to-cart URL programmatically in a custom block or controller.
- Keep product detail pages on the normal add-to-cart form while using links only on listings.
- Support multi-store setups (the controller resolves the correct store for the variation).
- Deny adding unpublished products or variations, or mismatched product/variation pairs, via access checks.
- Offer the same link-based flow for wishlists using the add-to-wishlist submodule.
- Reduce "nothing happened" cart failures caused by Drupal Form API on disappearing forms.
- Expose add-to-cart on cached pages where rendering a fresh form token is undesirable.
- Provide accessible catalog buy buttons by rewriting the Views field link title to the product title.
