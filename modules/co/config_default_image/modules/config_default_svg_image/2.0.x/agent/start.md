# Config Default SVG Image — agent index

Submodule of **config_default_image**. Adds one field formatter, `config_default_svg_image`
("Image or default image (SVG compatible)"), for `image` fields. It is the parent module's
config-deployable default-image behaviour applied on top of the **SVG Image** base formatter, so the
VCS-tracked fallback `path` may point at an `.svg` (or a raster) and is rendered through the
SVG-aware formatter instead of core's plain `<img>`.

No admin page (`configure` null), no permissions, no Drush, and no config schema of its own — it
reuses the parent's `settings.default_image` mapping. Requires `config_default_image` and
`svg_image` (both enabled).

- **Select the SVG formatter on Manage Display + what it changes vs the parent** →
  [configure/formatter.md](configure/formatter.md)
- **Shared `default_image` settings keys + render/copy mechanics (parent doc)** →
  [../../../../2.0.x/agent/configure/formatter.md](../../../../2.0.x/agent/configure/formatter.md)

Nested submodule (own docs) — same trait on the SVG **responsive** base formatter:
- `config_default_responsive_svg_image` →
  [../../modules/config_default_responsive_svg_image/2.0.x/agent/start.md](../../modules/config_default_responsive_svg_image/2.0.x/agent/start.md)

Key facts:
- Formatter id `config_default_svg_image`, field type `image`, quickedit editor `image`.
- Class `Drupal\config_default_svg_image\Plugin\Field\FieldFormatter\ConfigDefaultSvgImageFormatter`
  `extends Drupal\svg_image\Plugin\Field\FieldFormatter\SvgImageFormatter` and
  `use`s the parent's `ConfigDefaultImageFormatterTrait` — it adds **no** code of its own.
- Settings live on the `entity_view_display` component at `settings.default_image`
  (keys `path`, `use_image_style`, `alt`, `title`, `width`, `height`) — identical to the parent.
- Only the base (SVG-aware) formatter differs; all fallback/render/copy logic comes from the trait.
