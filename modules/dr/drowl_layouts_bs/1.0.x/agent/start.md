<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Layouts for Bootstrap (drowl_layouts_bs) — agent index

Provides DROWL's default **Bootstrap-5-grid section layouts** as Layout Discovery
layout plugins, for **Layout Builder** and **Layout Paragraphs**. Package `Layout`.
Version **1.0.15** (version dir `1.0.x`). Core `^10 || ^11`. License GPL-2.0-or-later.

**Dependencies:** core `layout_discovery`, `twig_real_content:twig_real_content`
(`^1`), `layout_options:layout_options` (`^1`). Suggests `drupal/radix`,
`drupal/layout_disable`. Intended for a **Bootstrap 5** theme.

## What it actually is

- **No PHP classes** (`src/` does not exist), **no routes** (`*.routing.yml` does not
  exist), **no services**, **no Drush**, **no `.install`**, **no `hook_theme`**.
  It ships only Twig templates, CSS libraries, one `.module` (a few hooks), and YAML
  (`.layouts.yml`, `.layout_options.yml`, `.permissions.yml`, config schema, one
  optional view).
- It **provides layout instances** (plugins of core's Layout API), not a new plugin
  type. Most layouts use plugin class
  `\Drupal\layout_options\Plugin\Layout\LayoutOptions` (from the Layout Options
  module), so per-section option forms come from Layout Options + this module's
  `drowl_layouts_bs.layout_options.yml` catalog.

## Layouts (`drowl_layouts_bs.layouts.yml`) — see [plugins/layouts.md](plugins/layouts.md)

- Columns: `drowl_layouts_bs_1col`…`_6col` and `_1col_stacked`…`_6col_stacked`
  (stacked adds `top`/`bottom` regions). Template `drowl-layout-grid.html.twig`.
- Components: `drowl_layouts_bs_card` (Card/Tile), `drowl_layouts_bs_media_object`.
- Page: `drowl_layouts_bs_node_detail_default` (title/subline/top/main/main_aside/
  main_full/bottom). Uses the **default** layout class (not LayoutOptions).
- Misc: `drowl_layouts_bs_row_layout` (multi-row `row-cols-*`),
  `drowl_layouts_bs_dynamic_content_grid` (CSS grid; loads `dynamic_grid` library).

## Templates — see [templates/templates.md](templates/templates.md)

Base `drowl-layout-grid.html.twig` (+ `drowl-layout--row-layout`,
`--dynamic-content-grid`, `components/drowl-layout--card`, `--media-object`,
`page_layouts/drowl-layout--node-detail-default`, `core/layout--onecol`). Bootstrap
classes emitted via `Attribute.addClass`; empty regions handled with Twig Real
Content (`is real_content`) + `#drowl_layouts_bs_force_render` in builder mode.

## Options, libraries, hooks, permission — see [config/libraries.md](config/libraries.md)

- Option catalog + config schema (`config/schema/drowl_layouts_bs_layouts.schema.yml`).
- Libraries (`.libraries.yml`): `global`, `dynamic_grid`, `admin`,
  `admin_preview_styles`, `layout_paragraphs_admin`.
- `.module` hooks: `hook_form_alter`, `hook_preprocess_layout_paragraphs_builder`,
  `hook_library_info_alter`, `hook_preprocess_paragraph`, `hook_preprocess_layout`.
- Permission `access drowl_layouts_bs settings` (`restrict access: TRUE`) — declared
  but **no route in this module uses it**.
- Optional disabled view `drowl_layout_builder_overrides` at
  `admin/content/layout-builder-overrides` (perm `configure any layout`).
