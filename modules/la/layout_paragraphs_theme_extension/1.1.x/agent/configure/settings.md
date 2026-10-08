<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the extension

Route/local task: `layout_paragraphs_theme_extension.settings` → `/admin/config/content/layout_paragraphs/default-theme` (permission `administer site configuration`, appears as a "Default Theme" tab under Layout Paragraphs settings).

Config object `layout_paragraphs_theme_extension.settings`:
- `display_default_theme` (bool) — master switch; when off, both hooks no-op.
- `default_theme_library` (string) — a library machine name from the default theme, e.g. `mytheme/layout-paragraphs-editor`, attached to the builder via a trusted pre-render callback.
- `additional_templates` (string, newline-separated) — extra template machine names (e.g. `node__teaser`, a custom block template) to copy from the default theme registry into the builder.

How it works:
1. `hook_theme_registry_alter()` reads `system.theme:default`, builds that theme's registry, and copies `paragraph`, `paragraph__<bundle>` for every paragraph bundle, plus each listed additional template, into the active (admin) theme registry.
2. `hook_element_info_alter()` attaches `default_theme_library` to the `layout_paragraphs_builder` element.

After saving, **rebuild caches** (`drush cr`) for theme-registry changes to apply. Scope your editor CSS with `.lp-builder` so it only affects the builder UI.
