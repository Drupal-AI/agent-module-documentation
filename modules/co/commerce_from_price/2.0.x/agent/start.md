<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce From Price (commerce_from_price) — agent index

A Drupal Commerce **field formatter** set that renders a **"from" / "starting at" price** on a
product — the **lowest** price among its variations — so multi-variation products show one starting
price in catalogs and teasers. **Display only**: it reads variation prices and renders them; it
defines no routes, permissions, services, entities, or config entities. Package `Commerce (contrib)`.
Core `^10 || ^11`, PHP `^8.1`. License GPL-2.0-or-later. Installed version **2.0.1** (version dir `2.0.x`).

## Dependencies

- Drupal module: **`commerce:commerce_price`** (the only hard dependency, from `.info.yml`).
- Composer: `drupal/commerce ^2.0 || ^3.0`, `drupal/core ^10 || ^11`, `php ^8.1`, `ext-mbstring`.
- Soft/optional: **`commerce_order`** — if enabled, `hook_field_formatter_info_alter` swaps the
  calculated formatter's class for an order-aware one (see below). Not required.

## What it provides (from source)

Three field formatter plugins for **entity_reference** fields, applicable only to
`commerce_product` entities' **`variations`** field (`isApplicable()` in the shared trait):

- **`commerce_from_price_plain`** — `FromPricePlainFormatter` (extends core commerce `PricePlainFormatter`).
- **`commerce_from_price_default`** — `FromPriceDefaultFormatter` (extends `PriceDefaultFormatter`). Most common.
- **`commerce_from_price_calculated`** — `FromPriceCalculatedFormatter` (extends `PriceCalculatedFormatter`),
  resolving the price through the chain price resolver.

All three use **`FromPriceFormatterTrait`**, which holds the shared logic: settings form/summary,
`viewElements()`, lowest-price selection, published-only filtering, and cache metadata.

- **`hook_field_formatter_info_alter`** (`.module`): when `commerce_order` is enabled, rebinds
  `commerce_from_price_calculated` to `OrderFromPriceCalculatedFormatter` (extends
  `commerce_order`'s `PriceCalculatedFormatter`), which computes the price via the order module's
  `priceCalculator->calculate()` including configured adjustment types.
- **`hook_theme`** (`.module`): theme hook `commerce_from_price` with variables `label_before`,
  `price`, `label_after`; template `templates/commerce-from-price.html.twig`.
- No permissions, no routes, no services, no `.install`, no config schema, no config entities.

## Solution docs

- **Formatters, settings, lowest-price logic, caching, theming** → [formatters.md](formatters.md)

## Quick facts for agents

- Attach the formatter to a product type's **Variations** field on its *Manage display* page
  (`/admin/commerce/config/product-types/*/edit/display` or via Field UI). No global settings page.
- Only **published** variations count toward the "from" price (`getPurchasableEntities()` filters
  on `isPublished()`); unpublished variations contribute only to cache tags/contexts, not the price.
- Per-formatter settings: separate before/after labels for the single-entity vs multiple-entities
  case, plus `process_equal_prices_as_single` (treat all-equal-price variations as a single entity,
  i.e. use the single-entity labels). Default multiple-entities `label_before` = "Starting at".
