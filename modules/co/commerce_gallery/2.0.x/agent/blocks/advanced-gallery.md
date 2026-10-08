<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced masonry gallery block

`src/Plugin/Block/CommerceAdvancedGalleryBlock.php` —
`@Block(id = "commerce_advanced_gallery", admin_label = "Commerce Gallery (Advanced Masonry)",
category = "Commerce")`, extends `BlockBase implements ContainerFactoryPluginInterface`.

Place it at `/admin/structure/block` ("Commerce Gallery (Advanced Masonry)"). There is **no global
config form** — every option lives in the block instance form. No `access()` override, so it uses
default block access (block visibility conditions); anonymous visitors can see it, and it only ever
exposes **published, access-checked** variations (see Security posture below).

Injected services (`create()`): `entity_type.manager`, `file_url_generator`, `entity_field.manager`.

## build()

1. `buildSections($config)` produces the render sections (see below); if empty, returns a
   `#markup` "Gallery is empty…" message with `#cache max-age 0`.
2. Computes a responsive `breakpoints` array from `cols_desktop/tablet_large/tablet_small/mobile`
   (minWidths 1200/900/600/0).
3. `block_id = 'cg-' . substr(md5(serialize($config)), 0, 8)` — a per-configuration DOM id.
4. Returns `#theme => 'commerce_advanced_gallery'` with `#gallery_sections`, `#heading_text`,
   `#show_filter_bar` (only when enabled AND >1 section), `#filter_labels`, `#layout_mode`,
   `#block_id`, `#settings` (the whole config).
5. `#attached`: library `commerce_gallery/advanced-gallery` and a `drupalSettings.commerceGallery[block_id]`
   object (breakpoints, gap, rowBase 10, layoutMode, hoverEffect, lightboxAnimation, autoplaySpeed,
   enableSwipe, showCounter, accentColor).
6. `#cache`: tags `commerce_product_list`, `commerce_product_variation_list`; contexts `url.path`,
   `url.query_args`. `getCacheMaxAge()` returns **3600**.

## buildSections()

Entity query on `commerce_product_variation`: `->accessCheck(TRUE)->condition('status', 1)`,
optional `type IN (bundles)` (from the `bundles` checkboxes, empty = all types), optional
`sort($sort_field, $sort_dir)` where `sort_field` is whitelisted to `title|sku|created|changed`,
optional `range(0, limit)`. Loads variations, then for each:

- `getImageFields($bundle)` returns every field whose type is `image` (via
  `entity_field.manager->getFieldDefinitions`).
- Section key = bundle id when `group_by_bundle`, else `'all'`; label from
  `commerce_product_variation_type` labels.
- For each image item with a loaded file entity, builds `url` (listing style) and `full_url`
  (lightbox style) via `buildImageUrl()`, plus `title` (variation title), `desc` ("SKU: …" when
  `show_desc`), `sku`, `price` (`Price::__toString()` when `show_price`), `bundle`, and
  `product_url` (`$variation->getProduct()->toUrl()` when `show_product_link`, wrapped in try/catch).
- `limit_per_section` caps items per section.

`buildImageUrl($uri, $style_name)` loads the named `image_style`; if present uses
`$style->buildUrl($uri)`, otherwise `file_url_generator->generateAbsoluteString($uri)`.

## Block settings (blockForm / blockSubmit → config schema `block.settings.commerce_gallery`)

Grouped in `details` fieldsets; `blockSubmit()` flattens them to top-level config keys.

- **General**: `heading_text`, `layout_mode` (masonry|grid|metro), `group_by_bundle`,
  `show_filter_bar`.
- **Data Source & Limits**: `bundles` (checkboxes of variation types), `limit` (0 = unlimited,
  default 24), `limit_per_section` (0 = none), `sort_field` (title|sku|created|changed),
  `sort_direction` (ASC|DESC).
- **Image Styles**: `image_style_listing` (default `medium`), `image_style_lightbox`
  (default `large`) — options from `image_style_options(FALSE)`.
- **Responsive Layout**: `cols_desktop` (4), `cols_tablet_large` (3), `cols_tablet_small` (2),
  `cols_mobile` (1), each 1–8; `gap` px (0–60, default 16).
- **Appearance**: `accent_color` (`#type color`, default `#e60023`), `card_bg_color` (`#ffffff`),
  `bg_color` (`#f0f2f5`), `card_radius` px (0–40, default 16), `hover_effect`
  (lift|zoom|glow|none).
- **Lightbox & UX**: `lightbox_animation` (fade|slide|zoom|flip), `autoplay_speed` ms
  (1000–30000, default 3000), `enable_swipe`, `show_image_counter`.
- **Card Content**: `show_price`, `show_sku`, `show_desc`, `show_product_link`.

## Template & theming (`templates/commerce-advanced-gallery.html.twig`)

Emits an inline `<style>#{{ block_id }}{ --cg-accent/--cg-card-bg/--cg-bg/--cg-radius/--cg-gap }`
block from the admin color/size settings, then a `.commerce-gallery-wrapper` with an optional
filter bar (`role=tablist`), per-section `.gallery-container[data-section-key]`, and per-item
`<article.gallery-item>` carrying `data-index/-section/-full-url/-title/-price/-bundle`, the listing
`<img>`, and a `.content` block (title, desc, sku, price, "View Product" link). A single
`#cg-lightbox` dialog (counter, play/zoom/fullscreen/close buttons, caption, prev/next arrows,
image, price, thumbs strip) is rendered per block instance; the JS dedupes to a singleton. All
dynamic values are printed with Twig `{{ }}` (auto-escaped).

## JS (`js/commerce-advanced-gallery.js`)

`Drupal.behaviors.commerceGalleryMasonry`, once-guarded on `.commerce-gallery-wrapper` and
`#cg-lightbox`. Reads per-block cfg from `drupalSettings.commerceGallery[blockId]`. Builds a
`sectionDataMap` from each item's data attributes / `<img src>`, wires click/Enter on
`.gallery-item` to open the `Lightbox` singleton, runs the `Masonry` layout engine (sets
`--grid-cols` and `grid-row-end` spans per breakpoint; grid mode skips spanning), and drives the
filter bar (toggles `.cg-section-hidden`). The `Lightbox` handles thumbs, keyboard (arrows/Esc/±),
touch swipe, autoplay, and fade/slide/zoom/flip transitions. Server text reaches the DOM only via
`textContent` and element properties (`img.src`, `thumb.alt`), never `innerHTML`.

## Access & rendering notes

The entity query is access-checked (`accessCheck(TRUE)`) and status-filtered, so the block only
surfaces published variations the viewer may already see. There is no custom route/controller/AJAX
and no request-supplied entity id — all data is assembled server-side in `build()`. Dynamic strings
are printed through Twig auto-escaping, and the JS assigns them via `textContent` / element
properties rather than `innerHTML`.
