# The Responsive Tables filter plugin

`src/Plugin/Filter/FilterResponsiveTablesFilter.php`

| Property | Value |
|---|---|
| Plugin id | `filter_responsive_tables_filter` |
| Title | "Apply responsive behavior to HTML tables." |
| Type | `TYPE_TRANSFORM_REVERSIBLE` |
| Provider | `responsive_tables_filter` |

It is an ordinary core filter plugin — you do **not** implement anything; you enable it on a
text format (see [configure/settings.md](../configure/settings.md)).

## Settings (per text format)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `tablesaw_type` | string | `stack` | Default Tablesaw mode. One of `stack`, `columntoggle`, `swipe`. |
| `tablesaw_persist` | boolean | `TRUE` | Keep the first column persistently visible (adds `data-tablesaw-priority="persist"` to the first `<th>`). |

The three modes come from `FilterResponsiveTablesFilter::$modes`:
`stack` → "Stack Mode", `columntoggle` → "Column Toggle Mode", `swipe` → "Swipe Mode".

Config schema key: `filter_settings.filter_responsive_tables_filter`
(`tablesaw_type` string, `tablesaw_persist` boolean). When enabled on a format the filter is
stored under `filter.format.<id>` → `filters.filter_responsive_tables_filter`
(`status: true`, `settings: {tablesaw_type, tablesaw_persist}`).

## How it transforms tables (`process()` → `runFilter()`)

For each `<table>` in the field HTML:

1. **Requires a `<thead>`.** Tables without a `<thead>` are skipped entirely (issue #3244317).
2. **Respects opt-out.** A table whose `class` contains `no-tablesaw` is left untouched.
3. **Adds classes** `tablesaw` and `tablesaw-<mode>` (preserving existing classes) and the
   attributes `data-tablesaw-mode="<mode>"` and `data-tablesaw-minimap=""`.
4. **Per-table mode override.** If the table's existing `class` already contains
   `tablesaw-stack`, `tablesaw-columntoggle`, or `tablesaw-swipe`, that wins over the
   filter's default `tablesaw_type`. So editors override the default per table via a class.
5. **Header cells.** Every `<th>` gets `role="columnheader"`. In `columntoggle`/`swipe`
   modes each `<th>` also gets `data-tablesaw-sortable-col` and an incrementing
   `data-tablesaw-priority`. If `tablesaw_persist` is on, the first `<th>` gets
   `data-tablesaw-priority="persist"`.
6. **Attaches assets.** On any match the result attaches the
   `responsive_tables_filter/tablesaw-filter` library (Tablesaw CSS/JS from Filament Group).

## Editor-facing notes for content authors

- Override mode on one table: add class `tablesaw-swipe` (etc.) to the `<table>` tag.
- Opt a table out: add class `no-tablesaw`.
- The table **must have a `<thead>`** or nothing happens.
- If the format uses "Limit allowed HTML tags", the allowed list must include
  `<table> <thead> <tbody> <tfoot> <tr> <th> <td>` **and** the `class` attribute, and the
  responsive filter must run **after** any tag-stripping filter in the processing order.
