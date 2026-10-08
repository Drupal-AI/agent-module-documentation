<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Promotion Giveaway (commerce_promotion_giveaway) — agent index

**Promotion offer plugin that adds a configured product variation to a qualifying order for free (or at list price minus an adjustment).**

- **Version:** 2.4.x
- **Core:** ^10.1 || ^11
- **Requires:** commerce, commerce_promotion
- **Offer plugin:** `order_giveaway` → `Giveaway` (config: giveaway variation, quantity, show_price)
- **Order processor:** `GiveawayPromotionOrderProcessor` (removes item when no longer applicable)
- **Event subscriber:** `GiveawayOrderEventSubscriber` registers promotion usage on `commerce_order.place.pre_transition`

**Security:** Giveaway product/quantity are admin-configured on the promotion, not customer-controllable; applied server-side inside Commerce's promotion engine, so conditions/coupons/usage-limits bound abuse. No request-driven way to pick the item, change quantity or stack beyond the promotion's limits. No findings. See [configure/offer.md](configure/offer.md).
