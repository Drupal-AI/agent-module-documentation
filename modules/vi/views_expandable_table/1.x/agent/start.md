<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Expandable Table (views_expandable_table) — agent index

A single **Views style plugin** that renders results as a table whose **last column** is split off
into a hidden, full-width detail row and expanded on click. Package `Views`. Depends only on core
**`views`**. Core requirement `^9.2 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.x
(installed `1.0.0-rc5`). No permissions, no routes, no services, no Drush, no config schema, no
admin settings page — all options live in the view display config.

- **The style plugin, its three options, the preprocess/twig/JS mechanism, and how to enable it** →
  [plugins/expandable_table.md](plugins/expandable_table.md)

## What it actually is

- One plugin: `ExpandableTable` (id **`views_view_expandabletable`**, title *"Expandable Table"*,
  theme `views_view_expandabletable`, `display_types = {"normal"}`), in
  `src/Plugin/views/style/ExpandableTable.php`, **extending core's `Table` style
  (`Drupal\views\Plugin\views\style\Table`)**.
- Adds three options over the core Table style: `triggerable_row` (bool, default TRUE),
  `toggle_location` (`first`/`last`, default `last`), `element_location` (`before`/`after`,
  default `after`). No new plugin *type* is defined.
- Assets: library `views_expandable_table/expandable_table` (`css/views_expandable_table.css`,
  `js/views_expandable_table.js`; deps `core/jquery`, `core/drupal`, `core/once`). Icons in `img/`.

## Mechanism (from source)

- `render()` calls `parent::render()` then attaches the library and
  `drupalSettings.views_expandable_table.triggerable_row`.
- Theme hook preprocess `template_preprocess_views_view_expandabletable()` in
  `views_expandable_table.module` first calls core `template_preprocess_views_view_table()`, then
  for each row: **pops the last column** (`array_pop($row['columns'])`) into `expandable_row`, gives
  it `class="views-expandable-table-target"` + a random `data-...-target` id
  (`Crypt::randomBytesBase64(12)`), and `colspan = count($row['columns'])`. It also drops the last
  header cell (`array_pop($variables['header'])`).
- Trigger placement: if `triggerable_row`, the whole `<tr>` gets `views-expandable-table-trigger` +
  a matching `data-...-trigger` id. Otherwise a `<span class="views-expandable-table-trigger">`
  toggle is inserted into the first/last visible column (skipping the
  `views_bulk_operations_bulk_form` column), before/after the cell content per `element_location`.
- Template `templates/views-view-expandabletable.html.twig` mirrors core's table template and adds
  the extra `<tr>` for `row.expandable_row`. `js/views_expandable_table.js`
  (`Drupal.behaviors.viewsExpandableTable`, via `once`) wires click → toggles the `expanded` class
  on trigger + target, `stopPropagation` on inner `a`/`btn`/`input`, and hover syncing. CSS hides
  `tr[data-...-target]:not(.expanded)` when JS is on.

## Security / access

- The expandable row is the **same Views field output** the normal table would render, just
  relocated — field access and escaping are handled by core Views, not re-implemented here. The
  three options are a checkbox and two fixed selects (no free-text rendered into markup). Row ids
  are random. Nothing user- or request-supplied reaches markup or attributes unescaped.
