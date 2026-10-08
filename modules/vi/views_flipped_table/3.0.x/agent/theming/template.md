# Theming — template & how the flip works

## Theme hook & template

- Theme hook: `views_view_flipped_table` (declared via the plugin's `#[ViewsStyle(theme: ...)]`).
- Template: `templates/views-view-flipped-table.html.twig`.
- Preprocess: `template_preprocess_views_view_flipped_table()` in the `.module`, which calls
  `ViewsFlippedTableThemeHooks::preprocessViewsViewFlippedTable()` (autowired service).

## What the preprocessor does

1. Runs the **core table preprocessor first** (`ViewsThemeHooks::preprocessViewsViewTable()` on
   D11, or the deprecated `template_preprocess_views_view_table()` on D10) so all normal table
   variables (`header`, `rows`, `fields`, `sticky`, `caption`, ...) are populated.
2. Builds `rows_flipped`: iterates the core `rows` and re-keys by **field name**, so
   `rows_flipped[field_name]['columns'][row_index]` — i.e. one row per field, one column per
   result.
3. Sets `first_row_header` from the `flipped_table_header_first_field` option; when TRUE it pulls
   the first field out as `flipped_header` and renders it in `<thead>`/`<th scope>` cells.

## Template variables (beyond core table)

- `rows_flipped` — the transposed matrix (field name → columns keyed by original row index).
- `first_row_header` (bool) — whether the first field is rendered as the header row/column.
- `flipped_header`, `flipped_header_field_name` — the first field promoted to header, when on.
- Plus inherited: `attributes`, `header`, `fields`, `caption`, `caption_needed`, `summary_element`,
  `responsive`, `sticky`, `show_labels`, `title`.

Table classes include `cols-<n>` (column count), and `responsive-enabled` / `sticky-enabled
sticky-header` when those options are set. Override the twig template in your theme to change
markup; there are no CSS assets shipped by the module.
