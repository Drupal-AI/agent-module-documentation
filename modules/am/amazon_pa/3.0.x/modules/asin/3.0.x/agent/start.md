<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon Field (asin) — agent index

Submodule of **Amazon PAAPI5**. Adds an **`asin` field type** (stores one Amazon product ID per entity)
plus a widget, 13 formatters, and Views integration over the parent module's cached product tables.
Package `Amazon`. Core `^8 || ^9 || ^10 || ^11`. Depends on `amazon_pa` (`amazon_pa:amazon_pa`).
Version 3.0.1. `asin.module` is an empty stub — all logic is in plugins + `asin.views.inc`.

## Plugins → [fields/field.md](fields/field.md)

- **Field type** `asin` — `Plugin\Field\FieldType\AmazonField`. One column `asin` (varchar 32).
  `default_widget = asin_text`, `default_formatter = asin_plain`. Field setting `locale` (required;
  options = configured Amazon locales), schema `field.field_settings.asin` in `config/schema/asin.schema.yml`.
- **Widget** `asin_text` — `Plugin\Field\FieldWidget\AmazonFieldWidget`. Textfield (maxlength 15) with an
  `#element_validate` that looks the ASIN up (web if `update.amazon_update_on_node_edit`, else cache) and
  sets a form error for invalid ASINs; also previews the stored title from the DB.
- **13 formatters** (`Plugin\Field\FieldFormatter\*`): `asin_plain` (raw ASIN), `asin_detailpageurl`
  (product URL), `asin_details` (Detail.php → theme `amazon_details`), `asin_sbutton`,
  `asin_thumbnail_small|medium|large`, `asin_thumbnail_medium_title`,
  `asin_gallery_small|medium|large`, `asin_gallery_medium_details`, `asin_widget`. Each resolves the
  locale (field setting or default), calls `amazon_pa_item_lookup($asin, FALSE, $locale)`, and renders a
  parent-module theme hook with `library: amazon_pa/amazon_pa`.

## Views (`asin.views.inc`)

- `asin_views_data()` declares `amazon_item` as a **base table** (key `asin`) with field/sort/filter/argument
  handlers for every product column (title, prices, savings, sales rank, brand, mpn, binding, invalid_asin,
  buy-box, EU price type/label…), plus joins for `amazon_item_image` and `amazon_item_participant`.
- Custom field handler **`views_handler_field_amazon_image`** (`Plugin\views\field\AmazonImage`) LEFT-JOINs
  `amazon_item_image` filtered by an image-size option and renders the image as markup or plain URL,
  optionally wrapped in a `Link` to `detailpageurl` (`Url::fromUri`).
- `asin_field_views_data()` adds a relationship from an `asin` field to the `amazon_item` base table.

## Use

Enable `asin`, add an *Amazon asin field* to a bundle, pick its locale, then choose a formatter on
*Manage display*. Product data is fetched/cached by the parent module on first view (or on save if the
node-edit refresh option is on).
