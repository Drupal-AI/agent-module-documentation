<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS Grid (css_grid) — agent index

Adds one **Layout Builder** / Layout Discovery layout plugin, id **`css_grid`**, that renders a
section as a native **CSS Grid**. The layout's configuration form (shown when you add/edit the
section in Layout Builder) lets an editor build up `grid-template-columns` and `grid-template-rows`
as repeatable value+unit rows (units `fr`, `auto`, `max-content`, `min-content`, `minmax`, `%`,
`rem`, `px`) plus a row/column `gap`. On submit the plugin computes `grid_cells = columns × rows`
and dynamically declares that many drop regions (`content_1 … content_N`); on render, `build()`
emits the grid as an inline `style` attribute (`grid-template-columns`/`grid-template-rows`/`gap`)
on a `<section class="css-grid-layout">`.

- Depends on: `drupal:layout_builder`, `drupal:layout_discovery` (both core).
- Core: `^8.8 || ^9 || ^10 || ^11`. Package: none declared. Version 1.0.0-beta8.
- No dedicated settings page / `configure` route, no permissions, no services, no drush, no config
  schema. It does **not** define a new plugin type — it supplies one plugin of core's `Layout` type.
- All configuration is **per Layout Builder section** (the plugin's configuration form). Access is
  gated by core Layout Builder permissions.

## What you'd do → where

- **Add & configure a CSS Grid section (enable Layout Builder, pick the layout, set columns/rows/gap)** →
  [configure/layout-builder.md](configure/layout-builder.md)
- **Understand the plugin internals — config keys, the form, unit handling, cell/region computation,
  the inline-style build, template, library/JS** → [plugins/css-grid-layout.md](plugins/css-grid-layout.md)

## Key facts (real machine names)

- Layout plugin id: **`css_grid`** (defined in `css_grid.layouts.yml`, not an attribute/annotation),
  class `Drupal\css_grid\Plugin\Layout\CssGrid` (extends `LayoutDefault`, implements
  `PluginFormInterface`), category `CSS Grid`, template `css-grid` at
  `templates/layout/css-grid/css-grid.html.twig`, default region `content`.
- Config keys (plugin configuration): `grid_columns` (array of `{value,unit,type}`), `grid_rows`
  (array of `{value,unit,type}`), `grid_gap` (`[0]=row_gap, [1]=column_gap`, each `{value,unit,type}`),
  `grid_cells` (int = columns × rows, computed on submit).
- Theme hook: `css_grid` (`hook_theme()`, `render element => 'children'`). Also `hook_help()` for
  `help.page.css_grid`.
- Library: `css_grid/css_grid` → `css/style.css` (theme bucket), `js/scripts.js`; depends on
  `core/once`. Attached in the config form via `$form['#attached']['library'][]`.
- Rendered wrapper class: `css-grid-layout`; per-region class `layout-inner-content`; regions keyed
  `content_1 … content_{grid_cells}`.
- No routes, services, permissions, or config schema are declared by this module.
