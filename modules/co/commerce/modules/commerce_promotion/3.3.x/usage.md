Commerce Promotion adds discounts to Drupal Commerce: percentage or fixed-amount offers, optional coupon codes, condition-based eligibility, usage limits and scheduling.

---

A **promotion** (`commerce_promotion` config-ish content entity) pairs an **offer** with a set of **conditions** and applies to matching orders as a discount **adjustment**. The offer is a plugin (`commerce_promotion.promotion_offer`): built-ins include percentage-off and fixed-amount-off on the order total or on individual order items, plus buy-X-get-Y style offers. Eligibility uses the base Commerce **condition** plugins (order total, product, customer role, store, etc.), combined with AND/OR logic. Promotions can be automatic or require a **coupon** (`commerce_promotion_coupon`) — single or bulk-generated codes — and support start/end dates, per-promotion and per-coupon usage limits, weight/priority and compatibility rules (e.g. not combinable). It depends on Commerce and Commerce Order. Manage promotions and coupons at Admin → Commerce → Promotions (`entity.commerce_promotion.collection`). Developers add custom discount logic by implementing an offer plugin, and custom eligibility by implementing a condition plugin.

---

- Give a percentage discount off the order total.
- Give a fixed-amount discount off the order.
- Discount specific products or order items.
- Run a buy-one-get-one or buy-X-get-Y offer.
- Require a coupon code to unlock a discount.
- Generate bulk unique coupon codes for a campaign.
- Schedule a promotion with start and end dates.
- Limit total redemptions of a promotion.
- Limit redemptions per coupon or per customer.
- Restrict a promotion to orders over a threshold total.
- Restrict a promotion to certain products or categories.
- Restrict a promotion to specific customer roles.
- Restrict a promotion to a specific store.
- Combine conditions with AND/OR logic.
- Make promotions non-combinable or set priority/weight.
- Apply automatic (no-code) storefront-wide sales.
- Show the discount as an order adjustment on the summary.
- Offer free shipping via a promotion (with shipping module).
- Implement a custom offer plugin for bespoke discount math.
- Implement a custom condition for eligibility rules.
- Run seasonal sales that expire automatically.
- Track coupon usage for reporting.
