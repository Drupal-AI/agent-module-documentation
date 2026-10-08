<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Secondary Row (views_secondary_row) — agent index

A Views **table style plugin** that splits each result across two `<tr>` rows: the primary row keeps
its columns, and fields you mark for the **"Secondary row"** drop onto a second, full-width row
beneath it (keyed to a chosen column, with optional separator and colspan). Useful for taming a
Views table that has more fields than fit across the screen.

The plugin is `views_secondary_row_table` (title *"Table with fields in secondary row"*), a subclass
of core's Views `Table` style (`Drupal\views_secondary_row\Plugin\views\style\TableSecondaryRow`). It
adds four **per-field** options in the Views UI settings grid — `break2` (the "Secondary row" target
column), `separator2`, `colspan2`, `rowspan1` — stored under `style_options[info][FIELD][…]`. A
preprocess (`views_secondary_row.theme.inc`) doubles the row list (primary rows at even indexes,
secondary at odd), moves `break2` fields into the odd row, omits their header labels, drops empty
secondary rows, then re-sorts. Everything else (click-sort, align, sticky, responsive, caption,
empty text) is inherited from core's table style. Field output comes from Views' normal field render
pipeline (`getField()`), so the same escaping as core's table applies.

- Depends on: `drupal:views` (core Views). No other modules.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Views`. Legacy `version: '8.x-1.4'`.
- **No** routes, permissions, config entities, config schema, services or drush commands. Selected
  and configured entirely in the Views UI.
- Configure route: **none** (`configure` is `null`). Set the display **Format** to this style.
- Theme hooks: `views_secondary_row_view_table` (the output) and
  `views_secondary_row_style_plugin_table` (the Views-UI settings grid).

## What you'd do → where

- **Turn a Views table into two-row layout; the four per-field settings (`break2` / `separator2` /
  `colspan2` / `rowspan1`) and what each does** → [configure/views_secondary_row.md](configure/views_secondary_row.md)
- **Override the output template, understand the row-doubling preprocess, theme hooks, CSS classes,
  and accessibility notes** → [theming/views_secondary_row.md](theming/views_secondary_row.md)

## Key facts (real machine names)

- Style plugin id: `views_secondary_row_table` — `@ViewsStyle`, `theme = "views_secondary_row_view_table"`,
  `display_types = {"normal"}`, class `Drupal\views_secondary_row\Plugin\views\style\TableSecondaryRow`
  extends `Drupal\views\Plugin\views\style\Table`.
- Options added in `defineOptions()`: `break2`, `separator2`, `colspan2` (default `''`), `rowspan1`
  (default `1`). Read per-field as `$this->options['info'][FIELD][...]`.
- `buildOptionsForm()` sets `$form['#theme'] = 'views_secondary_row_style_plugin_table'` and adds the
  `rowspan1` (select 1/2), `break2` (select of field labels + "None"), `separator2` (textfield),
  `colspan2` (textfield) elements per column.
- Preprocess: `template_preprocess_views_secondary_row_view_table()` (builds the doubled rows) and
  `template_preprocess_views_secondary_row_style_plugin_table()` (inserts 4 columns into the settings
  grid), both in `views_secondary_row.theme.inc`, registered by `views_secondary_row_theme()`.
- Templates: `templates/views-secondary-row-view-table.html.twig` (near-copy of core
  `views-view-table.html.twig`) and `templates/views-secondary-row-style-plugin-table.html.twig`.
- Row classes emitted: `views-secondary-row--no-content` + `hidden` on an empty secondary row.
