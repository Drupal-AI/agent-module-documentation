<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Sections Config — agent index

Adds fields to Layout Builder's **Configure section** form: show the section's admin title to
end users (with wrapper/position/colour), plus a custom HTML **ID** and **CSS classes** for the
section. Depends on `layout_builder`. No permissions of its own (global settings gated by core
`administer site configuration`), no plugins, no Drush.

- **Global settings: the wrapper/position/colour option lists and where they live** →
  [configure/global-options.md](configure/global-options.md)
- **Per-section fields, where they are stored, and how they render (preprocess_layout)** →
  [configure/section-settings.md](configure/section-settings.md)
- **The layout template overrides it ships and how to port them into your theme** →
  [theming/layout-templates.md](theming/layout-templates.md)

Key facts:
- `configure` route: `layout_builder_sections_config.settings` at
  `/admin/config/content/layout-builder-sections-config` (permission `administer site
  configuration`).
- Global config `layout_builder_sections_config.settings` has 3 string keys, each a
  newline-separated `key|Label` list: `title_wrappers`, `title_positions`, `title_colors`.
- Per-section values are stored **inside the section's own layout configuration** under the
  key `layout_builder_sections_config` (`show_admin_title`, `title_wrapper`, `title_position`,
  `title_color`, `section_id`, `section_classes`), not in a global config object.
