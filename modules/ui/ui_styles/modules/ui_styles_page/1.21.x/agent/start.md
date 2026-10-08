<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles Page — agent index

Applies UI Styles classes to a theme's **regions**. Configured per theme at
`/admin/appearance/regions-styles/{theme}` (`administer themes`); stored in
`<theme>.settings` → `third_party_settings.ui_styles_page.regions.<region>`; merged onto the
region's `attributes` by `PreprocessRegion`.

- **Region styles config path, admin route, and how to set/read a region's styles** →
  [configure/region-styles.md](configure/region-styles.md)

Key fact: `<theme>.settings` (e.g. `olivero.settings`) →
`third_party_settings.ui_styles_page.regions.<region_name>` =
`{selected: {style_id: class}, extra: "classes"}` (constant
`REGION_STYLES_KEY_THEME_SETTINGS = 'third_party_settings.ui_styles_page.regions'`).
Configure route: `ui_styles_page.regions.overview`.
