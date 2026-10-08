<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Promo Link (commerce_promo_link) — agent index

Applies a **Drupal Commerce promotion coupon via a shareable URL**. A GET to
`/commerce/promotion/{code}` validates the coupon and parks it in the visitor's private tempstore;
an order-presave subscriber later writes that single coupon onto the draft cart order. Package
`Commerce (contrib)`. Version **2.1.3** (dir `2.x`). Core `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Depends only on **`commerce:commerce_promotion`**.

- **The route, controller validation, order subscriber, and the `promo_link_only` condition —
  install, mechanism, and how to operate it** → [api/promo-link.md](api/promo-link.md)

## What it actually is (from source)

- **One route** `commerce_promo_link.promo_link` (`commerce_promo_link.routing.yml`): path
  `/commerce/promotion/{code}`, `_permission: 'access content'`, controller
  `PromoLink::addPromoCode` (`src/Controller/PromoLink.php`).
- **One controller** `PromoLink` (extends `ControllerBase`). `addPromoCode(string $code)` starts a
  session, `Html::escape()`s the code, loads the coupon via
  `commerce_promotion_coupon` storage `loadEnabledByCode()`, checks usage limits + start/end dates
  (`couponIsExpiredOrUsed()`), stores `coupon_code` in `tempstore.private` collection
  `commerce_promo_link`, and returns `redirect('<front>')`.
- **One event subscriber** `OrderEventSubscriber` (`src/EventSubscriber/OrderEventSubscriber.php`),
  service `commerce_promo_link.order_event_subscriber`, listens on `OrderEvents::ORDER_PRESAVE`
  (priority -100). On a draft cart order viewed from a node/cart/product route it calls
  `applyCouponCode()`: sets the single coupon on the order, flags
  `order->setData('commerce_promo_link_promotion_code', $code)`, deletes the tempstore code, logs.
- **One Commerce condition plugin** `PromoLinkOnly` (id `promo_link_only`,
  `src/Plugin/Commerce/Condition/PromoLinkOnly.php`): a checkbox on a promotion so it applies only
  when the order carries the promo-link data flag.
- **No** admin settings form, **no** permissions of its own, **no** Drush, **no** config
  install/schema, **no** hooks, **no** submodules.
