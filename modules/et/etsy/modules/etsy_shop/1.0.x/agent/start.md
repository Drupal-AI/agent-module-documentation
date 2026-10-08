<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Etsy Shop (etsy_shop) — agent index

Submodule of **Etsy API**; the reference implementation of an Etsy shop in Drupal. Package `Etsy`. Depends on **`etsy`, `views`, `node`, `taxonomy`** (Pathauto/Metatag optional). Core `^9.4 || ^10` (per its info.yml). License GPL-2.0-or-later. Version-dir 1.0.x.

No routes, permissions, services or Drush of its own (`etsy_shop.routing.yml`, `.links.menu.yml`, `.libraries.yml`, `.install` are empty). Everything is install config + cron import + theming + a price field.

## Solution docs

- **The cron import: sections → terms, listings → nodes** → [config/import.md](config/import.md)
- **Installed config: content type, fields, taxonomies, image styles, view, templates** → [config/model.md](config/model.md)
- **The etsy_price field type/widget/formatter + etsy_price theme** → [fields/price.md](fields/price.md)

## What it provides (from source)

- **hook_cron** (`etsy_shop_cron`): `_etsy_shop_cron_process_sections()` then `_etsy_shop_cron_process_listings()` using the base `etsy.api` service.
- **hook_theme** (`etsy_shop_theme`): `etsy_price` (template `etsy-price.html.twig`) and node templates `node__etsy_listing`, `node__etsy_listing__etsy_store_listing`.
- **hook_preprocess_field** (`etsy_shop_preprocess_field`): stub (a `field_etsy_when_made` case + commented-out image alt/title code).
- **Field plugins** (duplicate of etsy_fields, same ids): `EtsyPriceItem`, `EtsyPriceDefaultWidget`, `EtsyPriceDefaultFormatter` under `Drupal\etsy_shop\...`, using `etsy_shop_supported_currencies()`.
- **Install config** (`config/install/`): node type `etsy_listing`; ~40 `field_etsy_*` storages+fields on node + section fields on taxonomy; vocabularies `etsy_section`, `etsy_materials`; image styles `etsy_75x75` / `etsy_170x135` / `etsy_570w`; view `etsy_shop`; view mode `etsy_store_listing`; form/view displays; base-field overrides.
- **Optional config** (`config/optional/`): `pathauto.pattern.content_etsy_listing`, `metatag.metatag_defaults.node__etsy_listing`.
- **Templates** (`templates/`): `node--etsy-listing.html.twig`, `node--etsy-listing--etsy-store-listing.html.twig`, `etsy-price.html.twig`.
- **Helper**: `etsy_shop_supported_currencies()` (same map as base `etsy_supported_currencies()`).
