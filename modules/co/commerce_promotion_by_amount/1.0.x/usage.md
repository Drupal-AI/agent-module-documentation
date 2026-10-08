Commerce Promotion by amount adds two Commerce promotion **offers** that discount only the single cheapest or single most expensive matching product in an order, instead of every matching line item.

---

The module ships two `CommercePromotionOffer` plugins — `order_item_fixed_amount_off_by_amount` ("Fixed amount off for cheapest or most expensive matching product") and `order_item_percentage_off_by_amount` ("Percentage off …"). Both extend Commerce's `OrderItemPromotionOfferBase` and reuse core's `FixedAmountOffTrait` / `PercentageOffTrait` for the amount/percentage input, layering an `OrderItemOffByAmountTrait` on top that adds three radio settings: `type` (cheapest vs most_expensive), `compare` (rank order items by their **product/unit price** or by their **order-item total**), and `scope` (apply the discount to **all** units of the chosen item or **only one** unit). At apply time the offer sorts all order items, walks them cheapest-to-most-expensive (or reversed), picks the first one that passes the promotion's offer conditions, and only discounts that single item — clamping the adjustment so the item total never drops below zero. This makes it the standard building block for "cheapest item free / half price" and "money off your most expensive product" style promotions that plain Commerce offers cannot express. It has no settings form, config schema, permissions, or Drush of its own; you configure it entirely through a promotion entity's Offer selection. Configure route: `entity.commerce_promotion.collection` (Commerce → Promotions).

---

- Give the cheapest item in the cart a fixed amount off (e.g. "£5 off your cheapest product").
- Give the cheapest item a percentage discount (e.g. "cheapest item 50% off").
- Discount the customer's most expensive product instead of the cheapest.
- Build a "buy one get one free" style deal by setting 100% off the cheapest matching item, scoped to a single unit.
- Make the cheapest of several qualifying products free while leaving the rest full price.
- Apply a flat discount to only one unit of the cheapest line item rather than the whole quantity.
- Apply a flat discount across the entire quantity of the cheapest line item (scope = all products).
- Rank candidate items by product unit price so a high-quantity cheap item isn't unfairly chosen.
- Rank candidate items by order-item total instead, so quantity is taken into account when picking the target.
- Combine with the promotion's own offer conditions so only items matching a product/category qualify as the "cheapest".
- Run a coupon that takes a percentage off the single priciest product in the basket.
- Create a seasonal "your most expensive item, 20% off" campaign.
- Stack against other promotions safely — the offer reads the already-adjusted total and never pushes a line below zero.
- Offer "spend on 3, cheapest is free" mechanics using conditions plus the cheapest-item offer.
- Reward larger baskets by discounting the most expensive product once a cart condition is met.
- Provide a fixed voucher value that lands on one product rather than being split across the order.
- Limit a discount to a single product SKU that happens to be cheapest among matches.
- Configure the promotion via the standard Commerce Promotions admin UI (Add promotion → choose the "…by amount" offer).
- Script promotions in bulk by creating `commerce_promotion` entities whose `offer.target_plugin_id` is one of the two plugin ids.
- Export/deploy such promotions as configuration or content like any other Commerce promotion.
- Emulate a "lowest priced item discounted" retail rule familiar from other e-commerce platforms.
- Use percentage scope = product to discount just one unit's unit price versus the whole line total.
