<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity & data model

## The bundle variation

There is no new "bundle product" entity. A bundle is a normal
`commerce_product_variation` whose variation **type** has the trait
`purchasable_entity_variation_bundle` (`VariationBundleTrait`,
`src/Plugin/Commerce/EntityTrait/VariationBundleTrait.php`). The trait adds three
`BundleFieldDefinition` fields to the variation type:

- **`bundle_items`** — entity_reference to `commerce_bundle_item`, required, cardinality
  unlimited, widget `inline_entity_form_complex`. The components of the bundle.
- **`bundle_discount`** — integer percentage, `max 100`, suffix `%`. `0` = use regular
  price field / price lists; `> 0` = percentage offer. See
  [pricing-and-orders.md](pricing-and-orders.md).
- **`bundle_split`** — boolean. If TRUE, split the bundle into per-component order items
  when the order is placed.

`commerce_variation_bundle.module`:
- `hook_entity_bundle_info_alter()` sets the entity class of every trait-enabled
  variation type to `VariationBundle` (`src/Entity/VariationBundle.php`).
- `commerce_variation_bundle_enabled_types()` returns the ids of variation types that
  have the trait.

### `VariationBundle` (extends `ProductVariation`)

Key methods:
- `getBundleItems()` — translated referenced `commerce_bundle_item` entities.
- `getBundleVariations()` / `getBundleVariationIds()` — the component *product variations*
  behind those bundle items. Note `getBundleVariationIds()` reads `bundle_items.target_id`
  (bundle-item ids), while `hasBundleVariation()` compares against variation ids — usable
  only meaningfully for the bundle-item set.
- `getBundlePrice(bool $adjusted = FALSE)` — sums `bundle_item.getPrice() ×
  bundle_item.getQuantity()` over the components. With `$adjusted = TRUE` and a percentage
  offer, returns the total minus `bundle_discount%`, rounded via `commerce_price.rounder`.
- `getBundleDiscount(): int`, `isPercentageOffer(): bool` (discount > 0),
  `shouldBundleSplit(): bool`.
- `generateTitle()` — joins component bundle-item titles with ` / ` (falls back to core
  title if none, or if > 255 chars).

## The bundle item entity — `commerce_bundle_item`

Content entity (`src/Entity/BundleItem.php`), one per component. Base table
`commerce_bundle_item`, translatable, `admin_permission = administer commerce_product`,
owner field `uid` (defaults to anonymous/0 in `preSave` if unset). Fields:

- **`variation`** — entity_reference to `commerce_product_variation`, required, widget
  `commerce_entity_select`. Carries the `DisallowVariationBundle` constraint (a bundle item
  may not reference another bundle variation — no recursion).
- **`quantity`** — decimal, read-only, `min 0`, default 1.
- **`price`** — **computed, read-only** `commerce_price` field
  (`BundleItemComputedPrice`): resolves the referenced variation's current price for the
  current store/user via `commerce_price.chain_price_resolver`. Never stored.
- **`title`** — string, required; auto-generated as `"{qty}x {variation title}"` in
  `preSave()` when the bundle-item type's `generateTitle` is on.
- `status` (boolean), `uid`, `created`, `changed`.

Routes/handlers: canonical redirects to the edit-form; `BundleItemHtmlRouteProvider`
marks edit/delete `_admin_route`. Admin UI lives under
`/admin/commerce/config/bundle-types/…`. Access handler
(`BundleItemAccessControlHandler`): `administer commerce_product` ⇒ full access;
otherwise `view` is allowed and other ops are neutral (denied).

Deleting a bundle item also removes its reference from any variation's `bundle_items`
(`BundleItem::delete()`).

## The bundle item type — `commerce_bundle_item_type`

Config entity (`src/Entity/BundleItemType.php`), bundle of `commerce_bundle_item`.
`admin_permission = administer commerce_bundle_item_type`. `config_export`: `id`, `label`,
`generateTitle`, `uuid`. `shouldGenerateTitle()` drives the `preSave` title generation and
hides the title widget in inline forms
(`hook_inline_entity_form_entity_form_alter`). A `default` type ships enabled with
`generateTitle: true` (`config/install/…commerce_bundle_item_type.default.yml`).

## Helper trait

`Drupal\commerce_variation_bundle\VariationBundleTrait` (the top-level one, distinct from
the entity-trait plugin): `isBundleActive($variation)` (has a non-empty `bundle_items`
field) and `useDefaultAttributes($variations)` — used by the attributes submodule.
