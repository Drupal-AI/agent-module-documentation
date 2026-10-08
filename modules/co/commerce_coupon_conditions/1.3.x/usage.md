<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Coupon Conditions lets each coupon carry its own Commerce order conditions, so a single discount can have many coupon codes that each apply under different rules.

---

In Drupal Commerce a promotion owns the conditions (order total, customer, order items) and a coupon is just a code that unlocks that promotion. That forces you to create a separate discount for every distinct rule. This module moves the condition set down onto the coupon: it swaps the `commerce_promotion_coupon` entity class for its own `Coupon` class and adds two base fields — `conditions` (a `commerce_plugin_item:commerce_condition` field limited to order-scoped conditions) and `condition_operator` (`AND`/`OR`, default `AND`). It ships no new condition plugins of its own; it reuses Commerce's existing order conditions and exposes the same `commerce_conditions` widget on the coupon edit form. At redemption, the overridden `Coupon::available()` first runs core's own availability checks and, only if they pass, calls `Coupon::applies()`, which evaluates the coupon's conditions server-side against the live order through a `ConditionGroup`. The check is additive — it can only make an already-valid coupon fail its extra rules, never loosen core's checks. This means one promotion can back many coupons — one per country, per employee, per campaign — each restricted differently. It depends on `commerce` and `commerce_promotion`, targets core `^10.3 || ^11`, and has no settings page, routes, permissions, or drush commands.

---

- Give one discount many coupon codes, each with its own restriction.
- Restrict a specific coupon to orders above a total, without a new promotion.
- Issue a per-country coupon code off a single geo-distributed discount.
- Hand each employee a personal coupon gated by their email.
- Restrict a coupon to a particular customer role.
- Combine a coupon's conditions with AND (all must pass) or OR (any passes).
- Limit a coupon to carts containing a specific product.
- Keep the parent promotion open while narrowing individual coupons.
- Run a launch campaign with many differently-restricted codes under one discount.
- Add order conditions that only apply when a coupon is redeemed.
- Reduce the number of promotions a store manager has to maintain.
- Apply a customer-segment rule to a coupon rather than the whole promotion.
- Restrict a code to registered/authenticated customers via a customer condition.
- Set a per-coupon order-total floor for free shipping codes.
- Attach conditions to a coupon programmatically with setConditions().
- Read a coupon's conditions and operator in code with getConditions()/getConditionOperator().
- Migrate coupon start/end dates to full datetime format via the shipped update hook.
- Override the update's date-time callbacks with hook_commerce_coupon_conditions_update_8101_alter.
- Skip the date-migration update with a settings.php flag.
- Test a coupon's rules against a real cart before publishing.
- Restrict a wholesale coupon by customer email domain.
- Support a loyalty code that only works for a chosen role.
