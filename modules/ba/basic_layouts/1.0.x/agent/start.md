<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Layouts (basic_layouts) — agent index

Five simple column **layout plugins** for Drupal's Layout API / Layout Builder, each with an optional
formatted intro-text region. Version **1.0.9**, core `^9 || ^10 || ^11`, package "Layout Builder".

- **Dependency:** core `layout_discovery` only. No other modules, no libraries, no Composer requires.
- **Layout plugins** (YAML in `basic_layouts.layouts.yml`, all class `\Drupal\basic_layouts\Plugin\Layout\BasicLayout`):
  `one_column`, `one_column_grid` (regions: content), `two_column` (first/second),
  `three_column` (first/second/third), `four_column` (first/second/third/fourth). Category "Basic Layouts".
- **Plugin class:** `src/Plugin/Layout/BasicLayout.php` extends `LayoutDefault`, adds `use_intro_text` +
  `intro` (a `text_format` field rendered via `#type => processed_text`).
- **Config:** object `basic_layouts.settings` with one key `unset_core_layouts` (bool, default TRUE);
  schema in `config/schema/basic_layouts.schema.yml`, install default in `config/install/`.
- **Route/form:** `basic_layouts.basic_layouts_config` → `/admin/config/content/basic-layouts-config`,
  form `src/Form/BasicLayoutsConfig.php`, permission `administer site configuration`. Menu link under
  Config > Content Authoring.
- **Hook:** `basic_layouts_plugin_filter_layout__layout_builder_alter` (in `.module`) unsets core's
  `layout_onecol`/`layout_twocol_section`/`layout_threecol_section`/`layout_fourcol_section` when the flag is on.
- **Assets:** templates in `layouts/*.html.twig`, library `basic_layouts/layout` → `css/styling.css`.
- No permissions provided, no services, no Drush, no entities, no update hooks.

Solution docs:
- [Layout plugins & intro text](plugins/layouts.md)
- [Settings form & core-layout suppression](config/settings.md)

Content-display/layout only. Inner content comes from blocks/fields (respects their access); the module
holds no access-control role of its own.
