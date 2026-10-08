<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The layout plugins, Layout Options integration & config schema

## Install & enable

```bash
composer require drupal/drowl_layouts_bs
drush en drowl_layouts_bs -y
```

Pulls in core `layout_discovery`, `twig_real_content` and `layout_options`. Nothing
to configure — the layouts appear immediately wherever you pick a section layout
(Layout Builder, Layout Paragraphs). Use a Bootstrap 5 theme (e.g. Radix).

## The layouts (`drowl_layouts_bs.layouts.yml`)

All are declared as Layout API plugins. Every layout except the node page layout sets
`class: '\Drupal\layout_options\Plugin\Layout\LayoutOptions'`, which is what gives
them the extra per-section option form from Layout Options.

| Plugin id | Label | Category | Template | Regions |
|---|---|---|---|---|
| `drowl_layouts_bs_1col` … `_6col` | One … Six column | `[DROWL] Columns: N` | `drowl-layout-grid` | `main` (1col) or `cell_1…cell_N` |
| `drowl_layouts_bs_1col_stacked` … `_6col_stacked` | … (stacked) | `[DROWL] Columns: N` | `drowl-layout-grid` | `top`, `cell_1…cell_N` (or `main`), `bottom` |
| `drowl_layouts_bs_card` | Card (image above content) | `[DROWL] Components` | `components/drowl-layout--card` | `title`, `subline`, `media`, `contents`, `links` |
| `drowl_layouts_bs_media_object` | Media object (media left) | `[DROWL] Components` | `components/drowl-layout--media-object` | same as card |
| `drowl_layouts_bs_node_detail_default` | Node detail default | `[DROWL] Page layouts` | `page_layouts/drowl-layout--node-detail-default` | `title`, `subline`, `top`, `main`, `main_aside`, `main_full`, `bottom` |
| `drowl_layouts_bs_row_layout` | ROW Layout (multi row columns) | `[DROWL] Misc` | `drowl-layout--row-layout` | `main` |
| `drowl_layouts_bs_dynamic_content_grid` | Dynamic Content Grid | `[DROWL] Misc` | `drowl-layout--dynamic-content-grid` | `main` |

Note: `drowl_layouts_bs_node_detail_default` does **not** set the LayoutOptions class,
so it has no extra option form — it is a fixed page template. Each layout also
declares an `icon_map` for the admin thumbnail.

## Option catalog (`drowl_layouts_bs.layout_options.yml`)

Two parts: `layout_option_definitions` (the reusable options) and `layout_options`
(which options apply to which layout, plus per-layout defaults). Options are provided
by Layout Options plugins; every one here just adds Bootstrap CSS classes.

Definitions (`plugin` → Layout Options widget plugin):

- `custom_classes` (`layout_options_class_string`, free text, layout **and** regions) —
  space-separated CSS classes.
- `card_style` (`layout_options_class_select`) — `card--card` / `card--tile`.
- `media_object_mobile_stacked` — `media-object--mobile-stacked` / `--mobile-horizontal`.
- `container_width` (`layout_options_class_radios`, default `viewport-width-cp`) —
  `page-width` / `viewport-width` / `viewport-width-cp`.
- `container_max_width` — `container--width-narrow` / `--width-wide`.
- `flex_align_items` (default `align-items-stretch`), `flex_align_self`
  (regions only, `cell_1…cell_6`), `flex_justify_content` — Bootstrap flex utilities.
- `gutters` / `gutters_horizontal` / `gutters_vertical` — `g-*` / `gx-*` / `gy-*`
  (0–5); `gutters_vertical` default `gy-3`.
- `row_columns` / `_sm` / `_md` / `_lg` — `row-cols[-bp]-1…6` (for ROW Layout).
- `col_xs`, `col_sm`, `col_md`, `col_lg`, `col_xl`, `col_xxl` — per-region
  `col[-bp]-auto|1…12`, restricted to `allowed_regions: [cell_1…cell_6]`.

Each definition sets `layout: true|false` and `regions: true|false` to control where it
appears. (An `offset`/`order` block is present but commented out.)

Per-layout wiring & defaults (`layout_options:` section):

- `global:` lists the options available to every layout by default.
- `drowl_layouts_bs_2col`/`_3col`/`_4col` (+ their `_stacked`) set default column
  widths, e.g. 2col → `col_xs: col-12`, `col_md: col-md-6`; 4col → `col_lg: col-md-3`.
- `drowl_layouts_bs_1col` and `_card` disable the gutter options.
- `drowl_layouts_bs_row_layout` defaults `row_columns: row-cols-2`, `row_columns_md:
  row-cols-md-3`, `row_columns_lg: row-cols-lg-4`.
- `drowl_layouts_bs_media_object` adds `media_object_mobile_stacked`; `_card` adds
  `card_style`; both disable `container_width`.
- 5-column layouts get no width defaults (5/12 is not expressible in Bootstrap grid —
  they auto-size). The dynamic content grid has **no options wired** here (an explicit
  `# TODO: Re-add options for drowl-layout--dynamic-content-grid` marks them removed).

## Config schema (`config/schema/drowl_layouts_bs_layouts.schema.yml`)

Defines `drowl_layouts_bs_layout_options_layout_options` (type
`layout_plugin.settings`) and `drowl_layouts_bs_layout_options_region_options`, whose
members are all typed `layout_options.single_valued_option`. Then a
`layout_plugin.settings.<layout_id>` entry per layout maps that layout's regions to the
region-options type. This is what makes each layout's stored section settings
schema-valid. Because these are `single_valued_option`s backed by fixed `<select>`/
`<radio>` option lists (or `custom_classes`, a class string), stored values are
Bootstrap class tokens, not arbitrary markup.

## How the classes reach the markup

Layout Options stores each chosen class and the layout templates apply them through
Drupal's `Attribute` object — e.g. region widths via `region_attributes[region]` and
layout modifiers via `attributes` — using `.addClass(...)`, which HTML-escapes class
values. Free-text `custom_classes` is likewise added as classes, never printed as raw
markup. See [../templates/templates.md](../templates/templates.md).
