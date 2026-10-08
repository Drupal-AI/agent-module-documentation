<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Carousel (ebt_carousel) — agent index

Ready-made **"EBT Carousel" custom block type** whose slides are media-library images
(plus optional caption and a link that wraps the slide), rendered with the **Tiny Slider**
vanilla-JS library. Part of the Extra Block Types suite, built on `ebt_core`.
Version **2.0.0**. Core `^10.1 || ^11 || ^12`.

## What it installs (config/install)
- **Block content type** `ebt_carousel` ("EBT Carousel") with two fields:
  - `field_ebt_carousel` — entity-reference-revisions to the `ebt_carousel` paragraph (the slides).
  - `field_ebt_settings` — the shared `ebt_settings` field from `ebt_core` (label "Block settings").
- **Paragraph type** `ebt_carousel` ("EBT Carousel item") with three fields:
  - `field_ebt_carousel_image` — **required** entity reference to a `media.type.image` media entity (the slide image).
  - `field_ebt_carousel_caption` — optional `text_long` (slide caption).
  - `field_ebt_carousel_item_link` — optional `link` (wraps the whole slide in an anchor).
- Form/view displays for both bundles. The block's `field_ebt_settings` uses this module's
  **`ebt_settings_carousel`** widget (extends ebt_core's `ebt_settings_default`).

## Mechanism (confirmed from source)
- **Slider library:** Tiny Slider (`levmyshkin/tiny-slider`, `^2.9`), served **locally** from
  `/libraries/tiny-slider/dist` (module `js/tiny-slider/tiny-slider.js` is the Drupal-behavior init
  wrapper). Not a runtime CDN load. Declared in `ebt_carousel.libraries.yml` (`tiny_slider`, `basic`).
- **Per-block options → JS:** the carousel widget sets a hidden `pass_options_to_javascript = TRUE`.
  ebt_core's `EbtCoreHooks::blockContentView()` copies the whole `ebt_settings` array into
  `drupalSettings.ebtCarousel[<blockClass>].options`; the module's JS reads it, builds a Tiny Slider
  `options` object, and calls `tns(options)`. Free-text options are wrapped in `Drupal.checkPlain()`
  before reaching the library; numbers go through `parseInt`.
- **Design options → CSS:** ebt_core's `EbtCoreHooks::preprocessBlock()` calls `GenerateCSS` to turn
  the shared design options (margin/border/padding, colours, background media, edge-to-edge, container
  width) into an inline `<style>` string, printed in the block template as `{{ styles|raw }}`.
- **Image style:** `ebt_carousel_preprocess_paragraph()` overrides each slide image's `#image_style`
  with `ebt_settings['image_size']` when set in the block settings.
- **Templates:** `block--block-content--ebt-carousel`, `block--inline-block--ebt-carousel`,
  `field--block-content--field-ebt-carousel--ebt-carousel` (builds `.ebt-carousel-wrapper.slides` +
  prev/next controls), `paragraph--ebt-carousel--default` (link-wraps the slide image when a link is set).

## Dependencies
`ebt_core`, `paragraphs`, and core `link`, `media`, `media_library`. A `media.type.image` media type
**must already exist** — `hook_requirements()` blocks install otherwise (see human-docs/installation).

## Provides
No permissions, no Drush commands, no config schema of its own (the `ebt_settings` schema lives in
`ebt_core`), no configuration route (global colour/breakpoint defaults are on ebt_core's
`ebt_core.settings` form). One field widget plugin: `EbtSettingsCarouselWidget` (`ebt_settings_carousel`).

## Where to look next
- `agent/blocks/carousel-block.md` — the block type, slide paragraph, fields, and how slides render.
- `agent/config/slider-options.md` — the Tiny Slider option set and shared EBT design options exposed per block.
- `usage.md` — prose overview and use-case list.

## Family note (EBT vs EPT)
EBT **block types** are placeable in regions / Layout Builder / referenced from a field — right for
components that appear on many pages or as site furniture. EPT paragraph types live inside one page's
field. `ebt_carousel` is the block-shaped sibling of `ept_carousel`.
