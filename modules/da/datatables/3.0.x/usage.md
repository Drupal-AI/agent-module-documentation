<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DataTables integrates the jQuery DataTables plugin into Drupal Views as a table **style plugin**, turning a normal Views table into an interactive table with client-side pagination, instant search filtering and column sorting.

---

The module adds a Views style plugin (`datatables`, "DataTables") that extends core's Table
style, so you build a view with fields as usual and choose "DataTables" as the display format.
Its `template_preprocess_views_view_datatables()` translates the style's options into a
DataTables initialisation object attached via `drupalSettings` (keyed by the table's unique id)
and loads the `datatables/datatables` + `datatables/datatables_core` libraries; `datatables.js`
then initialises the table in the browser. The style options cover widgets/elements (search
box, table-info line, state saving, TableTools), layout (auto-width, jQuery UI ThemeRoller,
custom `sDom`), pagination (style, length-change selector, page length), per-column settings
(sortable, default sort + order, alignment, separator, hide-empty, responsive), hidden and
expandable columns, and per-column search/filter types. The actual DataTables JavaScript library
is provided either from `/libraries` (installed manually or via Asset Packagist) or from a CDN —
a single setting, `use_cdn` in `datatables.settings` (form at `/admin/config/services/datatables`,
permission "administer site configuration"), switches between them, and a
`hook_requirements()` check reports whether the local library is present. Depends on Views.

---

- Turn any Views table into a searchable, sortable, paginated table without writing JS.
- Add an instant client-side search box above a table of content.
- Let users sort a report table by clicking column headers.
- Provide client-side pagination for a long list already fully loaded on the page.
- Show a "Displaying 1–10 of 57" info line under a table.
- Save a user's table state (search, sort, page length) between reloads.
- Add copy/print/export buttons to a table via the TableTools option.
- Hide selected columns from display while keeping them in the data.
- Use expandable ("child row") columns to reveal extra detail per row on click.
- Set a default sort column and direction for a Views DataTable.
- Combine multiple Views fields into one DataTables column with a separator.
- Control the page-length options and default number of rows shown.
- Choose a full-numbers pagination style or disable DataTables' own pager.
- Right/left/centre-align specific columns.
- Add per-column search inputs and choose their filter type.
- Serve the DataTables library from a CDN instead of hosting it locally.
- Host the DataTables library locally from /libraries for offline/controlled environments.
- Verify the DataTables library is installed via the module's status-report requirement check.
- Enable jQuery UI ThemeRoller styling for the table.
- Present admin data (users, nodes, logs) as an interactive table for site staff.
- Give editors a quick filterable overview of content built entirely in Views.
- Customise the DataTables DOM layout with a custom sDom string.
