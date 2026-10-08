<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Layout: Grid' paragraph type (drowl_paragraphs_bs_type_layout)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_layout -y
```

Enabling pulls in its dependencies (`drupal:media`, `drowl_paragraphs_bs:drowl_paragraphs_bs`, `media_library:media_library`, `fences:fences`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_background_media` (media), `field_resp_imagestyle`, `field_settings` (plus base fields `field_anchor_title`/`field_anchor_id`, `field_bgimage_classes`/`field_bgimage_options`, `field_link`, `field_paragraphs`).

## `.module` (preprocess)

`drowl_paragraphs_bs_type_layout_preprocess_paragraph()` (bundle `layout`) builds `background_media_attributes` and `background_media_overlay_attributes`, sets `has_background_media` from `field_background_media`, moves `bg-media-*` classes to the media wrapper and, when a background media exists, copies `text-bg-*`/`bg-*`/`backdrop-filter-*` classes to the overlay wrapper.

## Template

`templates/paragraph--drowl-paragraphs-bs--layout.html.twig` sets an anchor id/scrollspy from `field_anchor_title`, merges `field_bgimage_classes` (split on spaces) into the container classes, includes `inc/drowl_background_image.html.twig`, renders an optional `.container-overlay-link`, and prints the section children via `content|without('field_background_media', 'field_bgimage_options')`.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
