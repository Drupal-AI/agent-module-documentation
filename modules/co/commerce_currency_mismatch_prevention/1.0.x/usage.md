<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Currency Mismatch Prevention stops carts from mixing incompatible currencies.

---

Commerce Currency Mismatch Prevention automatically handles mixed currency conflicts in the cart — when a shopper would end up with items priced in different currencies in one cart/order (which Commerce cannot total), this module detects and resolves the conflict (e.g. clearing or blocking the mismatch) so checkout doesn't break on incompatible currencies.

It's a cart-integrity safeguard for multi-currency stores with no payment or access role of its own. It works by decorating Commerce's `commerce_cart.cart_manager` service and reads each item's currency server-side from its price. Depends on `commerce`, `commerce_cart`, and `commerce_order`; requires Drupal Commerce 3 and Drupal 11.

---

- Handle mixed-currency cart conflicts.
- Detect incompatible currencies.
- Resolve the mismatch automatically.
- Prevent broken totals.
- Keep checkout working.
- Safeguard multi-currency stores.
- Carry no payment/access role.
- Depend on `commerce`, `commerce_cart`, `commerce_order`.
- Support Drupal 11.
- Guard cart integrity.
- Clear/block mismatches.
- Aid multi-currency.
- Prevent conflicts
- Handle currencies
- Support carts.
- Protect checkout.
- Resolve currency issues.
- Keep totals valid
