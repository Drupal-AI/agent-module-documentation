<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The EBT Carousel block type

## Structure
An **EBT Carousel** block (`block_content.type.ebt_carousel`) is a custom/inline block with:

| Field | Type | Notes |
|-------|------|-------|
| `field_ebt_carousel` | `entity_reference_revisions` → paragraph `ebt_carousel` | The ordered list of slides. Not required (an empty carousel renders nothing). |
| `field_ebt_settings` | `ebt_settings` (from ebt_core) | Per-block slider + design settings. Uses this module's `ebt_settings_carousel` widget. |

Each slide is an **"EBT Carousel item"** paragraph (`paragraphs.paragraphs_type.ebt_carousel`) with:

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `field_ebt_carousel_image` | entity reference → `media.type.image` | **Yes** (set required in `ebt_carousel_update_9102`) | The slide image, chosen from the media library (`target_bundles: image`). |
| `field_ebt_carousel_caption` | `text_long` | No | Slide caption (formatted long text). |
| `field_ebt_carousel_item_link` | `link` | No | "Use this link to wrap the slide." When set, the whole image becomes a link. |

## How a block is created and placed
1. Create/enable the module — the block type, paragraph type, and fields are installed from `config/install`.
2. Add a block: **Content → Blocks → Add content block → EBT Carousel** (or add it inline in a
   Layout Builder section). Add one or more "EBT Carousel item" slides (image, optional caption,
   optional link).
3. Configure the slider/design under **Block settings** (see `../config/slider-options.md`).
4. Place the block in a region (Block layout) or drop it into a Layout Builder section, or reference
   it from an entity-reference field.

## Rendering pipeline
- **Field template** `field--block-content--field-ebt-carousel--ebt-carousel.html.twig` wraps the
  slides in `<div class="ebt-carousel-wrapper slides">` (one `<div>` per item) and adds
  `.ebt-carousel-controls` with `.ebt-carousel-prev` / `.ebt-carousel-next` hooks. The field wrapper
  also carries the `tiny-slider` class.
- **Paragraph template** `paragraph--ebt-carousel--default.html.twig`: if the slide link is set it
  renders `<a href="{{ content.field_ebt_carousel_item_link.0['#url'] }}">{{ content.field_ebt_carousel_image }}</a>`
  followed by the remaining content (caption); otherwise it prints `{{ content }}`. All slide content
  is rendered through normal Twig autoescaping / field render arrays (caption respects its text format;
  link URL is a validated `Url` object printed in an attribute).
- **Block template** `block--block-content--ebt-carousel.html.twig` (and the `inline-block` variant)
  add classes including `ebt-carousel-<styles>` (styles is always `basic` today), attach the
  `ebt_carousel/basic` and `ebt_carousel/tiny_slider` libraries, print the block content, and finally
  emit `{{ styles|raw }}` — the inline `<style>` produced by ebt_core from the design options.
- **Image style:** `ebt_carousel_preprocess_paragraph()` reads `field_ebt_settings.ebt_settings.image_size`
  from the parent block and, when set, overrides `content.field_ebt_carousel_image[0]['#image_style']`
  so every slide image renders at the chosen image style.

## Initialization
The block sets a hidden `pass_options_to_javascript = TRUE`. ebt_core's `blockContentView` hook then
publishes the settings to `drupalSettings.ebtCarousel[<blockClass>]` (keyed by block revision id and
by a plugin-id/uuid class). The module's `js/tiny-slider/tiny-slider.js` (a `Drupal.behaviors`
implementation) iterates those entries, builds a Tiny Slider `options` object from the stored settings,
targets `.<blockClass> .ebt-carousel-wrapper` as the container, and calls `tns(options)` once per block
(guarded by a `tiny-slider-added` class so it initializes only once).

## The "styles" option
The widget exposes a `styles` radios element with a single value `basic` (disabled — one option for now),
which selects the `ebt_carousel/basic` CSS library and the `.ebt-carousel-basic` class. It is a
predefined-style hook for future style sets, not a free-text field.
