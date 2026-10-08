<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig templates & the overrides view

Templates live in `templates/layouts/` (grouped `stacked/`, `unstacked/`, `components/`,
`page_layouts/`, `core/`) plus `templates/settings_preview/`. All Foundation grid classes are set in
these templates, so re-theming for Bootstrap = overriding the Twig.

## Base template

`templates/layouts/drowl-layout-base.html.twig` is the parent most layouts `extends`. It:

- Reads `content['#settings']` into `layout_settings` and builds class arrays from it.
- Maps `layout_section_width` → container classes (`viewport-width`, `grid-container`,
  `viewport-width--<value|clean_class>`), `layout_align_cells_*` → `align-<value|clean_class>` row
  classes, and iterates `layout_remove_grid_gutter` → `<size>-margin-collapse` (also handles a
  `layout_reverse_cell_order` key → `<size>-order-reverse`, though no form sets it).
- Splits `extra_classes` on `,` and merges each into `layout_classes` (emitted through
  `attributes.addClass(...)`, i.e. Drupal `Attribute` — attribute-escaped on render).
- Uses Twig Real Content: pre-renders each region (`content.top|render`) and shows it only when
  `... is real_content` OR `content['#drowl_layouts_force_render']` (the builder-mode flag). This gives
  proper "is this region actually empty?" checks that a plain `if content.top` cannot.
- Defines overridable blocks: `layout_container_opener/closer`, `layout_outer`, `layout_region_top`,
  `layout_regions`, `layout_region_bottom`.

## Column templates

`unstacked/drowl-layout--{1..6}col.html.twig` and `stacked/drowl-layout--{1..6}col-stacked.html.twig`
extend the base and fill `layout_regions`. Each computes per-cell Foundation classes from
`layout_settings.column_widths` (e.g. 2col: `50-50`→`medium-6`, `66-33`→`medium-7`+`large-8`, …) merged
with `default_cell_classes` (`cell small-12`). Region wrappers use `region_attributes.<region>.addClass(...)`.

## Component & page templates

- `components/drowl-layout--card.html.twig` — builds `card` / `card--<layout_variant|clean_class>` /
  `card--layout` classes, regions media/title/subline/contents/links; merges
  `settings.extra_classes|split(' ')` into the card classes (via `addClass`, escaped).
- `components/drowl-layout--media-object.html.twig` — media-left content-right component.
- `page_layouts/drowl-layout--node-detail-default.html.twig` — the full node page layout
  (title/subline/top/main/main_aside/main_full/bottom).
- `core/layout--onecol.html.twig` — a one-column override.

## Dynamic content grid

`unstacked/drowl-layout--dynamic-content-grid.html.twig` renders the single `main` region as a CSS grid.
It generates a per-instance id `dynamic_grid_style_id = random(1,9999999)`, sets classes
`dynamic-grid--<id>` / `dynamic-grid--align-*` / `dynamic-grid--justify-*` /
`dynamic-grid--gutter-<size>|clean_class`, and emits an inline `<style>` block that writes CSS custom
properties `--dynamic-grid-cell-min/max` from `layout_settings.layout_dynamic_grid_col_min_width/_max_width`
(`|trim ~ "px"`) and `--dynamic-grid-behavoir`. The `drowl_layouts/dynamic_grid` library supplies the
grid rules that consume those variables.

## Settings-preview templates

`templates/settings_preview/drowl-layouts-settings-preview-{cell-width,cell-alignment,section-width,grid-gutter}.html.twig`
render the little diagrams shown next to each setting in the layout config form (fed by
`hook_theme`, using `module_images_dir_url` for the bundled SVGs in `img/`).

## Bundled view (`config/optional/`)

`views.view.drowl_layout_builder_overrides.yml` — id `drowl_layout_builder_overrides`, label
"DROWL Admin > Layout Builder Overrides", **`status: false`** (disabled/optional). A `node_field_data`
view intended to list nodes that carry per-entity Layout Builder overrides. Enable and adapt it if you
need to audit overridden layouts; it is not required for the layouts to work.
