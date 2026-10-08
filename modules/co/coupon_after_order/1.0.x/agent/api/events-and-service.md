<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coupon After Order — extension API (events & controller service)

The module exposes two events and a reusable controller service so other modules can alter the
generated coupon or drive generation/mailing themselves (e.g. embed the coupon in the order receipt
mail rather than a separate message).

## Events (`Event\CouponAfterOrderEvents`)
Constants defined in `CouponAfterOrderEvents`:

- `COUPON_BEFORE_CREATE = 'coupon_after_order.coupon_before_create'` — fired **before** the new coupon
  is saved. Event class `CouponBeforeCreateAfterOrderEvent`.
- `COUPON_CREATED = 'coupon_after_order.coupon_created'` — fired **after** the coupon is saved. Event
  class `CouponCreatedAfterOrderEvent`.

Both are dispatched from `CouponAfterOrderController::generateCoupons()`. The dispatch is version-guarded
(`version_compare(\Drupal::VERSION, '9.1', '>=')`) for the new/old `EventDispatcher::dispatch()` argument
order.

### `CouponBeforeCreateAfterOrderEvent`
Constructed with `(OrderInterface $order, PromotionInterface $promotion, CouponInterface $coupon)`.
Getters: `getOrder()`, `getPromotion()`, `getCoupon()`. Setter: `setCoupon(CouponInterface $coupon)` —
replace the coupon before it is persisted (change code, usage limits, dates, etc.):

```php
public function onBeforeCreate(CouponBeforeCreateAfterOrderEvent $event) {
  $coupon = $event->getCoupon();
  $coupon->set('usage_limit', 3);
  $event->setCoupon($coupon);
}
// getSubscribedEvents(): [CouponAfterOrderEvents::COUPON_BEFORE_CREATE => 'onBeforeCreate']
```

### `CouponCreatedAfterOrderEvent`
Same constructor and `getOrder()` / `getPromotion()` / `getCoupon()` getters (no setter). Use it to log,
notify, or trigger follow-up work after the coupon exists.

## Controller service `coupon_after_order.controller`
Class `Controller\CouponAfterOrderController` (services in `coupon_after_order.services.yml`; injects
`config.factory`, `event_dispatcher`, `language.default`, `language_manager`, `entity_type.manager`,
`commerce_promotion.coupon_code_generator`, `token`, `commerce.mail_handler`). Public methods:

- `generateCoupons(OrderInterface $order): array` — selects the promotion, generates and saves a
  single-use coupon, dispatches both events; returns `['promotion' => …, 'coupon' => …]` or `[]` if no
  eligible promotion / code.
- `sendCoupons(OrderInterface $order, PromotionInterface $promotion, CouponInterface $coupon): bool` —
  language-aware, tokenized e-mail to `$order->getEmail()` via `commerce.mail_handler`.

Typical custom integration: set `generate_transition` empty and `send_email_after_generating` off in
config, then from your own subscriber call `\Drupal::service('coupon_after_order.controller')
->generateCoupons($order)` and include the returned coupon code in the order-receipt e-mail you already
send.

## Config-only knobs
The built-in `CouponAfterOrderSubscriber` reads `generate_transition` and
`send_email_after_generating`; leaving the transition empty disables the automatic listener entirely so
your code is the only driver. See [config/settings.md](../config/settings.md).
