<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coupon After Order — settings & operation

## Install / enable
Requires Commerce (`commerce`, `commerce_order`, `commerce_price`, `commerce_promotion`) and
`state_machine`. `composer require drupal/coupon_after_order` then enable `coupon_after_order`.
Enabling installs `config/install/coupon_after_order.settings.yml` and the two promotion base fields.

## Configuration object `coupon_after_order.settings`
Edited at `/admin/commerce/config/coupon_after_order` via `Form\SettingsForm` (form id
`coupon_after_order_settings`, extends `ConfigFormBase`). Schema:
`config/schema/coupon_after_order.schema.yml`. Keys:

- `generate_transition` (string, default `place`) — the order-workflow transition on which coupons are
  generated. Leave **empty** to disable the built-in listener and drive generation from your own code.
- `send_email_after_generating` (boolean, default `true`) — whether to send the coupon e-mail after a
  coupon is created. Uncheck to generate silently and send the code yourself.
- `email_subject` (text) — tokenized subject line.
- `email_text` (text) — tokenized HTML body.

`email_subject`/`email_text` accept `commerce_order`, `commerce_promotion` and
`commerce_promotion_coupon` tokens (the form renders a `token_tree_link` when the optional `token`
module is enabled). Both are translatable (`coupon_after_order.config_translation.yml`), and the
promotion description honours entity translations. Default subject/body are in the install config.

## Promotion base fields (`hook_entity_base_field_info`)
Added to `commerce_promotion` entities by `coupon_after_order.module`:

- `coupon_after_order` — boolean "Create coupon after order" (default FALSE).
- `coupon_after_order_min_price` — `commerce_price` "Minimal order price"; if the order total reaches
  this value a coupon is generated.

`hook_form_alter` places both under the promotion form's `coupon_details` group and shows/enables them
only when core's "Require a coupon to apply this promotion" (`require_coupon`) is checked (and, for the
min price, when `coupon_after_order` is checked too).

## How generation runs
`EventSubscriber\CouponAfterOrderSubscriber` subscribes to `KernelEvents::REQUEST` (priority 900) and,
in `onRequest()`, dynamically adds a listener to `commerce_order.{transition}.post_transition` at
priority `-101` (so it runs after Commerce's `OrderReceiptSubscriber` — invoice first, coupon after).
`onOrderTransition(WorkflowTransitionEvent)` gets the order and calls
`CouponAfterOrderController::generateCoupons($order)`; if a coupon+promotion come back and
`send_email_after_generating` is on, it calls `sendCoupons()`.

`Controller\CouponAfterOrderController::generateCoupons()`:
- Queries `commerce_promotion` for the **first** (weight ASC, then promotion_id ASC) enabled promotion
  where `require_coupon = 1` and `coupon_after_order = 1`, filtered by (optional) min price ≤ order
  total, matching currency, order type, store, and start/end date window. The query uses
  `accessCheck(FALSE)` because it runs in a background transition context.
- Generates a random code via `commerce_promotion.coupon_code_generator`
  (`CouponCodePattern::ALPHANUMERIC`, length 10, up to 20 attempts).
- Creates a `commerce_promotion_coupon` bound to that promotion with `usage_limit = 1`,
  `usage_limit_customer = NULL`, `status = 1`, `start_date = now`.
- Dispatches `COUPON_BEFORE_CREATE`, saves the coupon, dispatches `COUPON_CREATED`, and returns
  `['promotion' => …, 'coupon' => …]`.

`sendCoupons()` picks the customer's `preferred_langcode` (authenticated) or the current site language,
temporarily switches the active language (`changeActiveLanguage()`), token-replaces subject and body
(`clear => TRUE`), renders the body as an `inline_template`, and sends through
`commerce.mail_handler` (`sendMail()`) to `$order->getEmail()`.

## Routes & permissions
- Route `coupon_after_order.settings` → `/admin/commerce/config/coupon_after_order`, requirement
  `_permission: 'administer coupon_after_order configuration'`.
- Permission `administer coupon_after_order configuration` (`restrict access: true`).
- Menu link under `commerce.configuration`; local task tab. No other routes — coupon generation is not
  exposed as an HTTP endpoint, it runs only on the internal order-transition event.
