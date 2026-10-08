<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering & the JS library (mechanism)

## What the formatter emits

`MagnificPopup::viewElements()` (extends core `ImageFormatterBase`) themes each field item as a
core `#theme => 'image_formatter'` with:

- `#image_style` = the `thumbnail_image_style` setting (thumbnail rendering),
- `#url` = the file URL generated at `popup_image_style` (what the lightbox opens),
- `#item_attributes` gets class `mfp-thumbnail`; for `gallery_type === 'first_item'` every item
  after the first also gets `visually-hidden`,
- `#attached` library `magnific_popup/magnific_popup`.

`MagnificPopup::view()` wraps the whole field with classes `mfp-field` and
`mfp-<gallery_type>` (via `Html::cleanCssIdentifier`) and a `data-vertical-fit` attribute equal
to the `vertical_fit` setting. The bundled `js/magnific-popup.js` reads those hooks to
initialise the lightbox.

## The library and its install path

`magnific_popup.libraries.yml` defines two libraries:

- `magnific_popup` — the module glue JS (`js/magnific-popup.js`) plus the vendor library at
  `/libraries/magnific-popup/dist/jquery.magnific-popup.min.js` and
  `/libraries/magnific-popup/dist/magnific-popup.css`; depends on `core/drupal`, `core/jquery`,
  `core/once`.
- `video_embed_field` — extra JS/CSS for the video formatter.

So the vendor library must be placed at **`web/libraries/magnific-popup/dist/…`**. For older
installs that put the files at the flat path `web/libraries/magnific-popup/jquery.magnific-popup.min.js`,
`hook_library_info_alter()` (`_magnific_popup_use_legacy_path()`) rewrites the library paths
automatically — you do not need to configure which layout you have.

## Video Embed Field formatter

`video_embed_field_magnific_popup` (`VideoEmbedField`) composes two inner formatters — a
thumbnail formatter and a video formatter — and renders the thumbnail linking to the embedded
video opened in the popup. It is only registered/usable when the `video_embed_field` module is
present, since it targets the `video_embed_field` field type.

## Things an agent should know

- No server-side configuration beyond the per-component formatter settings; behavior is
  front-end.
- If the popup does nothing in the browser, the usual cause is the missing vendor library under
  `web/libraries/magnific-popup`.
- `vertical_fit` is stored as the string `'true'`/`'false'`, not a boolean.
