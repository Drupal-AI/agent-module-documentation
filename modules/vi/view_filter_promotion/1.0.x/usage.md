<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View filter promotion adds a Views boolean filter ("Product has promotion") for Commerce. When enabled it computes, per product variation, whether the calculated price (with promotion adjustments) is below the base price, caches the matching variation IDs (APCu/DB, 15 min), and restricts the View to those variations. A Search API variant is included.

---

The filter builds its constraint through the Views query API: it adds a relationship/join with a static definition and calls `addWhere('AND', 'cpv.variations_target_id', $productsPromotion, 'IN')` where `$productsPromotion` is an array of integer variation IDs derived server-side from the price calculator — values are passed as bound placeholders, not concatenated, so there is no SQL injection. The join condition string is a fixed literal. The plugin caches results keyed by view ID and invalidates on value submit. No request-controlled data reaches raw SQL; no web-facing route is added. Requires Drupal Commerce (commerce_order price calculator, commerce_store).

---

- Filter a product View to only items currently on promotion.
- Show a "Deals" / "On sale" listing driven by real price calculation.
- Compare calculated vs base price per variation to detect discounts.
- Cache promotion membership for 15 minutes to reduce recomputation.
- Use APCu when available, falling back to the database cache.
- Provide a boolean exposed filter for shoppers.
- Support Search API-indexed product Views via the second plugin.
- Join product data to variations for the promotion check.
- Restrict results with a placeholdered `IN` clause on variation IDs.
- Invalidate the cache when the filter value is submitted.
- Build a promotions landing page from a View.
- Integrate with commerce_order's price calculator and adjustments.
- Scope by the current store/user context for pricing.
- Add the filter through the Views UI on Commerce product Views.
- Avoid custom SQL — values flow through Views placeholders.
- Feed a "hot deals" block from a filtered View.
- Pair with commerce_promotion to define the actual discounts.
