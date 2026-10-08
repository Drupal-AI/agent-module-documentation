# Config Default Image — agent index

Field formatter(s) whose default/fallback image is a **VCS-tracked file path stored in config**,
so the default image deploys with `drush cex`/`cim` (unlike core's UUID-based default image). No
admin page (`configure` null), no permissions, no Drush. Provides a config schema for the formatter
settings. Extends core `ImageFormatter`.

- **Formatter settings keys, how to set it up on Manage Display, render/copy behavior** →
  [configure/formatter.md](configure/formatter.md)

Submodules (own docs) — same trait applied to other base formatters:
- `config_default_responsive_image` → [../../modules/config_default_responsive_image/2.0.x/agent/start.md](../../modules/config_default_responsive_image/2.0.x/agent/start.md)
- `config_default_svg_image` → [../../modules/config_default_svg_image/2.0.x/agent/start.md](../../modules/config_default_svg_image/2.0.x/agent/start.md)
  - (nested) `config_default_responsive_svg_image` → [../../modules/config_default_svg_image/modules/config_default_responsive_svg_image/2.0.x/agent/start.md](../../modules/config_default_svg_image/modules/config_default_responsive_svg_image/2.0.x/agent/start.md)

Key facts:
- Formatter id `config_default_image` (label "Image or default image"), field type `image`,
  extends `Drupal\image\...\ImageFormatter` via `ConfigDefaultImageFormatterTrait`.
- Settings live in the `entity_view_display` component under `settings.default_image`
  (schema `config_default_image`): `path`, `use_image_style`, `alt`, `title`, `width`, `height`.
- Fallback rendered only when the field is empty; a runtime `File` (uid 0) is built from `path`.
  With `use_image_style` + a schemeless path, the file is copied to `public://config_default_image/`.
