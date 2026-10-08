<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Image' paragraph type (drowl_paragraphs_bs_type_image)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_image -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `link_attributes:link_attributes`, `drupal:media`, `media_library:media_library`, `media_library_edit:media_library_edit`, `fences:fences`, `field_formatter:field_formatter`, `drowl_media:drowl_media_types`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

image bundle: `field_image` (media), `field_image_zoomable`, `field_link`, `field_resp_imagestyle`, `field_settings` (plus `field_image_shape` from the base). vector_image bundle: `field_vector_image` (media; storage shipped here), `field_link`, `field_settings`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_image_preprocess_paragraph()` (bundles `image` and `vector_image`) builds `image_wrapper_attributes`, moving `img-wrapper__*` classes (prefix stripped) and `img-*`/`ratio*` classes onto the image wrapper instead of the paragraph wrapper.

## Templates

`paragraph--drowl-paragraphs-bs--image.html.twig` wraps `inc/flexible_image.html.twig` in an `.image-wrapper`. `paragraph--drowl-paragraphs-bs--vector-image.html.twig` extends the image template, prints `content.field_vector_image|field_value` and, when a link is set, wraps the rendered SVG in Twig `link()`.

## UI Styles

`drowl_paragraphs_bs_type_image.ui_styles.yml` defines image border, border colour, opacity, width, radius and radius width (all Bootstrap 5 border utilities, `img-wrapper__`-prefixed).

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
