<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Repeat Order gives a Drupal Commerce customer a one-click way to turn one of their own past orders back into a cart, by hitting the route `/commerce-repeat-order/{commerce_order}`.

---

The module is a single controller behind one route. You place a link or button that points at `/commerce-repeat-order/{commerce_order}` (for example on the order detail page, the user's order-history view, or a receipt email), passing the order id dynamically. When the current user follows it, `CommerceRepeatOrder::repeatOrder()` loads that order, checks that the order's customer id matches the current user's id (a customer may only repeat their **own** order — attempting someone else's produces the error "You can only repeat your own order."), and then rebuilds the cart. It fetches (or creates) the user's `default` cart for the order's store; depending on the site-wide **Add / Override** setting it either adds to the existing cart or empties it first, then walks the order's items. For each item whose purchased product is still **published**, it duplicates the order item and adds it to the cart via Commerce's `CartManager::addOrderItem()`; items whose product is unavailable are skipped, and (if the **status message** setting is *Show*) the customer is told that "Some products weren't copied to the cart as they aren't currently available." A per-item `OrderCloneEvent` (`commerce_repeat_order.order_cloned`) is dispatched so other modules can react to the clone. Finally the user is redirected to the cart page (`commerce_cart.page`). Configuration lives in a small settings form at `/admin/commerce/config/order/repeat-order` (permission `commerce repeat order admin access`) exposing two radios — *Add Product* vs *Override*, and *Show* vs *Hide* the skipped-item message — stored in the `commerce_repeat_order.settings` config object. Access to the reorder route itself is gated by the Commerce `view own commerce_order` permission. The module ships no entities, plugins, fields, widgets, Drush commands, config schema, or install-time default configuration; it depends on Commerce and Commerce Cart.

---

- Add a "Repeat this order" button to the order detail page so customers can re-buy in one click.
- Put a "Reorder" link on each row of a customer's order-history view.
- Drive repeat purchases of consumables (coffee, supplements, pet food) without a full subscription module.
- Let a B2B buyer rebuild a large recurring purchase order from last month's order.
- Offer a "Buy it again" call-to-action in a post-purchase or receipt email that deep-links to the reorder route.
- Configure the reorder to **replace** the current cart (Override) so the customer starts fresh from the old order.
- Configure the reorder to **add** the old order's items on top of whatever is already in the cart.
- Let customers restock a favorite basket of items they order repeatedly.
- Speed up checkout for returning customers by pre-filling the cart from a known-good previous order.
- Give support staff a documented URL pattern to hand a customer for re-ordering.
- Show or hide the "some products weren't copied" notice depending on how chatty you want the storefront.
- Silently drop discontinued/unpublished products from a rebuilt cart so the customer only gets what is still buyable.
- Restrict who can use reorder by granting the `view own commerce_order` permission only to specific roles.
- Restrict who can change the add-vs-override behavior via the `commerce repeat order admin access` permission.
- React to each reordered item in a custom module by subscribing to the `commerce_repeat_order.order_cloned` event (e.g. logging, analytics, loyalty points).
- Build a themed reorder link in a Twig template or preprocess using the order id.
- Support multi-store setups — the rebuilt cart is scoped to the order's own store.
- Encourage conversion of one-time buyers into repeat customers with minimal friction.
- Combine with a Views field/link to expose reorder across an entire order list without custom code.
- Provide a low-code alternative to building a bespoke reorder controller for a Commerce site.
