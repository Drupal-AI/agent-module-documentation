# Config Default Responsive SVG Image — agent index

Deepest submodule of **config_default_image** (nested under `config_default_svg_image`). One
formatter, `config_default_responsive_svg_image` ("Responsive image or default responsive image
(SVG compatible)"), = `svg_image_responsive`'s `SvgResponsiveImageFormatter` +
`ConfigDefaultImageFormatterTrait`. Config-deployable default image that is both responsive and
SVG-aware. No own config page, permissions, Drush, or schema (reuses parent `config_default_image`
schema type). Depends on `config_default_svg_image` + `responsive_image` (transitively SVG Image's
responsive submodule).

- **Setup and the shared `default_image` settings keys / render+copy behavior** →
  top-parent doc [../../../../../../2.0.x/agent/configure/formatter.md](../../../../../../2.0.x/agent/configure/formatter.md)

Key facts:
- Formatter id `config_default_responsive_svg_image`, field type `image`, extends
  `Drupal\svg_image_responsive\...\SvgResponsiveImageFormatter`.
- Same `settings.default_image` keys as the top parent; only the base formatter differs
  (responsive + SVG output).
