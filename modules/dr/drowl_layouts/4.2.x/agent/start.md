<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Layouts (drowl_layouts) — agent index

ZURB Foundation (XY-Grid) based **section layouts** exposed as Layout API / Layout Discovery
plugins for **Layout Builder** and **Layout Paragraphs**. Package `Layout`. Core
`^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version 4.2.18.

- **The layout plugins** (`.layouts.yml` definitions + PHP classes + per-section width/alignment/gutter settings) → [plugins/layouts.md](plugins/layouts.md)
- **The settings page, permission, route, menu link, libraries and module hooks** → [config/settings.md](config/settings.md)
- **The Twig templates and the bundled overrides view** → [theming/templates.md](theming/templates.md)

## Dependencies

- `drupal:layout_discovery`, `drupal:layout_builder` (core) — the layout plugin system.
- `twig_real_content:twig_real_content` (contrib, composer `drupal/twig_real_content`) — provides
  the Twig `is real_content` test the templates use to decide whether a region is genuinely empty.
- Suggests `drupal/foundation_sites` (a Foundation 6 theme is expected for the shipped grid classes).
- `drowl_layouts.install`: `hook_update_8401` hard-fails updates until `twig_real_content` is enabled.

## What it provides

- **17 layout plugins** in `drowl_layouts.layouts.yml` (some declare a `class`, some use only a
  template): column layouts `drowl_layouts_{1..6}col` and `..._{1..6}col_stacked`, page layout
  `drowl_layouts_node_detail_default`, components `drowl_layouts_card` / `drowl_layouts_media_object`,
  and `drowl_layouts_dynamic_content_grid`. No new plugin *type* — these are Layout plugin instances.
- **1 permission** — `access drowl_layouts settings` (`restrict access: TRUE`), in
  `drowl_layouts.permissions.yml`.
- **1 route** — `drowl_layouts_settings` → `GET /admin/config/system/drowl-layouts`
  (`_form: DrowlLayoutsSettingsForm`), plus a menu link under `system.admin_config_content`.
  The form is currently **empty** (placeholder `ConfigFormBase`, no editable config).
- **5 asset libraries** (`drowl_layouts.libraries.yml`): `global`, `dynamic_grid`, `admin`,
  `admin_preview_styles`, `layout_paragraphs_admin`.
- **1 disabled view** (`config/optional/views.view.drowl_layout_builder_overrides.yml`).
- Hooks in `drowl_layouts.module`: `form_alter`, `library_info_alter`, `theme` (4 settings-preview
  templates), `preprocess_paragraph`, `preprocess_layout`.
- **No config schema**, no Drush commands, no services, no content entities.

## Layout settings model (shared)

Configurable layouts use `DrowlLayoutsSettingsTrait` (`src/Plugin/Layout/`), which adds these keys to
the section's stored layout config (via `defaultConfiguration()` / `buildConfigurationForm()` /
`submitConfigurationForm()`): `layout_section_width`, `layout_align_cells_vertical`,
`layout_align_cells_horizontal`, `layout_remove_grid_gutter` (multi), `extra_classes`. Multi-width
layouts add `column_widths` + `layout_variant`; the Dynamic Content Grid adds
`layout_dynamic_grid_col_min_width` / `_max_width` / `_gutter_size` / `_behavoir`. Values are read in
the Twig templates and turned into Foundation grid CSS classes. See
[plugins/layouts.md](plugins/layouts.md).
