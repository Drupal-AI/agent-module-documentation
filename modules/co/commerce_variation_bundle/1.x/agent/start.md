<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Variation Bundle (commerce_variation_bundle) — agent index

Sells **multiple product variations as one purchasable bundle** in Drupal Commerce. A bundle is an
ordinary `commerce_product_variation` whose type carries the `purchasable_entity_variation_bundle`
**trait**; the trait adds a `bundle_items` reference field (the components + quantities), a
`bundle_discount` percentage, and a `bundle_split` flag. Bundle price is computed **server-side**
from the referenced components. Installed **1.0.3** (doc dir `1.x`). Depends on `commerce`,
`commerce_product`. No module settings page; you configure per variation type / per variation.
Submodule (not nested): **`commerce_variation_bundle_attributes`** (experimental).

- **Entity & data model — the trait, `bundle_items`/`bundle_discount`/`bundle_split` fields, the
  `commerce_bundle_item` entity + its `commerce_bundle_item_type` bundles, title generation, the
  `DisallowVariationBundle` no-recursion constraint** → [entities.md](entities.md)
- **Pricing, saving adjustment, order split — price resolver, `VariationBundleOrderProcessor`, the
  `bundle_saving` adjustment type, `VariationBundleSplitter` + place-transition subscriber** →
  [pricing-and-orders.md](pricing-and-orders.md)
- **Bulk generator form + attributes submodule — `/product/{id}/variations/generate-bundles`,
  cartesian-product generation, dynamic attribute widget** → [generate-and-attributes.md](generate-and-attributes.md)

Key facts:
- **Turn on bundling:** edit a product *variation type* → Traits → **Variation bundles**
  (`purchasable_entity_variation_bundle`). `commerce_variation_bundle_enabled_types()` lists such
  types; `hook_entity_bundle_info_alter` swaps their class to `VariationBundle`.
- **Two pricing models** (per bundle variation, via `bundle_discount`):
  - `bundle_discount > 0` → **percentage offer**: unit price = full summed component price; the
    discount becomes a negative `bundle_saving` adjustment.
  - `bundle_discount = 0` → use the variation's own **price field / price list**; saving =
    configured full component total − unit price.
- **Split:** if `bundle_split` is TRUE, on order *place* the bundle order item is removed and one
  order item per component variation is created (adjustments split by each component's share of the
  total); a `variation_bundle_split` commerce_log entry is written.
- **Price integrity:** component prices/quantities and the bundle total are computed from the
  configured `bundle_items` entity fields, not from request input. There is no custom add-to-cart
  route — add-to-cart is Commerce core's.
- **Route:** only `commerce_variation_bundle.generate_bundle_variations`
  (`/product/{commerce_product}/variations/generate-bundles`), `_custom_access` requiring
  `administer commerce_product` + a bundle-trait variation type.
- **Permission:** `administer commerce_bundle_item_type` (restricted). Bundle-item entity ops use
  `administer commerce_product`.
- **Config entity:** `commerce_bundle_item_type` (config_export: `id`, `label`, `generateTitle`);
  default instance `default` ships with `generateTitle: true`.
- **Adjustment type:** `bundle_saving` (`commerce_variation_bundle.commerce_adjustment_types.yml`),
  registered on the order processor service (priority 100).
- **Theme:** `commerce_bundle_item` (template `commerce-bundle-item.html.twig`).
- **Known issue:** wrong tax calculation with core tax — drupal.org issue #3407999.
