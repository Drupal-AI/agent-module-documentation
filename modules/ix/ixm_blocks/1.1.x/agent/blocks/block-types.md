<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block types (block_content bundles)

Each component submodule installs its config from `modules/ixm_blocks_<name>/config/optional/`:
a `block_content.type.<bundle>.yml`, the field storages/instances, a Paragraphs
`paragraphs_type.<item>.yml` (for the repeating-row components), and the default
`core.entity_form_display` / `core.entity_view_display`. The template comes from
`modules/ixm_blocks_<name>/templates/block--ixm-blocks-<name>.html.twig`, registered in the
submodule's `hook_theme()`.

Body/rich-text fields are `text_with_summary`. Media is provided by a shared `field_media_element`
(entity reference to Media). Links use core `link` (`field_link` single, or `field_links` multi).

## Per component

### Accordion — `ixm_blocks_accordion`
- Block fields: `body`, `field_entity_reference_paragraph` → **ixm_blocks_accordion_item** (`field_title`, `field_body`).
- Template: Bootstrap 5 accordion; each item is a collapse panel.

### Cards — `ixm_blocks_cards`
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_card** (`field_title`, `field_body`, `field_media_element`, `field_links`) **and** `field_content_reference` (reference to nodes).
- Template renders two loops: custom card Paragraphs, then referenced nodes (image from `field_image`, title links to the node).

### Carousel — `ixm_blocks_carousel`
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_carousel_item** (`field_title`, `field_body`, `field_media_element`).
- Template: Bootstrap carousel with indicators/controls; image via `image_style('large')`.

### CTA Icons — `ixm_blocks_cta_icons`
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_cta_icon_item** (`field_title`, `field_body`, `field_media_element`, `field_link`).
- Template: icon/CTA cards; SVG media is emitted by URL (checks `.svg`), otherwise image style. Each card optionally wrapped in the item link (external → `target="_blank"`).

### Hero — `ixm_blocks_hero` (the only submodule with real PHP)
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_hero_banner** (`field_title`, `field_body`, `field_media_element`, `field_links`).
- `ixm_blocks_hero_preprocess_block__ixm_blocks_hero()` resolves each slide's media into a `#media_items` array: image → desktop/mobile URLs from image styles `hero_banner_desktop` / `hero_banner_mobile`; oEmbed video → YouTube (parses `v=` id, attaches `hero-player` + `drupalSettings.heroPlayer.youtubeId`) or Vimeo (regex id, attaches `hero-vimeo-player`); local video file → direct URL.
- Template uses macros for a bootstrap carousel or a Swiper carousel (`carousel_type`), single-slide fallback, and mute/play controls for video. Libraries: `hero-styles`, `hero-player`, `hero-vimeo-player` (Vimeo API CDN), `hero-swiper` (Swiper 11 CDN).

### Modal — `ixm_blocks_modal`
- Block fields: `body`, `field_modal_trigger` (string). No Paragraph type.
- Template: Bootstrap modal; body rendered as `content.body` and the trigger button label as `content.field_modal_trigger`.

### Ping-Pong — `ixm_blocks_ping_pong`
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_ping_pong_item** (`field_title`, `field_body`, `field_media_element`, `field_links`, `field_ping_pong_options` — a "Reversed" list option).
- Template: alternating image/text rows.

### Statistics — `ixm_blocks_statistics`
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_statistics_item** (`field_title`, `field_prefix_text`, `field_number_integer`, `field_suffix_text`, `field_media_element`, `field_body`, `field_links`).
- Template: count-up numbers (`data-count`) animated by `js/statistics-counter.js` using ScrollMagic 2.0.7 (CDN) + jQuery.animate.

### Table — `ixm_blocks_table`
- Block fields: `body` only. No Paragraph type.
- Template: renders `content` and attaches the Tablesaw 3.1.2 CDN library for a responsive table.

### Tabs — `ixm_blocks_tabs`
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_tab_item** (`field_title`, `field_body`).
- Template: Bootstrap 5 nav-tabs; tab id derived from `field_title.value ~ safe_hash` via `clean_id`.

### Boilerplate — `ixm_blocks_boilerplate` (hidden)
- Block fields: `field_entity_reference_paragraph` → **ixm_blocks_boilerplate** item (`field_title`, `field_body`).
- Exists purely as a copy-paste starting point for adding an eleventh block type.
