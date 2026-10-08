<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout plugins & settings

All layouts are declared in `drowl_layouts.layouts.yml`. A definition names a `template` (under
`templates/layouts/`) and, if configurable, a `class` in `src/Plugin/Layout/`. Definitions with no
`class` are static (core `LayoutDefault`, no settings form).

## The definitions (id → label / category / class)

Categories `Columns: N`, `Components`, `Page Layouts`, `Misc`.

- `drowl_layouts_{1..6}col` (unstacked) and `drowl_layouts_{1..6}col_stacked` (stacked, adds `top`/`bottom`
  regions). Column count → class: 1col/4col/5col/6col-stacked and all `_stacked` except 2/3 use
  `DrowlLayoutsLayoutDefault`; 2col → `DrowlLayoutsTwoColumnLayout`; 3col → `DrowlLayoutsThreeColumnLayout`;
  4/5/6col (unstacked) → `DrowlLayoutsMultiColumnLayout`.
- `drowl_layouts_node_detail_default` — page layout, **template-only** (no class → not configurable).
  Regions: title, subline, top, main, main_aside, main_full, bottom.
- `drowl_layouts_card` → `DrowlLayoutsCardLayout` (regions title/subline/media/contents/links).
- `drowl_layouts_media_object` → `DrowlLayoutsLayoutDefault`.
- `drowl_layouts_dynamic_content_grid` → `DrowlLayoutsDynamicContentGridLayout` (single `main` region,
  CSS-grid).

## Class hierarchy

- **`DrowlLayoutsSettingsTrait`** — the shared settings. `defaultConfiguration()` seeds
  `layout_section_width='viewport-width-cp'`, `layout_align_cells_vertical='stretch'`,
  `layout_align_cells_horizontal='left'`, `layout_remove_grid_gutter=''`, `extra_classes=''`.
  `buildConfigurationForm()` builds five inputs, each `select` (except `extra_classes` = textfield)
  wrapped in a `container` carrying a live preview (`#theme` = one of the four
  `drowl_layouts_settings_preview_*` themes). Because `#tree` cannot be used here, the widgets are read
  back from the wrapper array in `submitConfigurationForm()`. `validateConfigurationForm()` is empty.
- **`DrowlLayoutsLayoutDefault extends LayoutDefault`** + trait — equal/fixed columns; the config keys
  above with no `column_widths`.
- **`DrowlLayoutsMultiWidthLayoutBase extends`** core `MultiWidthLayoutBase`, `implements
  DrowlLayoutsMultiWidthLayoutInterface`, uses the trait (aliased). Adds `layout_variant='card'` default
  and a `column_widths` select (core), which it moves into a preview wrapper (`#theme
  drowl_layouts_settings_preview_cell_width`, gets `#column_count`) when `getColumnCount()` is not NULL.
  Abstract `getColumnCount()` + `getWidthOptions()` (core).
- **`DrowlLayoutsTwoColumnLayout`** — `columnCount=2`; widths `50-50` / `66-33` / `33-66`; also adds two
  section-width options `viewport-width-column-first` / `-last`.
- **`DrowlLayoutsThreeColumnLayout`** — `columnCount=3`; widths `33-33-33`, `50-25-25`, `25-25-50`,
  `25-50-25`.
- **`DrowlLayoutsMultiColumnLayout`** — for >3 columns; `columnCount=NULL` (special case, so no
  per-column preview); widths `fixed` / `auto` only.
- **`DrowlLayoutsCardLayout extends LayoutDefault`** + trait — adds `layout_variant` select (`card`
  vertical image-above vs. `tile` overlay). (Note: sets a `#field_setting_preview_markup` SVG path via
  `\Drupal::service('extension.path.resolver')`.)
- **`DrowlLayoutsDynamicContentGridLayout extends DrowlLayoutsLayoutDefault`** — adds
  `layout_dynamic_grid_col_min_width` (textfield, px), `_col_max_width` (textfield, px),
  `_gutter_size` (select none/xxs…xxl), `_behavoir` (radios `auto-fit` / `auto-fill`).

## Stored settings keys (per section, in Layout Builder / Layout Paragraphs config)

`layout_section_width` (`page-width` | `viewport-width` | `viewport-width-cp` | 2col-only
`viewport-width-column-first`/`-last`), `layout_align_cells_vertical` (top/middle/bottom/stretch),
`layout_align_cells_horizontal` (left/center/right/justify/spaced), `layout_remove_grid_gutter`
(multi: small/medium/large), `extra_classes` (free text), `column_widths` (per layout, above),
`layout_variant` (card/tile), and the four `layout_dynamic_grid_*` keys. There is **no `*.schema.yml`**
in this module; the settings ride inside the layout section's own config.

## Notes

- `@internal` — the plugin classes are declared internal; don't extend them from other modules.
- Interface `DrowlLayoutsMultiWidthLayoutInterface::getColumnCount()` exists only so the base can drive
  the column-width preview.
- The label of every layout carries the `[DROWL Layouts]` suffix to distinguish it from core layouts.
