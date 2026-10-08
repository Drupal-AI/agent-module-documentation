<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installed content model (config/install + config/optional)

Everything below is created on `drush en etsy_shop`. There is no settings form; you tune it by editing this config in the UI after install.

## Content type — `etsy_listing`

`node.type.etsy_listing.yml`: label "Etsy listing", `new_revision: true`, submitted info hidden, menu_ui third-party settings (main menu). Description/help warn that listings should not be created/edited manually because imports overwrite local changes.

## Fields (node.etsy_listing) — ~40 `field_etsy_*`

Field storages + field instances in `config/install/field.storage.node.*` / `field.field.node.etsy_listing.*`, e.g.:
- `field_etsy_listing_id`, `field_etsy_shop_id`, `field_etsy_user_id`, `field_etsy_url` (string/int ids + shop URL).
- `field_etsy_price` (the **etsy_price** field type), `field_etsy_listing_quantity`, `field_etsy_listing_type`.
- `field_etsy_image` (string; Etsy image URLs), plus `body` (plain text).
- dimensions/weight: `field_etsy_item_height/length/width/weight`, `field_etsy_dimension_unit`, `field_etsy_weight_unit`.
- flags: `field_etsy_is_customizable/_personalizable/_private/_supply/_taxable`, `field_etsy_non_taxable`, `field_etsy_has_variations`, `field_etsy_autorenew`, `field_etsy_featured`.
- personalization: `field_etsy_pers_instructions`, `field_etsy_pers_char_count_max`, `field_etsy_personalization_req`.
- processing/policy: `field_etsy_processing_min/_max`, `field_etsy_return_policy_id`, `field_etsy_ship_profile_id`.
- metadata: `field_etsy_num_favorers`, `field_etsy_views`, `field_etsy_when_made`, `field_etsy_who_made_it`, `field_etsy_lang`, `field_etsy_created_timestamp`, `field_etsy_updated_timestamp`, `field_etsy_materials` (→ etsy_materials), `field_etsy_shop_section` (→ etsy_section), `field_tags`.

Base-field overrides set `promote`/`status` defaults for the bundle.

## Taxonomies

- `etsy_section` vocabulary + term fields `field_shop_section_id`, `field_shop_section_rank`, `field_shop_user_id` (populated by the section import).
- `etsy_materials` vocabulary (populated on demand from listing materials).

## Image styles

`etsy_75x75`, `etsy_170x135`, `etsy_570w` — image_scale effects sized to Etsy's standard image widths, used with Imagecache External on the remote image URLs.

## Views + view mode + displays

- View `etsy_shop` (`views.view.etsy_shop.yml`): base table `node_field_data`, default display title "Shop", filtered to the `etsy_listing` bundle, responsive grid style, mini pager 10/page; a page display **`page_1`** ("Shop Page") at path **`/shop`** with a normal menu link "Shop".
- View mode `etsy_store_listing` (`core.entity_view_mode.node.etsy_store_listing.yml`) plus entity view displays (`default`, `full`, `teaser`, `etsy_store_listing`) and the default form display.

## Templates

`node--etsy-listing.html.twig` and `node--etsy-listing--etsy-store-listing.html.twig` render the listing (images looped through `|imagecache_external('etsy_570w')`, remaining fields via `content|without('field_etsy_image')`); `etsy-price.html.twig` renders the price with data-attributes.

## Optional config (config/optional)

- `pathauto.pattern.content_etsy_listing`: URL alias pattern **`/shop/[node:title]`** for etsy_listing nodes (only if Pathauto is installed).
- `metatag.metatag_defaults.node__etsy_listing`: metatag defaults for the bundle (only if Metatag is installed).
