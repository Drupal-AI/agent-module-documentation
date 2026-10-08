Flexible Views adds three Core Views plugins — a "Flexible Table" style, a "Visible Column Selector" exposed filter, and a "Manual selection" exposed form — that let end users choose which table columns to show/hide (and reorder them) and pick which exposed filters are visible.

---

The module ships three Views plugins configured entirely in the Views UI (no module settings page, `configure` is null, no permissions). **Flexible Table** (`@ViewsStyle("flexible_table")`, class `FlexibleTable extends core Table`) adds a "Visible by default" checkbox per column and renders via the `views_view_flexible_table` theme hook (template `views-view-flexible-table.html.twig` + preprocessor in `flexible_views.theme.inc`). **Visible Column Selector** (`@ViewsFilter("column_selector")`, exposed via `hook_views_data_alter` under `views.column_selector`) is an exposed filter that renders a two-list "available/selected columns" widget with move buttons; the user's chosen order is submitted as a JSON string in the `selected_columns_submit_order` field and persisted in the query string and `$_SESSION`, and the flexible-table preprocessor reorders/limits columns accordingly. Columns `operations`, `node_bulk_form`, and `views_bulk_operations_bulk_form` are always kept visible. **Manual selection** (`@ViewsExposedForm("manual_selection")`) is an exposed-form style that lets users add exposed filters from a select list so a view with many filters stays clean; `flexible_views_preprocess_pager()` / `_views_mini_pager()` then strip inactive exposed filters from pager links so only the manually-enabled ones persist. Config schema is provided for all three plugins (`config/schema/flexible_views.{style,filter,exposed_form}.schema.yml`). Two JS/CSS libraries (`column_selector`, `manual_selection`) drive the widgets. All column identifiers handled from user input are matched against the view's known field machine names and mapped to the view's configured labels, so there is no free-text sink.

---

- Let site visitors toggle individual table columns on and off in a Views table.
- Provide a "choose your columns" report where users build their own column set.
- Set which columns are visible by default while allowing others to be added on demand.
- Let users reorder table columns via drag/move buttons in the exposed form.
- Keep a wide data table readable by hiding rarely-needed columns by default.
- Persist a user's column choices across pages of the same view via the session.
- Always keep bulk-operation and operations columns visible regardless of user selection.
- Add a "Manual selection" exposed form so a view with many filters shows only chosen filters.
- Let users pick which exposed filters to reveal from a select list to declutter the UI.
- Define always-visible filters alongside optional ones in a manual-selection view.
- Ensure pager links only carry the exposed filters the user actually enabled.
- Build a responsive table that hides low-priority columns on small screens (per-column responsive class).
- Mark columns as sortable with a default sort order in the flexible table style.
- Collapse the column-selector widget inside a details element to save space.
- Hide empty columns automatically with the per-column "Hide empty column" option.
- Give editors a configurable admin listing where they control the visible columns.
- Replace the core Table style with Flexible Table to gain column visibility control.
- Offer a compact default view that power users can expand column-by-column.
- Provide per-column alignment and separators via the flexible table settings.
- Integrate with views_field_permissions so hidden-by-access fields are excluded from the selector.
