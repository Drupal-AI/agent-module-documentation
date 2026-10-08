<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `slideshow` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_slideshow -y` (requires DROWL Media's `drowl_media_types`).

## What it installs (config/install)
- `paragraphs.paragraphs_type.slideshow` — the bundle.
- `field.storage.paragraph.field_slideshow_ref` (entity reference, target_type `media`) +
  `field.field.paragraph.slideshow.field_slideshow_ref` (required, label 'Slideshow', target bundle
  `slideshow`).
- `field_settings` — shared settings field.
- View display: `field_slideshow_ref` rendered by core **`entity_reference_entity_view`**
  (`view_mode: default`, label hidden, fences); settings + preview placeholder hidden; Layout Builder
  disabled.

## Rendering
The actual slideshow markup/behavior comes from the DROWL Media `slideshow` media type (provided by
`drowl_media_types`), rendered through the core entity view builder. This bundle only references and
places the slideshow; it ships no template of its own.
