<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Responsive Table adds a custom "Responsive Table" toolbar button to CKEditor 5 that inserts accessible tables which collapse (stack) gracefully on narrow screens, unlike core's built-in table button.

---

The module registers a CKEditor 5 plugin (`ckeditor_responsive_table.ckeditor5.yml`, plugin group `ckeditor_responsive_table_custom`) that adds the `customTable` toolbar item — a "Responsive Table" button whose insert dialog lets an editor set the number of Rows and Columns, choose Headers, add a Caption, and toggle "Caption Visible?". Once inserted, the usual CKEditor table controls (insert/delete/split/merge rows and columns, toggle caption) are available. You enable it per text format by dragging the button into the Active toolbar on the format's CKEditor 5 configuration (`/admin/config/content/formats`), which stores `customTable` in that editor's `settings.toolbar.items`. On the front end the module attaches a small library (`responsive_table_display`, backed by the bundled `tabled` JS/CSS) via `hook_page_attachments()` on all non-admin routes; it passes runtime settings to JavaScript from `ckeditor_responsive_table.settings` — `table_selector`, `fail_class` (default `tabled--stacked`), `caption_side` (`top`/`bottom`), and the `large_character_threshold` / `small_character_threshold` cell-width thresholds — each falling back to a shipped `default_*` value when unset. A separate admin settings form (route `ckeditor_responsive_table.form` at `/admin/config/content/ckeditor-responsive-table`, permission `administer site configuration`) writes those runtime keys. Note the module's `info.yml` does not declare a `configure` route, so `configure` is `null` even though the settings form exists. Only `table_selector` is covered by config schema.

---

- Give editors a table button that produces mobile-friendly tables that stack on small screens.
- Replace core's non-responsive CKEditor table button on a chosen text format.
- Insert an accessible data table with a caption and header row from the WYSIWYG toolbar.
- Let editors set rows, columns, header placement, and caption visibility when creating a table.
- Add a visible or hidden caption to a table for accessibility without editing HTML.
- Enable responsive tables only on the Basic HTML format while leaving Full HTML unchanged.
- Merge and split table cells, insert and delete rows/columns from the editor after insertion.
- Configure which front-end tables the responsive script targets via the `table_selector` CSS selector.
- Change the CSS class applied to non-conforming tables via the `fail_class` setting (default `tabled--stacked`).
- Place table captions at the top or bottom of the table site-wide via `caption_side`.
- Tune when a cell is treated as "large" or "small" via the character-threshold settings.
- Provide `data-label` driven stacked tables on the front end using the bundled `tabled` library.
- Keep tables readable on phones without writing custom responsive-table CSS.
- Standardise table markup (`<table>`, `<thead>`, `<caption>`, scope/`data-label` attributes) across content.
- Add the Responsive Table button to a custom text format used by a specific content type.
- Ensure the responsive script loads on public pages but not on admin routes.
- Give a marketing/editorial team a one-click responsive table without developer involvement.
- Migrate existing content editors from the plain table button to the responsive one per format.
- Configure the module's front-end behavior from `/admin/config/content/ckeditor-responsive-table`.
- Export the `customTable` toolbar configuration as part of a text-format config for deployment.
- Keep table styling consistent by relying on the shipped `responsiveTableStyles.css` library.
