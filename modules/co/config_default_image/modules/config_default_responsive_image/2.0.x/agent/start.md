# Config Default Responsive Image — agent index

Submodule of **config_default_image**. One formatter, `config_default_responsive_image`
("Responsive image or default responsive image"), = core `ResponsiveImageFormatter` +
`ConfigDefaultImageFormatterTrait`. Config-deployable default image, rendered responsively. No own
config page, permissions, Drush, or schema (reuses the parent's `config_default_image` schema type).
Depends on `config_default_image` + `responsive_image`.

- **Setup and the shared `default_image` settings keys / render+copy behavior** →
  parent doc [../../../../2.0.x/agent/configure/formatter.md](../../../../2.0.x/agent/configure/formatter.md)

Key facts:
- Formatter id `config_default_responsive_image`, field type `image`, extends
  `Drupal\responsive_image\...\ResponsiveImageFormatter`.
- Same `settings.default_image` keys (`path`, `use_image_style`, `alt`, `title`, `width`,
  `height`) as the parent; the only difference is the base formatter (responsive output).
