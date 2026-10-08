<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Views **style plugin** ("Bootstrap Table") that renders a view's fields as an interactive [wenzhixin/bootstrap-table](https://bootstrap-table.com/) grid — client-side search, sort, pagination, column toggle, export/print, card view, sticky header, and more, driven by `data-*` attributes and the bootstrap-table JS loaded from a CDN.

---

The module extends core's Views `Table` style (`Drupal\bootstrap_table\Plugin\views\style\BootstrapTable`, id `bootstraptable`) and ships a dedicated theme (`views_view_bootstraptable`). You choose it under a view display's *Format* and configure a large options form grouped into **Widgets & Elements** (search box, table info, save-state cookie, refresh, column toggle, card view, height, number-format separators, token-supported export file name), **Extensions** (auto-refresh, copy-rows, print, export, filter-control, advanced-search, mobile, group-by, multi-sort, jump-to, reorderable/resizable rows, sticky header, from-URL / defer-URL server-side pagination, locale), **Pagination** (style, length change, page size), **Bootstrap styles** (striped/bordered/hover/condensed) and a **footer Sum** section for numeric columns. `template_preprocess_views_view_bootstraptable()` translates every enabled option into `data-*` attributes on the `<table>` (e.g. `data-search`, `data-pagination`, `data-cookie-id-table`), attaches the matching sub-libraries, and integrates with Views Bulk Operations (adds `data-click-to-select` and the `vbo` library when a VBO bulk-form column is present). The bootstrap-table core JS/CSS and each extension load as **external CDN assets** from `cdn.jsdelivr.net` (declared in `bootstrap_table.libraries.yml`, version 1.27.0). It provides a config schema for the style options; no permissions, routes, services or Drush commands.

---

- Turn any view into a searchable, client-side-sortable Bootstrap table.
- Add an instant client-side search/filter box above a results table.
- Enable per-column sortable headers with remembered sort order.
- Paginate large result sets client-side with a selectable page length.
- Let users toggle which columns are visible (columns toggle-all).
- Export the visible table to file (CSV/Excel/etc.) via the export extension.
- Add a print button for the current table.
- Switch a table to mobile "card view" on small screens.
- Persist a user's table state (filter/sort/pagination) in a cookie across reloads.
- Show a sticky header that stays visible while scrolling long tables.
- Add per-column filter controls (text inputs or select dropdowns by field type).
- Provide an advanced-search modal with regex matching.
- Group rows by a column with the group-by extension.
- Enable multi-column sorting.
- Add a "jump to page" control for very long paginated tables.
- Let users reorder rows or resize columns interactively.
- Sum numeric columns into a table footer with per-field decimal/thousand separators.
- Localize the table UI to a chosen bootstrap-table locale.
- Integrate with Views Bulk Operations: click-to-select rows and copy selected rows.
- Set a fixed table height with internal scrolling.
- Populate the table from a REST/JSON URL (from-URL) or use server-side pagination (defer-URL).
- Customize the exported file name with a token-replaced string.
- Apply Bootstrap table styles (striped, bordered, hover, condensed).
- Give editors a richer data grid without writing any JavaScript.
