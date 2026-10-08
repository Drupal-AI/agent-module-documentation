<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout: Seeds Lighthouse

Layout Builder layout plugin, id **`seeds_lighthouse`**, defined in
`seeds_pollination.layouts.yml` and implemented by
`Drupal\seeds_pollination\Plugin\Layout\SeedsLighthouse` (extends core `LayoutDefault`,
implements `PluginFormInterface`). Template `templates/seeds-lighthouse.html.twig`. Category
*Seeds*. Requires core Layout Builder to be enabled to be selectable.

## Regions
28 regions defined in the YAML — twenty full-width rows (`row_1 … row_20`) interleaved with
split rows: halves (`row_3_half_1/2`, `row_8_half_1/2`, `row_13_half_1/2`), 9/3 and 3/9
content+sidebar rows (`row_5_*`, `row_10_*`), and 8+4/three-column rows (`row_6_*`, `row_11_*`).
Bootstrap-style grid classes (`col-sm-6/9/3/8/4`) are baked into the Twig, so it targets a
Bootstrap/Foundation-grid theme.

## Configuration form (`buildConfigurationForm`)
Groups fields under an *Additional settings → Wrapper attributes* details element (`#tree`):
- `wrapper_classes` (textfield) — extra classes on the outermost `<div>`.
- `wrapper_id` (textfield) — id on the outermost `<div>`.
- A `container` / `fluid-container` **select per full-width row** — the plain rows listed by
  `getRows()`: `row_1, row_2, row_4, row_7, row_9, row_12, row_14, row_15, row_16, row_17,
  row_18, row_19, row_20`. `defaultConfiguration()` defaults each to `container`.

`submitConfigurationForm()` flattens `attributes[wrapper_id|wrapper_classes|row_*]` back onto the
top-level configuration; `validateConfigurationForm()` is a no-op.

## Template output
`{{ attributes.setAttribute('id', settings.wrapper_id).addClass(settings.wrapper_classes) }}` on
the root `<div>` (values go through core's `Attribute` object, so they are attribute-escaped), then
each present row renders inside `<div class="{{settings.row_N}}">` (container/fluid-container).
Split/column rows use fixed Bootstrap column classes. A row renders only when its content is
non-empty (`|render is not empty` or `if content.*`).

## Operating it
Select "Seeds Lighthouse" as the layout for a section in Layout Builder, set wrapper id/classes
and per-row container width in the section-configuration modal, then place blocks into the
regions. Container width is purely presentational and depends on the active theme's
`.container`/`.fluid-container` CSS.
