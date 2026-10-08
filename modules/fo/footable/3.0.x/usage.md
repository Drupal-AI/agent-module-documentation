FooTable integrates the jQuery FooTable plugin into Drupal as a Views table style, rendering responsive tables that collapse chosen columns into an expandable row at configurable breakpoints, with optional client-side filtering, sorting, and paging.

---

The module adds a Views style plugin, `footable` ("FooTable"), extending core's Table style, plus a `footable` config entity type for named breakpoints (e.g. `xs` 480px, `sm` 768px, `md` 992px, `lg` 1200px, shipped as defaults) managed at `/admin/config/user-interface/footable` (permission `administer footable`). A global settings form (`footable.settings`, route `footable.settings`) chooses the plugin variant (`standalone` vs `bootstrap`) and compression (`minified` vs `source`), which selects one of the asset libraries in `footable.libraries.yml` that load the actual FooTable JS/CSS from `/libraries/footable` (you must download the plugin separately). The `views_view_footable` theme hook (based on `views_view_table`) and `template_preprocess_views_view_footable()` translate the per-view style options into the HTML5 `data-*` attributes FooTable reads: `data-breakpoints` (JSON map of breakpoint→px), per-column `data-breakpoints`/`data-type`/`data-sort-value`/`data-filter-value`, and table-level `data-filtering`, `data-paging`, `data-sorting`, `data-expand-all/first`, etc. The style options let you enable/configure filtering (delay, min chars, placeholder, position, AND/OR space), paging (limit, size, count format, position), sorting, state persistence, an expandable toggle column, and Bootstrap table classes. A reusable `footable` render/form element (extending core Table) is also provided for custom forms/render arrays. All configuration is admin-only (Views UI + the `administer footable` permission); there is no untrusted input path — column data values are `strip_tags`'d before being placed into data attributes.

---

- Turn a Views table into a mobile-responsive table that collapses columns on small screens.
- Hide low-priority columns at a breakpoint and reveal them in an expandable detail row.
- Add client-side instant filtering/search to a Views table without a page reload.
- Enable client-side paging on a Views table with a configurable page size.
- Add client-side column sorting to a Views table.
- Define custom pixel breakpoints (xs/sm/md/lg or your own) for column collapsing.
- Assign specific columns to collapse at specific breakpoints.
- Choose which column carries the expand/collapse toggle (first, last, or none).
- Expand all rows or just the first row by default.
- Apply Bootstrap table styling (striped, bordered, hover, condensed) when using the Bootstrap variant.
- Persist filter/paging/sort state across interactions.
- Serve minified (production) or uncompressed (development) FooTable assets globally.
- Switch between the standalone and Bootstrap builds of the FooTable plugin.
- Present large data tables (reports, catalogs) responsively on phones and tablets.
- Configure filter behavior: min characters, debounce delay, placeholder text, AND/OR matching.
- Set paging count format (e.g. "{CP} of {TP}") and pager position.
- Reuse the `footable` render element in a custom form to get a FooTable-powered table.
- Detect date/numeric/HTML column types automatically for correct sort/filter values.
- Build an admin dashboard listing that stays usable at any viewport width.
- Manage breakpoint definitions centrally and reuse them across multiple views.
