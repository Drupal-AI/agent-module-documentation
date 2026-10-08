<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Promo Link — route, controller, order subscriber, condition

How a coupon travels from a URL to the cart. Depends on `commerce:commerce_promotion` (which pulls
in `commerce_order`/`commerce_store`). No install-time config; enable with
`drush en commerce_promo_link`. No permission is added — the route reuses core `access content`.

## The link route

`commerce_promo_link.routing.yml`:

```
commerce_promo_link.promo_link:
  path: '/commerce/promotion/{code}'
  defaults:
    _controller: '\Drupal\commerce_promo_link\Controller\PromoLink::addPromoCode'
    _title: 'Add promo code'
  requirements:
    _permission: 'access content'
```

- `{code}` is the coupon **code** (not an id), e.g. `/commerce/promotion/SUMMER10`.
- It is a plain **GET**; the shareable link is the module's purpose.

## Controller — `PromoLink::addPromoCode()` (`src/Controller/PromoLink.php`)

Injected services (via `create()`): the container, `commerce_store.current_store`,
`current_user`, `tempstore.private`, `commerce_promotion.usage`, `entity_type.manager`.

Flow of `addPromoCode(string $code): RedirectResponse`:

1. Force a session: `$this->container->get('session')`; if not started, `$session->migrate()` (so an
   anonymous visitor gets a session/tempstore).
2. `$code = Html::escape($code)` — the code is sanitized before it is used in any message or stored.
3. Load the coupon: `entity_type.manager->getStorage('commerce_promotion_coupon')
   ->loadEnabledByCode($code)`.
4. If **no** coupon → error *"The provided coupon code is invalid."* and `redirect('<front>')`.
5. Else `couponIsExpiredOrUsed($coupon)` (see below); if it returns FALSE → error *"The provided
   coupon code is not available, it may have expired or have already been used."* and
   `redirect('<front>')`.
6. On success: `tempstore.private->get('commerce_promo_link')->set('coupon_code', $code)`, a status
   message *"Your coupon code @code will be automatically applied during the checkout."*, and
   `redirect('<front>')`.

**Redirect target** is always `$this->redirect('<front>')` (a `RedirectResponse` to the `<front>`
route). The module never reads `?destination` itself and never builds a `RedirectResponse` from a
raw parameter. A `?destination=` on the URL is honored only by Drupal core's
`RedirectResponseSubscriber`, which restricts it to internal/local targets — so it is not an
open-redirect surface.

### `couponIsExpiredOrUsed(CouponInterface $coupon): bool`

Despite the name it returns **TRUE when the coupon is still usable**. It reads usage via
`commerce_promotion.usage` (`loadByCoupon()` and `load($promotion)`) and returns FALSE if:

- the coupon's own `getUsageLimit()` is set and coupon usage ≥ that limit;
- the promotion's `getUsageLimit()` is set and promotion usage ≥ that limit;
- now (UTC) is before the promotion `getStartDate()` or after its `getEndDate()`;
- now is before the coupon `getStartDate()` or after its `getEndDate()`.

Note it checks limits/dates only — it does **not** evaluate the promotion's other conditions here;
those are enforced later by Commerce when the coupon is actually applied to the order.

## Applying to the cart — `OrderEventSubscriber` (`src/EventSubscriber/OrderEventSubscriber.php`)

Service `commerce_promo_link.order_event_subscriber` (args: `entity_type.manager`,
`tempstore.private`, `current_route_match`, `logger.channel.commerce_promo_link`). Subscribes to
`OrderEvents::ORDER_PRESAVE` at priority **-100**.

`onOrderPresave()` acts only when the order **has items** and is a **draft** (cart) AND the current
route is one of `entity.node.canonical`, `commerce_cart.page`,
`entity.commerce_product.canonical` (so the coupon can still be overridden during checkout). Then
`applyCouponCode($order)`:

- reads `coupon_code` from the `commerce_promo_link` tempstore; returns if empty;
- re-loads the coupon by code; if found:
  - `$order->set('coupons', $coupon->id())` — **only one** coupon is supported and it **replaces**
    any other coupon on the order;
  - `$order->setData('commerce_promo_link_promotion_code', $code)` — flags on the order that the
    coupon arrived via a link (this survives login, unlike the tempstore — see the drupal.org issue
    referenced in the code, #3308135);
  - deletes `coupon_code` from tempstore (so it is not re-applied to later orders);
  - logs `info` "applied coupon @coupon_id to order ID @order_id".
- if the coupon can no longer be loaded: a warning *"Your coupon code @code has expired."* and an
  `info` log.

## Restrict a promotion to the link — `PromoLinkOnly` condition

`src/Plugin/Commerce/Condition/PromoLinkOnly.php`, `@CommerceCondition(id = "promo_link_only",
category = "Order", entity_type = "commerce_order", parent_entity_type = "commerce_promotion")`.
Adds a checkbox *"Can only be applied using the promocode link."* (`link_only`, default FALSE) to a
promotion's conditions. `evaluate($order)` reads
`$order->getData('commerce_promo_link_promotion_code')`; the condition passes only when that flag is
set AND the coupon still `loadEnabledByCode()`s and is `available($order)`. Configure it on a
promotion at *Commerce → Promotions* under the Conditions tab.

## Operating notes

- Coupon codes live under Commerce promotions: *Commerce → Promotions → (a promotion) → Coupons*.
  The link uses the coupon **code**, not the promotion label.
- The link only queues the coupon; the discount amount and any promotion conditions are still
  computed by Commerce when the order refreshes.
- Because application is gated to node/cart/product routes, a visitor who only opens the link then
  goes straight to checkout without re-triggering one of those presaves may not see it applied until
  the cart changes.
