Views Flipped Table adds a Views **display style** ("Flipped Table") that transposes a normal Views table so each result becomes a *column* and each field becomes a *row* - handy for side-by-side comparisons.

---

The module provides a single Views style plugin, `flipped_table` (`FlippedTable`), which extends core's `Table` style and reuses all of its field/sort/caption handling. At render time `template_preprocess_views_view_flipped_table()` (delegating to `ViewsFlippedTableThemeHooks`) first runs core's table preprocessor, then **flips the matrix**: it builds `rows_flipped` keyed by field name so every field's values line up in one row and each original result row becomes a column. It adds one extra style option, `flipped_table_header_first_field` (default TRUE, "Show the first field as the table header"), which renders the first field's flipped row inside `<th>` header cells. Output uses the dedicated template `views-view-flipped-table.html.twig` (theme hook `views_view_flipped_table`). Because it subclasses the core Table style, the usual per-column settings still exist, except row-class options are hidden (they don't translate cleanly once flipped). The module has no admin settings, no permissions, no Drush, and no config of its own - you select it as the Format on any view. A `post_update` hook normalises older integer option values to booleans.

---

- Build a product comparison table where each product is a column and each attribute a row.
- Show a "spec sheet" view with fields down the left and items across the top.
- Compare pricing plans side by side (features as rows, plans as columns).
- Present survey questions as rows and respondents as columns.
- Display a small dataset transposed so long field lists read vertically.
- Turn a normal Views table into a flipped layout by only changing the Format.
- Keep core Table features (sortable columns, caption, sticky header) while flipped.
- Render the first field (e.g. an attribute name) as a row-header column with `<th>` cells.
- Toggle whether the first field acts as the table header via one checkbox.
- Compare a handful of nodes field-by-field on a landing page.
- Show team members as columns with their skills/roles as rows.
- Create a nutrition/ingredients matrix with items across the top.
- Present event sessions as columns and time-slot details as rows.
- Build a feature matrix for a docs page from taxonomy-tagged content.
- Display translated field labels down the side for a compact comparison.
- Reuse an existing view's fields but flip orientation for a wide-screen layout.
- Provide a responsive comparison grid that reads better than a tall table.
- Show configuration or settings entities as columns for at-a-glance diffing.
- Compare two revisions/items across many fields in one flipped table.
- Give editors a no-code way to transpose any tabular view.
- Render a "vs" table (A vs B) from a two-row view result.
- Present statistics with metrics as rows and periods as columns.
