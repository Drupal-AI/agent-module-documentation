<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coupon After Order (coupon_after_order) — agent index

Drupal Commerce add-on that generates a single-use promotion **coupon after an order** reaches a
configured order-workflow transition, then optionally e-mails the code to the customer.

- **Package:** Commerce. **Version dir:** 1.0.x. **Core:** `^9 || ^10 || ^11`.
- **Composer:** `drupal/coupon_after_order` requires `drupal/commerce ^2.29 || ^3.0`.
- **Module dependencies:** `commerce`, `commerce_order`, `commerce_price`, `commerce_promotion`,
  `state_machine`.
- **Configure route:** `coupon_after_order.settings` → `/admin/commerce/config/coupon_after_order`
  (permission `administer coupon_after_order configuration`).

## What it provides
- **Base fields on `commerce_promotion`** (`hook_entity_base_field_info` in `.module`):
  `coupon_after_order` (boolean "Create coupon after order") and `coupon_after_order_min_price`
  (commerce_price "Minimal order price"). `hook_form_alter` groups/`#states`-toggles them on the
  promotion add/edit/duplicate forms behind the core "Require a coupon" checkbox.
- **Config object** `coupon_after_order.settings` (`generate_transition`, `send_email_after_generating`,
  `email_subject`, `email_text`) with schema and config-translation support.
- **Service** `coupon_after_order.controller` (`CouponAfterOrderController`) — the coupon generation +
  mail logic, reusable by other modules.
- **Event subscriber** `coupon_after_order.event_subscriber` (`CouponAfterOrderSubscriber`) — attaches
  a listener to the configured order transition.
- **Events** `coupon_after_order.coupon_before_create` and `coupon_after_order.coupon_created`
  (`CouponAfterOrderEvents` constants; event classes `CouponBeforeCreateAfterOrderEvent`,
  `CouponCreatedAfterOrderEvent`).
- **Permission** `administer coupon_after_order configuration` (restrict access).

## Solution docs
- [Settings & operation](agent/config/settings.md) — config keys, base fields, promotion selection,
  the settings form and permission.
- [Extension API: events & controller service](agent/api/events-and-service.md) — how to alter the
  coupon or drive generation/mail from your own code.
