# Promotion offer plugin

Plugin type `commerce_promotion.promotion_offer` — the discount logic applied when a
promotion's conditions match.

- Manager: `plugin.manager.commerce_promotion_offer`
  (`Drupal\commerce_promotion\PromotionOfferManager`). Defined in
  `commerce_promotion.plugin_type.yml`.
- Attribute: `#[CommercePromotionOffer]` (id, label, entity_type). Base classes in
  `src/Plugin/Commerce/PromotionOffer/` — `PromotionOfferBase`, plus order- vs
  order-item-scoped bases. Place plugins in `src/Plugin/Commerce/PromotionOffer/`.
- Key methods: `apply(EntityInterface $entity, PromotionInterface $promotion)` — add the
  discount **adjustment**; `buildConfigurationForm()` / `submitConfigurationForm()` for the
  offer settings (e.g. percentage or amount) shown on the promotion form.
- Built-ins: percentage-off and fixed-amount-off on order total or per order item, plus
  buy-X-get-Y offers.

Eligibility is handled separately by base Commerce **condition** plugins
(`commerce.condition`) configured on the promotion — see the base `commerce` module's plugin
docs. To create a bespoke discount, implement an offer plugin; it becomes selectable in the
promotion's Offer dropdown.
