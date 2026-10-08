<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Cart Skip

Provides configurable "cart skip" rules so that, in defined situations, adding a product bypasses the shopping cart and creates an order directly.

- Enables express / buy-now style flows for specific products or contexts.
- Rules are config entities managed through an admin list/add/edit/delete UI.
- Routes the buyer to a "purchased" confirmation for the created order.
- Useful for single-product sales, donations or event tickets where a cart is unnecessary.

---

## Installation & configuration

- Depends on `commerce_cart`; enable with `drush en commerce_cart_skip`.
- Manage rules at `/admin/commerce/config/products/commerce_cart_skip` (permission: `administer commerce cart skip rules`).
- Add, edit and delete rules define when the cart is skipped.
- The confirmation page uses the created order and the matching rule.
- Only administrators with the module permission can manage rules.

---

## Usage & API

- Defines the `commerce_cart_skip_rule` configuration entity (`src/Entity/CommerceCartSkipRule.php`).
- Admin routes (collection/add/edit/delete) are all gated by `administer commerce cart skip rules`.
- Provides the permission `administer commerce cart skip rules`.
- `CommerceCartSkipPurchasedController::purchased()` renders the purchased/confirmation page.
- The purchased route `/product/purchased/{commerce_cart_skip_rule}/{commerce_order}` is gated by `_entity_access: 'commerce_order.view'`.
- The `commerce_order` route parameter is constrained to digits (`\d+`).
- Rule and order are loaded as typed entity parameters via route parameter converters.
- Entity forms provide add/edit/delete with standard Drupal CSRF protection.
- A list builder renders the rules collection in the admin UI.
- When a rule matches, an order is created without the intermediate cart step.
- Suitable for buy-now buttons and streamlined single-item checkouts.
- Because the purchased page requires `commerce_order.view` access, buyers only see their own order.
- No anonymous management routes are exposed.
- Configure rules per product/context to control exactly when skipping applies.
- Combine with checkout customisations for a fully express purchase flow.
- Test rule matching on a staging store before enabling in production.
