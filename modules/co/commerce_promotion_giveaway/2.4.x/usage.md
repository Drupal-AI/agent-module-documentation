<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a promotion offer plugin that gives a configured product variation to qualifying orders for free.

---

The offer plugin `Giveaway` (`@CommercePromotionOffer id=order_giveaway`, order-scoped) is configured on a Commerce Promotion with a target product variation, a quantity, and a "show price" toggle. When the promotion's conditions match, `apply()` creates an order item for the configured variation and either sets its unit price to zero (hidden) or keeps the list price and subtracts it as an order-level promotion adjustment. A `giveaway` marker is stored in order data so the item is only added once per promotion; `GiveawayPromotionOrderProcessor` removes the giveaway item again if the promotion no longer applies on a later order refresh, and `GiveawayOrderEventSubscriber` registers promotion usage on order placement (including the zero-priced case, via a `giveaway_not_adjusted` flag).

Security/abuse posture: the giveaway product and quantity come from the promotion configuration (admin-set), not from anything the customer submits, and the offer is applied server-side within Commerce's promotion engine — so its conditions, coupons and usage limits are the enforcement point. A customer cannot pick the giveaway item, change its quantity, or stack it beyond the promotion's own usage limits through a request they control. Set appropriate conditions and usage limits on the promotion to bound how often the giveaway is granted.

---
- Give a free product when an order qualifies for a promotion
- Add a gift-with-purchase to Commerce checkout
- Configure which product variation is given away
- Set the giveaway quantity per promotion
- Hide the giveaway price (unit price zero) at checkout
- Show list price and subtract it as a visible adjustment
- Gate the giveaway behind promotion conditions (e.g. order total)
- Attach the giveaway to a coupon-based promotion
- Bound giveaways with the promotion's usage limits
- Register promotion usage even for zero-priced giveaways
- Automatically remove the gift if the order no longer qualifies
- Run a "buy X, get free item" style campaign
- Offer seasonal free-sample promotions
- Combine with other Commerce promotions/coupons
- Ensure the giveaway is added only once per promotion
- Reward customers with a free add-on item
- Localize the "Giveaway" adjustment label
- Test giveaway behavior with the shipped kernel test
