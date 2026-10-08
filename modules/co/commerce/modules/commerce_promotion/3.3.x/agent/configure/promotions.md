# Promotions configuration

Entities:
- `commerce_promotion` — an offer + conditions + schedule/limits; applies as a discount
  adjustment to eligible orders. Manage at `/admin/commerce/promotions`
  (`entity.commerce_promotion.collection`).
- `commerce_promotion_coupon` — optional codes gating a promotion; single or bulk-generated.

A promotion configures:
- **Offer** — a `commerce_promotion.promotion_offer` plugin (percentage/fixed off order or
  items, BOGO). See [../plugins/offer.md](../plugins/offer.md).
- **Conditions** — base Commerce **condition** plugins (order total, product, customer role,
  store…) with AND/OR operator.
- **Coupons** — none (automatic) or one/many codes.
- **Schedule** — start/end dates; **usage limits** per promotion and per coupon;
  **weight/priority** and compatibility (combinable or not).

Managers: `plugin.manager.commerce_promotion_offer` (`PromotionOfferManager`); conditions use
the base `plugin.manager.commerce_condition`.

## Permissions
`administer commerce_promotion` (restricted) plus dynamic view/manage permissions. Config
schema: `config/schema/commerce_promotion.schema.yml`.
