# FooTable — Views style options & emitted data attributes

Style plugin `src/Plugin/views/style/FooTable.php`, id `footable`, title "FooTable", extends the core
`Table` style (so column/sort setup is the standard Views table UI, minus `sticky`). Select it as the
view's Format; its extra options live under `options['footable']`.

## Style options (`defineOptions()` defaults)
Top level:
- `expand_all` (bool, F), `expand_first` (bool, F) — expand all / first detail rows.
- `show_header` (bool, T), `show_toggle` (bool, T) — show header / an expand toggle column.
- `toggle_column` (string, `first`) — which column carries the toggle.
- `use_parent_width` (bool, F).
- `breakpoint[<column>]` — per-column set of breakpoint ids (or `all`) at which the column collapses.

`bootstrap` (applied only when global `plugin_type === bootstrap`): `striped`, `bordered`, `hover`,
`condensed` (bools) → add `table-striped/bordered/hover/condensed` classes.

`component`:
- `filtering`: `enabled` (F), `delay` (1200), `exact_match` (F), `focus` (T), `ignore_case` (T),
  `min` (1), `placeholder` ("Search"), `position` ("right"), `space` ("AND").
- `sorting`: `enabled` (F).
- `paging`: `enabled` (F), `countformat` ("{CP} of {TP}"), `current` (1), `limit` (5),
  `position` ("center"), `size` (10).
- `state`: `enabled` (F), plus `filtering`/`paging`/`sorting` sub-toggles (T).

## What preprocess emits (`template_preprocess_views_view_footable()`)
Theme hook `views_view_footable` (base hook `views_view_table`, adds
`template_preprocess_views_view_footable`). It:
- Sets each header's `data-type` = `date` (datetime field), `numeric` (numeric last render), `html`
  (render contains tags), else `text`.
- Adds per-column `data-breakpoints` = space-joined breakpoint ids (or `all`).
- When sorting enabled: sets header content to `Html::escape($field_handler->label())`, drops the
  Views sort URL/indicator, and marks `data-sortable=false` for non-sortable columns; sets
  `data-sorted`/`data-direction` for the default sort column.
- When filtering or sorting enabled and a column is `html`/`date`: computes a `strip_tags`'d value
  from the field's `#markup` and stores it as `data-filter-value` / `data-sort-value` on the cell.
- Table-level attributes: class `footable`; `data-expand-all`, `data-expand-first`,
  `data-show-header`, `data-toggle-column`; when filtering on → `data-filtering` plus
  `data-filter-delay/min/placeholder/position/space`; when paging on → `data-paging` plus
  `data-paging-count-format/current/limit/position/size`; when sorting on → `data-sorting`.
- `data-breakpoints` = `Json::encode()` of ALL `footable_breakpoint` entities (id → px).
- Attaches libraries `footable/footable` and `footable/footable_<type>_<compression>`.

## Notes
- All option values are set by a user with Views admin rights (trusted config). Cell values pulled
  from rendered field output are `strip_tags`'d before landing in `data-*` attributes; there is no
  untrusted-input sink here.
- `footable_preprocess_views_ui_style_plugin_table()` tweaks the Views UI columns table (removes the
  responsive column) when editing a FooTable view.
