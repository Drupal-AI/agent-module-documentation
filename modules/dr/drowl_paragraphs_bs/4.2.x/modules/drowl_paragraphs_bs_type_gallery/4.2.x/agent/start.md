<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Gallery (drowl_paragraphs_bs_type_gallery) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `gallery` Paragraph type.

- **Fields**: `field_gallery` (multi-value media image reference), `field_image_zoomable` (PhotoSwipe
  toggle), `field_resp_imagestyle` (responsive image style), shared `field_settings` (hidden).
- **UI Styles** (`.ui_styles.yml`): `gallery_columns_style` — 2/3/4/5/6 columns or Masonry
  (classes `gallery-grid--*`).
- **Template** `paragraph--drowl-paragraphs-bs--gallery.html.twig`: loops `field_gallery` items and
  renders each via the base `inc/flexible_image.html.twig` include (responsive image style, PhotoSwipe).
- **`.module`**: `hook_preprocess_paragraph()` attaches the `global` library and moves `gallery-grid--*`,
  `gap-*`, `img-*`, `ratio*` and `img-wrapper__*` classes onto the correct grid/wrapper attributes.
- Depends on `media`, `media_library`, `media_library_edit`, `fences`, `field_formatter`.

See [paragraphs/gallery.md](paragraphs/gallery.md).
