<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Media Resize — agent index

Drag-resize `<drupal-media>` image embeds in CKEditor 5. The width is stored on the tag as
`data-media-width` and converted to an inline `width:` style (plus an optional
`data-view-mode`) by the **"Resize media images"** text filter. No settings page
(`configure: null`), no permissions, no Drush, no services, no plugin types.

- **Enable it on a text format, filter order, and the `apply_image_styles` setting** →
  [configure/text-format.md](configure/text-format.md)
- **The two plugins it defines (`ckeditor_media_resize_mediaResize`, `filter_resize_media`),
  the shipped image styles, and how markup is transformed** →
  [plugins/resize-pipeline.md](plugins/resize-pipeline.md)

Key facts:
- Filter id **`filter_resize_media`**, weight 90, `TYPE_TRANSFORM_REVERSIBLE`. It **must run
  before** core's `media_embed` ("Embed media") filter, and `filter_html` ("Limit allowed
  HTML tags") must be active.
- CKEditor 5 plugin id **`ckeditor_media_resize_mediaResize`**; config lives in the
  `editor.editor.<format>` entity at `settings.plugins.ckeditor_media_resize_mediaResize`
  with keys `apply_image_styles` (bool, default `TRUE`) and `image_styles` (array, default
  `[cke_media_resize_small, cke_media_resize_medium, cke_media_resize_large,
  cke_media_resize_xl]`).
- Data attribute: **`data-media-width`**; rendered class: **`media-embed-resized`**.
- Ships image styles `cke_media_resize_small|medium|large|xl` (scale to 200/500/800/1200px,
  `upscale: true`) plus matching `media` view modes + `media.image.*` view displays.
