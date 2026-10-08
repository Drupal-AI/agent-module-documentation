<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Image in Text' paragraph type (drowl_paragraphs_bs_type_image_text)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_image_text -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `link_attributes:link_attributes`, `drupal:media`, `media_library:media_library`, `media_library_edit:media_library_edit`, `fences:fences`, `field_formatter:field_formatter`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_image` (media), `field_image_clip_path` (string_long; storage shipped here), `field_image_zoomable`, `field_link`, `field_resp_imagestyle`, `field_text`, and `field_settings`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_image_text_preprocess_paragraph()` (bundle `image_text`) builds `image_wrapper_attributes`, moving `img-wrapper__*` (prefix stripped) and `img-*`/`float-*`/`ratio*`/`w-*` classes onto the image wrapper.

## Template

`templates/paragraph--drowl-paragraphs-bs--image-text.html.twig` adds `clearfix`, computes responsive float classes (`float-md-start`/`float-md-end`, `me-md-3`/`ms-md-3`), includes `inc/flexible_image.html.twig` in the `.image-wrapper`, and prints `content.field_text|field_value` so text flows around the image. When `field_image_clip_path` is set the paragraph applies an optional CSS clip-path shape (with a matching `shape-outside`) so text wraps the shaped image.

## UI Styles

`drowl_paragraphs_bs_type_image_text.ui_styles.yml` defines the media alignment (`float-start` / `float-end`).

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
