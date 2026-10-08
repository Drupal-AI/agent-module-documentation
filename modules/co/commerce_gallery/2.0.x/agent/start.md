<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Gallery (commerce_gallery) — agent index

Renders **Drupal Commerce product-variation images** as a responsive **masonry / grid / metro**
gallery block with a shared lightbox, filter bar, and per-block theming. It is a pure display
module: two **Block plugins** query published product variations, collect their image-field files,
and render server-built markup; the JS reads DOM data attributes to drive layout and the lightbox.
There are **no routes, controllers, services, permissions, or entities** of its own.

Package `Commerce`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed version **2.0.0**
(version dir `2.0.x`). Security-advisory coverage: **not covered**.

## Dependencies

- Drupal modules (`.info.yml`): `drupal:file`, `drupal:image`, `commerce:commerce`,
  `commerce:commerce_product`.
- Composer (`composer.json`): `php >=8.1`, `drupal/core ^10 || ^11`,
  `drupal/commerce ^2.40 || ^3.0`, `drupal/address ^1.12 || ^2.0`. `minimum-stability: dev`.

## What it provides (from source)

- **Block `commerce_advanced_gallery`** — admin label "Commerce Gallery (Advanced Masonry)",
  category "Commerce". The full-featured block: ~30 config settings, masonry/grid/metro layout,
  scoped CSS variables, lightbox, filter bar, responsive columns. Class
  `src/Plugin/Block/CommerceAdvancedGalleryBlock.php`. See
  [blocks/advanced-gallery.md](blocks/advanced-gallery.md).
- **Block `commerce_gallery`** — admin label "Commerce Gallery (Legacy)", category "Commerce". A
  simple column-chunked grid with product links; far fewer options. Class
  `src/Plugin/Block/CommerceGalleryBlock.php`. See
  [blocks/legacy-gallery.md](blocks/legacy-gallery.md).
- **Libraries** (`commerce_gallery.libraries.yml`): `gallery` (CSS only, used by the legacy block)
  and `advanced-gallery` (CSS + `js/commerce-advanced-gallery.js`, deps `core/jquery`,
  `core/drupal`, `core/drupalSettings`, `core/once`).
- **Theme hooks** (`commerce_gallery.module`, `hook_theme`): `commerce_gallery` and
  `commerce_advanced_gallery`, with templates in `templates/`. A
  `hook_theme_suggestions_commerce_gallery` adds a `commerce_gallery__<block_id>` suggestion.
- **Config schema** (`config/schema/commerce_gallery.schema.yml`): `block.settings.commerce_gallery`
  mapping for every advanced-block setting. (No schema is declared for the legacy block's keys.)
- **No** `.routing.yml`, `.services.yml`, `.permissions.yml`, `.install`, or hook_update. No custom
  entities or plugin types.

## Data flow (both blocks)

`build()` runs an entity query on `commerce_product_variation` with `->accessCheck(TRUE)` and
`->condition('status', 1)`, loads the matching variations, discovers each bundle's **image-type
fields** via `entity_field.manager`, and for every image file builds listing + lightbox URLs with
`ImageStyle::buildUrl()` (falling back to `file_url_generator` when the style is missing). Product
title / SKU / price are read from the variation and passed to Twig, which auto-escapes them; the JS
only ever assigns them via `textContent` / element properties (never `innerHTML` of server data).

## Solution docs

- **Advanced masonry block — settings, theming, lightbox, JS behavior** →
  [blocks/advanced-gallery.md](blocks/advanced-gallery.md)
- **Legacy grid block** → [blocks/legacy-gallery.md](blocks/legacy-gallery.md)
