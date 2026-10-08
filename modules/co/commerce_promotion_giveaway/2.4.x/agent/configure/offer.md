<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a giveaway promotion

1. Create a **Commerce Promotion** (Commerce → Promotions).
2. Choose the offer type **Giveaway**.
3. Configure:
   - **Giveaway** — the product variation to add (entity autocomplete).
   - **Quantity** — how many units to add.
   - **Show price** — either *override the order item price with 0* (no adjustment shown) or *show the list price and subtract it as an order adjustment*.
4. Add **conditions** (e.g. minimum order total, specific products) and a **coupon** and/or **usage limits** to control when and how often the giveaway is granted.

## Behavior
- `Giveaway::apply()` adds one order item for the variation, marked in `order` data (`giveaways[promotion_id]`) so it is added only once.
- If the promotion stops applying on a later order refresh, `GiveawayPromotionOrderProcessor::process()` removes the giveaway item.
- Promotion usage is registered on order placement — for zero-priced giveaways via the `giveaway_not_adjusted` flag in `GiveawayOrderEventSubscriber`.

## Abuse considerations
The item and quantity are fixed by the promotion config; a customer cannot alter them via request. Enforcement (how many times, for whom, with what coupon) is the promotion's own conditions and usage limits — set these to prevent repeated claims.
