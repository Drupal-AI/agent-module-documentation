# Icon Select — agent index

Manages SVG icons as **taxonomy terms** (vocabulary `icons`) and exposes them through a visual
field-picker widget, a formatter, and a Twig function, all backed by a generated + sanitized SVG
sprite sheet. No settings route (`configure` = null), no permissions, no config schema of its own.
Depends on `taxonomy`, `field`, `file`, and the `enshrined/svg-sanitize` library.

- **Set up icons: the `icons` vocabulary, its fields, sprite path, and wiring an entity-reference field to the Icon Select widget / SVG Icon formatter** →
  [configure/setup.md](configure/setup.md)
- **Render icons in a theme: the `svg_icon()` Twig function, `icon_select_svg_icon` theme hook, libraries** →
  [theming/twig.md](theming/twig.md)
- **Regenerate the sprite: `drush generate-sprites` + the `SvgSpriteGenerator` API** →
  [drush/generate-sprites.md](drush/generate-sprites.md)

Key facts:
- Vocabulary `icons`; each term has `field_symbol_id` (required, unique string → `<symbol id>`)
  and `field_svg_file` (public file).
- Sprite is written to `public://icons/icon_select_map.svg` (config `icon_select.settings:path`,
  default `icons/icon_select_map.svg`), regenerated on any icon-term insert/update/delete.
- Field widget id `icon_select_widget_default` ("Icon Select"), formatter id
  `icon_select_formatter_default` ("SVG Icon"), both for `entity_reference` fields.
