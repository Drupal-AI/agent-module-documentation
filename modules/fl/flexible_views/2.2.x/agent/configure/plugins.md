# Configuring the three plugins

All configuration is in the Views UI (`/admin/structure/views`). Typical setup: use the
**Flexible Table** style, add the **Visible Column Selector** filter (exposed), and optionally
switch the exposed form to **Manual selection**.

## Flexible Table (style plugin `flexible_table`)

`src/Plugin/views/style/FlexibleTable.php` — `class FlexibleTable extends core Table`.
- Format → choose "Flexible Table". Inherits all core Table settings and adds a **Visible by
  default** checkbox per column (`options['info'][<field>]['default_visible']`).
- Also honors the standard per-column `sortable`, `default_sort_order`, `align`, `separator`,
  `empty_column`, and `responsive` options.
- Renders through theme hook `views_view_flexible_table` (template
  `templates/views-view-flexible-table.html.twig`); the options form itself is themed via
  `flexible_views_style_plugin_flexible_table`. Preprocessors live in `flexible_views.theme.inc`.

## Visible Column Selector (exposed filter `column_selector`)

`src/Plugin/views/filter/ColumnSelector.php`. Registered by `hook_views_data_alter()` as
`views.column_selector` ("Visible Column Selector"). Add it under **Filter criteria** and
expose it (it forces `exposed = TRUE`; the expose checkbox is disabled — it must be exposed).
- Filter option `wrap_with_details` (default TRUE) wraps the widget in a collapsible `<details>`.
- The exposed widget shows two multi-selects — *Available Columns* / *Selected Columns* — with
  move-left/right/up/down buttons (JS/CSS library `flexible_views/column_selector`). The final
  ordered list of field machine names is written as JSON into the hidden
  `selected_columns_submit_order` textfield.
- On submit the raw `available_columns`/`selected_columns` inputs are discarded
  (`exposedFormValidate`), leaving only the JSON order. That JSON is read back (query string,
  else `$_SESSION['views'][<view>][<display>]['selected_columns_submit_order']`) by the flexible
  table preprocessor to decide which columns render and in what order.
- Field names are always validated against the view's real fields
  (`ColumnSelector::mapSelectedColumnsSubmit()` maps a name → the field's configured label);
  unknown names are dropped. `operations`, `node_bulk_form`,
  `views_bulk_operations_bulk_form` are forced always-visible.
- If `views_field_permissions` is enabled it is invoked so access-hidden fields are excluded
  from the selector.

## Manual selection (exposed form style `manual_selection`)

`src/Plugin/views/exposed_form/ManualSelection.php`. Exposed form → choose "Manual selection".
Lets the user pick which exposed filters to reveal from a select list (keeps a filter-heavy
view tidy); some filters can be configured to always show. `flexible_views_preprocess_pager()`
and `flexible_views_preprocess_views_mini_pager()` then rebuild pager query parameters so only
the exposed filters actually active (present in `getExposedInput()`) are carried into pager
links — when no manual filters are active, all exposed params are stripped from the pager.

## Config schema

`config/schema/flexible_views.style.schema.yml`, `...filter.schema.yml`,
`...exposed_form.schema.yml` define the stored option keys for each plugin (e.g. the per-column
`default_visible`, the filter's `wrap_with_details`). No `config/install` defaults ship; config
lives inside each `views.view.*` entity.
