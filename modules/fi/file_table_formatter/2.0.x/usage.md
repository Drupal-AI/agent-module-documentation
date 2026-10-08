File Table Formatter is a field formatter that reads an uploaded CSV file and renders its rows as an HTML table on the entity display, instead of showing a download link.

---

Core's generic file formatter shows a file field as a link; File Table Formatter instead parses the referenced file (currently only files with the `text/csv` MIME type) and displays its rows as a real HTML `<table>` on the rendered entity. This lets an editor keep tabular data — a price list, a schedule, a roster, a small dataset — in a spreadsheet they upload and re-upload as it changes, without importing it into nodes or another entity type. The formatter applies to core **file** fields (`field_types = {"file"}`), is selected per view-display under *Manage display*, and has three settings: treat the first CSV row as a header row, optionally run each cell through a chosen text format (otherwise cells are plain text), and — via the file field's own *Description* — give each table a title. It targets Drupal `^8 || ^9 || ^10 || ^11` (version 2.0.2) and depends only on core `file`. Non-CSV files, or a field with no uploaded file, simply render an empty table for that item. Multi-value file fields render one table per file. The Drupal 8+ rewrite does not include the old Drupal 7 DataTables client-side sorting integration.

---

- Display an uploaded price list CSV as a table on a product or landing page.
- Show a weekly schedule or timetable that editors maintain in a spreadsheet.
- Render a small dataset inline without building a content type for its rows.
- Publish a team roster or contact list from a CSV file.
- Show a comparison or specification table sourced from a spreadsheet export.
- Let editors update on-page tabular data by re-uploading a CSV, no code deploy.
- Present event or session listings exported from a calendar tool as CSV.
- Display survey or poll result summaries from a CSV export.
- Show inventory or stock listings maintained outside Drupal.
- Render a fee or tariff schedule that changes periodically.
- Display a glossary or terminology list from a two-column CSV.
- Show nutritional or ingredient tables uploaded as CSV.
- Present sports fixtures or league standings from a spreadsheet.
- Render a CSV of downloadable resources with a header row for column labels.
- Give each rendered table a heading by filling in the file field's Description.
- Apply a text format to cells so links or basic markup in the data are processed.
- Show a first-row header formatted as table `<th>` cells for accessibility.
- Display multiple CSV files on one entity as separate stacked tables.
- Replace a hand-maintained HTML table in body text with a data-driven CSV table.
- Show reference data (country codes, tax rates) sourced from a maintained CSV.
