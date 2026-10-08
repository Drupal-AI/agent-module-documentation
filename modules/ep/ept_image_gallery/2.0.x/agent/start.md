<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Image Gallery — agent index

Installs a `ept_image_gallery` Paragraphs type that renders a Media-image gallery with a
GLightbox popup and a per-instance layout style. No global config page (`configure` null), no
permissions, no Drush. Depends on `ept_core`, `glightbox`, `media`, `paragraphs`. Global
color/breakpoint config comes from `ept_core.settings`.

- **The paragraph type, its fields, the Styles widget, GLightbox display + image style, and how
  to add a gallery to content** → [configure/gallery.md](configure/gallery.md)
- **Templates, style CSS classes, and the theme registration** → [theming/templates.md](theming/templates.md)

Key facts:
- Paragraph type `ept_image_gallery`; images field `field_ept_image_gallery` (Media image,
  cardinality -1). Other fields: `field_ept_title`, `field_ept_text`, `field_ept_settings`.
- Widget `ept_settings_image_gallery` adds a `styles` radio (`one_column`…`five_columns`,
  `fixed_size_image`, `fluid_grid`, `featured_images_grid`; default `four_columns`).
- Media view mode `ept_image_gallery` displays `field_media_image` with the `glightbox`
  formatter, image style `ept_gallery_image` (365×265 scale-and-crop), gallery = parent.
- No plugin types defined, no config schema of its own; settings schema is provided by `ept_core`.
