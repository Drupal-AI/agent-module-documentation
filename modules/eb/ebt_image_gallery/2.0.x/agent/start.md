<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Image Gallery (ebt_image_gallery) — agent index

Reusable **Image Gallery block content type**. Editors reference Image media, choose a grid
layout, and the images render as a CSS grid that opens full size in a **GLightbox** lightbox.
Part of the Extra Block Types (EBT) family. Version **2.0.0**, core `^10.1 || ^11 || ^12`.

## What it installs
- A `block_content` bundle **`ebt_image_gallery`** with fields:
  - `field_ebt_image_gallery` — entity reference to Image **`media`**, cardinality **-1**,
    **required**, edited with the **Media Library** widget.
  - `body` (text) and `field_ebt_settings` (shared **ebt_core** settings field).
- A custom widget **`ebt_settings_image_gallery`** (extends ebt_core `EbtSettingsDefaultWidget`)
  adding a **Styles** radio set: `one_column`…`five_columns`, `fixed_size_image`, `fluid_grid`,
  `featured_images_grid`. The value becomes a CSS class on the block wrapper.
- Component CSS `css/ebt_image_gallery.css` maps each style class to a grid/flex layout.
- Image style **`ebt_gallery_image`** (scale-and-crop 365×265) + a media view mode
  `ebt_image_gallery` whose display renders `field_media_image` with the **GLightbox** formatter,
  `glightbox_gallery: parent` (all images in the block form one lightbox gallery).

## Dependencies & prerequisites
Requires `ebt_core`, the `glightbox` module, and core `media`. An **Image media type must already
exist** or `ebt_image_gallery_requirements()` blocks installation. GLightbox is vanilla JS (no jQuery).

## Where it can go
It is a **block**, so: placed in a region via Block layout, dropped into a **Layout Builder**
section, or referenced from a field. (Contrast the EPT family, which supplies **paragraph types**
that live inside one page's field.)

## Configuration
- No module-specific settings form and **no permissions of its own** — creating/editing these
  blocks is governed by core block-content / Layout Builder permissions.
- Site-wide colors and Mobile/Tablet/Desktop breakpoints live on the **EBT Core** settings form
  (`/admin/config/content/ebt-core-settings`), shared across the family.
- Per-block **Design options** (spacing, borders, background color/media, container width,
  edge-to-edge) come from ebt_core and are applied as inline `<style>` at render time.
- See `agent/configure/overview.md` and `agent/fields/fields.md`.

## Rendering pipeline (for debugging)
`block--…--ebt-image-gallery.html.twig` (and the inline-block variant) build the wrapper classes,
attach `ebt_image_gallery/ebt_image_gallery`, append the selected **styles** class, render
`content|without('field_ebt_settings')`, and end with `{{ styles|raw }}` — the inline `<style>`
string that ebt_core's `GenerateCSS` builds from the Design options.
