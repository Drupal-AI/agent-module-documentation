<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Combine Carts ensures a Drupal Commerce customer only ever has a single active cart per order type, automatically merging any extra carts (for example an anonymous cart and an existing account cart) into one when the user logs in or when a cart is assigned to them.

---

The module has **no configuration, UI, permissions, Drush, or plugins** — it works automatically through the `commerce_combine_carts.cart_unifier` service (`CartUnifier`). It reacts to two triggers: `hook_user_login()` calls `CartUnifier::combineUserCarts()` to consolidate all of a logging-in user's carts, and an event subscriber on Commerce's `OrderEvents::ORDER_ASSIGN` calls `CartUnifier::assignCart()` whenever a cart order is assigned to a customer (e.g. the classic "anonymous session cart adopted at login"). Merging is done per **order type**: `getMainCarts()` returns one "main" cart per bundle, and each other same-type cart's order items are moved into the main cart inside a database transaction (`combineCarts()`), then the emptied cart is either deleted (login flow) or saved empty (assign flow). When moving items it respects the product's `variations` view-display `combine` setting via `shouldCombineItem()`, so like items stack correctly instead of duplicating. It also has special handling for a cart that is currently requested for checkout (route `commerce_checkout.form`): that cart is treated as the destination so the customer keeps checking out the cart they are on. Requires `commerce_cart` (Drupal Commerce 2.x).

---

- Merge a shopper's anonymous cart into their account cart automatically when they log in.
- Guarantee each customer has only one active cart per order type at any time.
- Prevent "lost" items where a user adds to a cart while logged out and can't find them after login.
- Consolidate duplicate carts created across devices or sessions into a single cart.
- Adopt an anonymous session cart into the user's cart when it is assigned to them.
- Keep the cart a customer is actively checking out as the surviving cart during a merge.
- Combine like order items (respecting the product variation `combine` setting) instead of duplicating rows.
- Avoid confusing multi-cart states in stores that don't want more than one open cart.
- Reduce abandoned-cart noise by folding stray carts into the main cart.
- Improve conversion by making sure everything a user added ends up in one checkout.
- Support stores with multiple order types by merging per type (one main cart each).
- Clean up empty leftover carts after a merge (deleted on login, saved empty on assign).
- Provide the behaviour with zero configuration — just enable the module.
- Handle the "added to cart as guest, then registered/logged in" flow gracefully.
- Prevent a customer from accidentally checking out only part of their items across two carts.
- Programmatically combine a user's carts from custom code via `CartUnifier::combineUserCarts($user)`.
- Move items between two specific carts in a transaction via `CartUnifier::combineCarts()`.
- Keep cart merging atomic and safe with a database transaction and rollback on error.
- Integrate cart unification with custom login or order-assignment flows.
- Ensure marketing/quote carts of different order types are not accidentally merged together.
- Simplify support: agents only ever see one cart per customer.
- Retrofit single-cart behaviour onto an existing Commerce store without content changes.
