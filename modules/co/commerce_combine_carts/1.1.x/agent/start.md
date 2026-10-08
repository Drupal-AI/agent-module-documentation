<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Combine Carts — agent index

Automatically keeps a Commerce customer to **one cart per order type** by merging extra carts on
**login** and on **order assignment**. No configuration, no UI, no permissions, no Drush, no plugins —
it is purely the `commerce_combine_carts.cart_unifier` service plus two triggers. Requires
`commerce_cart`.

- **The `CartUnifier` service, its methods, the two triggers, and merge rules** →
  [api/cart-unifier.md](api/cart-unifier.md)

Key facts: triggers are `hook_user_login()` → `CartUnifier::combineUserCarts($user)` and an event
subscriber on `OrderEvents::ORDER_ASSIGN` → `CartUnifier::assignCart()`. Merging is **per order type**
(bundle); items are moved in a DB transaction and like items stack per the product's `variations`
display `combine` setting. The cart currently at `commerce_checkout.form` is kept as the surviving
destination. There is nothing to configure — behaviour is automatic once enabled.
