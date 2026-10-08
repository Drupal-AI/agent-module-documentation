# Theming the formatter

Theme hook `svg_image_field_formatter` (registered in `svg_image_field_theme()`), template
`templates/svg-image-field-formatter.html.twig`. Copy it into your theme to override the
markup wrapping each rendered SVG.

Preprocessing:
- `svg_image_field_preprocess_svg_image_field_formatter()` prepares variables (inline SVG
  content vs `<img>` src, dimensions, alt/title, link).
- `svg_image_field_preprocess_image_style()` adjusts image-style handling for SVGs.
- `svg_image_field_preprocess_media__media_library()` tweaks the media-library preview.

Library `svg_image_field/media_library` (see `svg_image_field.libraries.yml`,
`css/media_library.theme.css`) styles SVG previews in the Media Library and is attached via
`libraries-extend` on `media_library/style` (declared in `svg_image_field.info.yml`).

Inline vs `<img>` output and sanitization are controlled by the formatter settings — see
[configure/field.md](../configure/field.md).
