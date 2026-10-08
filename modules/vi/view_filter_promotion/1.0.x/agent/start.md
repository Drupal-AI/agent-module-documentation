<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View filter promotion (view_filter_promotion) — agent index

Commerce Views filter: products currently on promotion. Version **1.0.0**. Depends on `views` +
`commerce_promotion`.

- **Plugins**: `view_filter_promotion` (SQL), `view_filter_promotion_search_api` (Search API), both
  extend `ViewFilterPromotionBase` (BooleanOperator). Registered via
  `view_filter_promotion_views_data_alter()`.
- **Logic**: compares `calculated < base` price per variation using `commerce_order.price_calculator`,
  caches matching variation IDs (APCu/DB, 900s), then `addWhere(..., 'IN')` with a placeholdered ID
  array. Static join definition.
- **Security**: no request data in raw SQL; IDs are bound placeholders — no SQLi. No web route.
