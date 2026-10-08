# Color pickr — agent index

A color field type with a Pickr-based JS widget and five swatch/text formatters. No global
config page (`configure` null), no permissions, no config schema, no Drush. Core-only; works on
any fieldable entity via *Manage form display* / *Manage display*.

- **Field type, widget settings (theme, hide_description), and the five formatters — ids, storage, Drush setup** →
  [configure/field.md](configure/field.md)
- **Theme hooks and Twig templates for each swatch shape (override the swatch HTML)** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Field type id: `color_pickr_code` (varchar 256, single `color_pickr` column). Empty = NULL/`''`; a cleared picker stores literal `none`.
- Widget id: `color_pickr_default` (settings: `theme` = classic|monolith|nano, `hide_description` = bool). Bundles Pickr (`js/pickr.min.js`); saves HEXA like `#3F51B5CC`.
- Formatter ids: `color_pickr_default` (text), `color_pickr_square`, `color_pickr_circle`, `color_pickr_hexagon`, `color_pickr_line` (colored `<div>`; value goes into `style="background-color: …"`).
- Note: shape templates emit the stored value into a `style` attribute (Twig-autoescaped).
