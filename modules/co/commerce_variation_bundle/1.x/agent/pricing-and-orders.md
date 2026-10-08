<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pricing, saving adjustment, and order split

All amounts are derived server-side from the bundle variation's configured `bundle_items`
(component prices via the computed price field, component quantities from the stored
`quantity` field). Add-to-cart uses Commerce core; this module contributes a price
resolver, an order processor, and a place-transition subscriber.

## Two pricing models

Chosen per bundle variation by the `bundle_discount` integer field (see
[entities.md](entities.md)).

### Percentage offer (`bundle_discount > 0`)

- `VariationBundlePriceResolver` (`src/Resolver/…`, price_resolver **priority 1000**)
  returns `$bundle->getBundlePrice()` — the **full** un-discounted component total — as the
  resolved unit price (only when the entity is a `VariationBundle` with bundle items and
  `isPercentageOffer()`).
- `VariationBundleOrderProcessor` then computes
  `bundle_price = getBundlePrice(TRUE)` (total minus `bundle_discount%`, rounded) and adds
  a negative `bundle_saving` adjustment of `bundle_price − full` × quantity. The
  adjustment's `percentage` is `bundle_discount / 100`.

### Regular price / price list (`bundle_discount = 0`)

- The resolver returns NULL, so the variation's own **price field** or a **price list**
  (any core price resolver) sets the unit price.
- `VariationBundleOrderProcessor` sets the unit price to the full component total
  (`getBundlePrice()`) unless already overridden, treats the resolved unit price as the
  discounted `bundle_price`, and adds the `bundle_saving` adjustment for the difference.

In both models the processor:
- Skips bundle order items whose unit price `isZero()` (avoids divide-by-zero on the split
  percentages; a deliberately free bundle has no saving to represent).
- Only adds the adjustment when it is genuinely negative (a real saving).
- Records per-component data on the order item for later splitting:
  `data['bundle_items']` = a map of `BundleItemAmounts` (variation_id, price, quantity,
  `split_percentage` = component price×qty ÷ unit price, rounded to 2) and
  `data['bundle_discount']`.

## The `bundle_saving` adjustment type

Declared in `commerce_variation_bundle.commerce_adjustment_types.yml` (label "Bundle
saving", `has_ui: true`, weight 10). The order-processor service is tagged
`commerce_order.order_processor` priority **100** with `adjustment_type: bundle_saving`.

## Splitting a bundle into separate order items

Controlled by `bundle_split` on the bundle variation.

- `OrderVariationBundleSubscriber` (`src/EventSubscriber/…`) listens on
  **`commerce_order.place.pre_transition` at priority -1000** (as late as possible). For
  each order item whose purchased entity is a `VariationBundleInterface` with
  `shouldBundleSplit()` TRUE, it removes the bundle order item and adds the per-component
  order items returned by the splitter, then writes a `variation_bundle_split`
  commerce_log entry (`commerce_variation_bundle.commerce_log_templates.yml`).
- `VariationBundleSplitter::createOrderItems()` builds one `commerce_order_item` per
  component: `purchased_entity` = the component variation, `quantity` = component qty ×
  original bundle qty, `unit_price` = the component's stored price,
  `adjustments` = that component's split share, `data['bundle_source']` = original
  purchased-entity id.
- `VariationBundleSplitter::split()` distributes the bundle order item's adjustments across
  components by each component's `split_percentage` (`splitAdjustments()` multiplies each
  adjustment by the percentage). `groupAdjustments()` accumulates per-type magnitudes, and
  any rounding remainder left after the last component is folded back into a single
  adjustment of that type so the parts sum exactly to the original.

## Value objects

`BundleItemAmounts` (`src/BundleItemAmounts.php`) — immutable-ish holder for one
component's split data (required: `quantity`, `variation_id`, `price` (a `Price`),
`split_percentage`; optional `adjustments`). `getVariation()` loads the referenced
`ProductVariation`. Used only as the `data['bundle_items']` payload and by the splitter.
