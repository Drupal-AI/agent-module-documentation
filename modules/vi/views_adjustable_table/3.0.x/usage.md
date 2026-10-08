<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Adjustable Table is a Views style plugin (extending core's Table style) that renders a table whose visible columns can be chosen by the end user at runtime.

---

The `adjustable_table` style adds a per-field **Preselected column** option and a column-selection widget setting (bsmSelect). On init it injects a special exposed filter handler (`at_selection`) into the display and seeds the exposed `columns` input with the preselected fields. When the view runs, `query()` reads the exposed `columns` input, maps the selected `f<n>` keys back to real field handlers, and rebuilds `display_handler->handlers['field']` so only chosen (non-excluded) columns are queried and rendered. If nothing is selected, preselected columns (or the first column) are used. The `SelectionHandler` filter builds the exposed multi-select of column labels and, when bsmSelect is chosen, attaches jQuery UI sortable/draggable libraries plus the module's bsmselect assets; `BsmSelect::preRender()` passes escaped settings to JS.

Operationally this is presentation-only: selected column keys are validated against the view's known field handlers (`array_key_exists`), so unknown input is ignored and no raw values reach the database query. Typical setup: set a table display's Format to "Adjustable table", mark which fields are preselected, choose the bsmSelect widget, and expose the view so visitors get the column picker.

---

- Set a Views table display to the Adjustable table format
- Let visitors choose which columns a table shows
- Mark default (preselected) columns shown on first load
- Fall back to the first column when nothing is selected
- Offer a bsmSelect-based multi-select column picker
- Allow drag-and-drop reordering of chosen columns (sortable)
- Hide empty columns per the underlying Table style options
- Keep responsive-table options from core's Table style
- Build a wide data table users can trim to what they need
- Expose a report view with user-adjustable columns
- Preselect key columns while hiding optional ones by default
- Persist selected columns through the exposed-form input
- Combine adjustable columns with other exposed filters
- Provide a compact mobile view by preselecting few columns
- Exclude specific fields from being selectable columns
- Let admins pick the column-selection widget in the style settings
- Render an admin-configurable column table in the Views UI
- Give end users control over a large tabular dataset's width
