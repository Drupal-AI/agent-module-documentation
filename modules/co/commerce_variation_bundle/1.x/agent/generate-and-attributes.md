<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk generator form & attributes submodule

## Generate bundle variations form

Route `commerce_variation_bundle.generate_bundle_variations` →
`/product/{commerce_product}/variations/generate-bundles`, form
`Form/GenerateBundleVariationsForm.php`. Linked as a "Generate variations" action on the
product variation collection. `_admin_route`.

**Access:** `_custom_access = BundleVariationGenerateAccess::access` — requires
`administer commerce_product` AND that the product's product type has at least one variation
type carrying the `purchasable_entity_variation_bundle` trait; otherwise forbidden.

**What it does:** lets an admin build bundle variations from the **cartesian product** of
other products' variations.
- Add source products one at a time (entity autocomplete + "Add product" AJAX). The bundle
  product itself cannot be added as a source.
- For each added product, tick which of its **enabled** variations take part and set a
  **quantity per bundle**. Every remaining variation is combined with every remaining
  variation of the other products; a live summary reports the combination count.
- **Server-side validation:** submitted variation ids are intersected with the product's
  actually-enabled variations (`getSourceSelection()` — "Only ever trust ids that belong to
  this product's enabled variations"). At least one product and one variation per product
  are required. `COMBINATION_LIMIT = 500` caps a single run (both in the summary and
  `validateForm`).
- A template variation (built from the bundle variation type's default form display, minus
  `bundle_items`, `sku`, attribute fields, and — when auto-titled — `title`) collects field
  values that are copied onto every generated variation.
- **SKU options:** optionally append each `>1` quantity (`…xN`) and/or prefix the parent
  product id, so the same variations can be bundled again in different amounts (otherwise a
  duplicate SKU is skipped). SKUs are truncated to 255 chars.

**On submit** (`submitForm`), for each combination: creates a `commerce_bundle_item` per
component (`bundle: default`, the source variation, its per-product quantity), creates a new
bundle variation of the target type, copies the template field values, sets the SKU and
`bundle_items`, saves, and adds it to the product. Reports created/skipped counts.

## Attributes submodule (`commerce_variation_bundle_attributes`) — experimental

Separate module in `modules/attributes/`, depends on `commerce_variation_bundle`. Lets an
add-to-cart form expose the attributes of the components *behind* a bundle, so a shopper
picks attribute values and the matching bundle variation is selected.

- **`VariationBundleAttributesWidget`** (field widget
  `commerce_variation_bundle_attributes`, extends core
  `ProductVariationAttributesWidget`). If any of the product's variations is not a bundle,
  or a bundle uses regular attributes (`useDefaultAttributes()`), it defers to the core
  widget. Otherwise it builds attribute selects aggregated from all component variations and
  resolves the chosen bundle variation on rebuild / in `massageFormValues()`.
- **`ProductVariationBundleAttributeMapper`** (extends core
  `ProductVariationAttributeMapper`): `collectAttributes()` gathers component attribute value
  ids; `selectVariation()` matches submitted attribute values against a bundle's collected
  attributes (all present attributes must match) and falls back to the product's default
  variation; `prepareAttributes()` / `getAttributeValueId()` map component attributes onto
  the bundle.

Selection is constrained to the product's enabled variations (or its default variation);
the resolved `variation` element is a server-computed `#type => value`. Marked experimental
upstream — use at your own risk.
