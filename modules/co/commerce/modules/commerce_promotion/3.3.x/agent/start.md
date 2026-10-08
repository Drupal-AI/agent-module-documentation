# commerce_promotion — agent start

Commerce submodule: discounts. A **promotion** pairs an **offer** (percentage/fixed off,
BOGO) with **conditions** (base Commerce condition plugins) and adds a discount adjustment to
matching orders. Optional **coupons** (single/bulk codes), scheduling, usage limits,
priority. Requires `commerce`, `commerce_order`. Admin: **/admin/commerce/promotions**
(`entity.commerce_promotion.collection`).

- Configure promotions, coupons, conditions, permissions → [configure/promotions.md](configure/promotions.md)
- Promotion offer plugin (`commerce_promotion.promotion_offer`) → [plugins/offer.md](plugins/offer.md)
