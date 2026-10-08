<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `gallery` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_gallery -y`.

## What it installs (config/install)
- `paragraphs.paragraphs_type.gallery` — the bundle.
- `field.storage.paragraph.field_gallery` + `field.field.paragraph.gallery.field_gallery` — multi-value
  entity reference to `media` images.
- `field_image_zoomable` (PhotoSwipe toggle), `field_resp_imagestyle` (responsive image style),
  `field_settings` — shared base storages.
- Default form/view displays.

## UI Styles (`drowl_paragraphs_bs_type_gallery.ui_styles.yml`)
`gallery_columns_style` (category 'Gallery'): options `gallery-grid--2-cols` … `gallery-grid--6-cols` and
`gallery-grid--masonry-cols`.

## Template + preprocess
`templates/paragraph--drowl-paragraphs-bs--gallery.html.twig` (registered in `.module` `hook_theme()`)
attaches PhotoSwipe, builds a `.gallery-grid` (adds `photoswipe-gallery` when zoom is on), and for each
`field_gallery` item with a `target_id` includes `@drowl_paragraphs_bs/inc/flexible_image.html.twig` with
`drupal_field('field_media_image', 'media', <target_id>)`, the zoom flag, and the responsive image style
(default `page_width_scale`). The include renders the image via a responsive image style and, when
zoomable, a PhotoSwipe link. `hook_preprocess_paragraph()` attaches the `global` library and redistributes
`gallery-grid--*`/`gap-*` classes to `gallery_attributes` and `img-*`/`ratio*`/`img-wrapper__*` classes to
`image_wrapper_attributes` (via `Attribute` objects).
