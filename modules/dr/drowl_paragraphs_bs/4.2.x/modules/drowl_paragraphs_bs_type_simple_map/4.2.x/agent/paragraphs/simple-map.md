<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `simple_map` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_simple_map -y`.

## What it is
A static, image-based "map": an editor creates a map elsewhere (the `field_image` help text points to
`umap.openstreetmap.fr`), screenshots the desired section, uploads it as a media image, and adds a
copyright caption. This bundle then displays that image with overlay text and a link. **There is no
Google/live maps integration, no API key, and no server-side network call** — the sub-module ships only
a CSS library and a Twig template.

## What it installs (config/install)
- `paragraphs.paragraphs_type.simple_map` — the bundle.
- Field instances: `field_image` (media image), `field_link`, `field_text`, `field_resp_imagestyle`,
  `field_settings` (all binding shared base storages).
- Default form/view displays for those fields.

## Template
`templates/paragraph--drowl-paragraphs-bs--simple-map.html.twig` (registered via `hook_theme()`):
- Includes `@drowl_paragraphs_bs/inc/flexible_image.html.twig` with `content.field_image.0.field_media_image`,
  `image_is_zoomable: true`, the selected responsive image style, and `image_shape`.
- Reads the media's `field_image_caption` with `drupal_field('field_image_caption', 'media', <id>)` and
  prints it (rendered field output, escaped).
- Prints `content.field_link` and the remaining content (`content|without('field_image','field_link')`)
  inside a `.simple-map-overlay`.

## `.module`
`hook_preprocess_paragraph()` attaches `drowl_paragraphs_bs_type_simple_map/global` (CSS only) for
`simple_map` paragraphs; `hook_theme()` registers the template.
