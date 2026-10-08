<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Twig layout templates

All markup lives in `templates/`. There is **no `hook_theme`** — these are Layout API
layout templates named by each plugin's `template:` key. Classes are emitted through
Drupal's `Attribute` object (`addClass`), which escapes values; region emptiness is
decided with **Twig Real Content** (`is real_content`), and the module forces empty
regions to render inside the Layout Paragraphs builder via a
`content['#drowl_layouts_bs_force_render']` flag set in `hook_preprocess_paragraph`.

## Base grid — `layouts/drowl-layout-grid.html.twig`

Shared parent for every column layout (and, by `extends`, for the row and dynamic
grids). Builds:

- `layout_classes` (`drowl-layout`, `container` when `page-width`),
- `layout_inner_classes` (`drowl-layout__inner`, `container` when `viewport-width-cp`),
- section `classes` (`layout`, `layout--<id>` via `|clean_class`, and `row` for every
  layout except `drowl_layouts_bs_1col`),
- per-region cell classes (`drowl-layout__region`, `drowl-layout__region--<region>`,
  `col`).

It moves any `container--*` modifier class from the section `attributes` onto either the
outer `.drowl-layout` (page-width) or inner `.drowl-layout__inner` (viewport-width-cp)
wrapper. Regions are rendered in three blocks — `layout_region_top`, `layout_columns`
(loops `layout.getRegionNames` minus `top`/`bottom`), `layout_region_bottom` — each
gated by `#drowl_layouts_bs_force_render or … is real_content`.

## `layouts/drowl-layout--row-layout.html.twig`

`extends` the base; empties the top/bottom blocks. Overrides `layout_columns` to put a
single `main` region wrapper with classes `drowl-layout__region--main row` merged with
the section `attributes.class` (so the `row-cols-*` options land on the row), then wraps
each child of `content.main` in a `<div class="col">`. In preview view mode
(`content['#in_preview']`) it renders children without the `.col` wrapper.

## `layouts/drowl-layout--dynamic-content-grid.html.twig`

`extends` the base; empties top/bottom. Renders `content.main` inside a
`dynamic-grid dynamic-grid--<random id>` wrapper and emits a small inline `<style>`
block that sets CSS custom properties (`--dynamic-grid-cell-min/max`,
`--dynamic-grid-behavoir`) plus gutter/alignment modifier classes. **These style
values read `layout_settings.*` keys that are not defined as layout options in this
version** (see the `# TODO: Re-add options` note in `.layout_options.yml` and the
absence of matching config-schema keys), so the guarded branches do not render in
practice. `hook_preprocess_layout` attaches the `drowl_layouts_bs/dynamic_grid` library
for this layout only. Actual grid sizing comes from
`dist/css/drowl_layouts_bs.dynamic_grid.min.css`.

## Component layouts — `layouts/components/`

- `drowl-layout--card.html.twig`: outputs a Bootstrap `.card` (`card--<variant> card--layout`,
  where `layout_variant = content['#settings']['layout_variant']` run through
  `|clean_class`). Regions map to `.card-img`, `.card-body`/`.card-img-overlay` (chosen by
  the `card--card` class), `.card-title`, `.card-subline`, `.card-text`, `.card-buttons`.
  User `settings.extra_classes` are `|split(' ')` and merged into the class list (applied
  via `addClass`).
- `drowl-layout--media-object.html.twig`: `embed`s `drowl_base:media-object` (a theme-
  provided component) with the region render arrays, an optional `media-object--mobile-stacked`
  flag, and the `links` region in a `slot_media_object_links` block. Also merges
  `settings.extra_classes`.

## Page layout — `layouts/page_layouts/drowl-layout--node-detail-default.html.twig`

Fixed node page template (no LayoutOptions form). Wraps regions in
`.entity-layout--node-default`: header (`title` + `subline`), `top`, then `main` +
`main_aside` as `.col-lg-8` / `.col-lg-4` inside `.container-lg .row` (collapsing to a
single container when only one of the two has content), a full-viewport `main_full`, and
`bottom`. Subline presence is checked with `|striptags('<img>')|trim|length`.

## Core override — `layouts/core/layout--onecol.html.twig`

Overrides core's one-column layout to strip its wrapper divs and print `content.content`
directly (comment: avoids the "problematic array structure" of the default layout).

## Settings-preview templates — `templates/settings_preview/*`

`drowl-layouts-settings-preview-{cell-alignment,cell-width,grid-gutter,section-width}.html.twig`
are admin option-preview snippets. They are **not registered via `hook_theme`** in this
module (vestigial alongside the dynamic-grid option removal); the matching admin CSS is
in `scss/admin/drowl_layouts_bs.settings.admin.scss`.
