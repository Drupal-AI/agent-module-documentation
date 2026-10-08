# Custom View Filters — agent index

Registers **three Views filter handlers** on the `node_field_data` table (Views group
"Custom View Filters") via `hook_views_data_alter()`. No settings form, no `configure`
route, no permissions, no config schema, no Drush. All state lives in the View config
entity's filter options. You point each filter at a field by typing its **machine name**.

- **The three filters, their Views handler ids / fields, options, exposed-vs-admin use, and
  Twig printing** → [configure/filters.md](configure/filters.md)

Key facts:
- `custom_az_filter` (Views field `custom_az_filter`) — first-letter match; option `az_field_name`.
- `node_granular_date_filter` (Views field `nodes_granular_dates`) — year/month; option `granular_field_name`.
- `date_range_picker_filter` (Views field `date_range_picker`) — since/until; option `granular_field_name`.
- Special field names: `title` (A‑Z), and `created` / `changed` (date filters) use `node_field_data` directly.
