Responsive Tables Filter adds a text-format filter that makes HTML tables in rich-text fields responsive by attaching the Tablesaw JavaScript library and rewriting `<table>` markup.

---

The module ships a single filter plugin (`filter_responsive_tables_filter`, "Apply responsive behavior to HTML tables.") that you enable per text format on `admin/config/content/formats`. When the filter runs it parses the field's HTML, finds every `<table>` that has a `<thead>`, and adds the `tablesaw` and `tablesaw-<mode>` classes plus `data-tablesaw-mode` / `data-tablesaw-minimap` attributes, marks the header cells (`role="columnheader"`, priority/persist data attributes), and attaches the bundled Tablesaw library (from Filament Group) so tables collapse gracefully on small screens. Three display modes are offered: **stack** (default), **columntoggle**, and **swipe**, chosen either by the filter's default setting (`tablesaw_type`) or per-table by adding a `tablesaw-stack` / `tablesaw-columntoggle` / `tablesaw-swipe` class in the editor. A `tablesaw_persist` setting keeps the first column visible. Tables carrying a `no-tablesaw` class or lacking a `<thead>` are skipped. Separately, a module settings form at `admin/config/content/responsive_tables_filter` can auto-apply Tablesaw to all Views-generated and theme-rendered tables (`views_enabled` + `views_tablesaw_mode`) without touching any text format.

---

- Make tables authored in CKEditor / WYSIWYG body fields responsive on mobile.
- Enable responsive tables on the Basic HTML or Full HTML text format site-wide.
- Collapse wide data tables into stacked key/value rows on narrow viewports (stack mode).
- Let readers toggle which columns are visible on small screens (column-toggle mode).
- Let readers swipe horizontally through columns while pinning the first column (swipe mode).
- Keep the first column persistently visible as a row label while other columns collapse.
- Set a site-wide default responsive mode for all editor tables via the filter settings.
- Override the default mode on a single table by adding a `tablesaw-swipe` class in the editor.
- Opt an individual table out of responsive behavior with a `no-tablesaw` class.
- Automatically make all Views-generated tables responsive without per-view configuration.
- Apply Tablesaw to tables rendered through Drupal's `table` render element theme-wide.
- Choose a different Tablesaw mode for Views tables than for editor tables.
- Improve accessibility of data tables with proper `role="columnheader"` header markup.
- Ship responsive tables without writing any custom CSS or JavaScript.
- Add responsive behavior to imported/migrated HTML content that contains tables.
- Ensure pricing, comparison, or spec tables remain readable on phones.
- Combine with "Limit allowed HTML tags" formats by allowing the required table tags.
- Provide editors a no-code way to control table layout on mobile via CSS classes.
- Set the filter processing order so it runs after tag-stripping filters.
- Give documentation or knowledge-base articles mobile-friendly tables.
- Standardize responsive table behavior across every content type using one text format.
