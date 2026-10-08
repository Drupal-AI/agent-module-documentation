# Commerce Promotion by amount — agent index

Adds two Commerce **promotion offers** that discount only the single **cheapest** or
**most expensive** matching order item, rather than every matching line. No settings form,
no config schema, no permissions, no Drush. You use it by picking one of its offers on a
`commerce_promotion` entity. Configure route: `entity.commerce_promotion.collection`.

- **The two offer plugins, their ids and config keys (type / compare / scope), how they apply** →
  [plugins/offers.md](plugins/offers.md)
- **Create/configure a promotion that uses one of these offers (UI, config entity, drush php)** →
  [configure/promotion.md](configure/promotion.md)

Key facts: plugin ids are `order_item_fixed_amount_off_by_amount` and
`order_item_percentage_off_by_amount`; both extend `OrderItemPromotionOfferBase`. The offer
targets exactly one order item (the cheapest/most-expensive that passes the offer conditions)
and clamps the discount so the item total never goes below zero.
