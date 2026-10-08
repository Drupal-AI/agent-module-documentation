Big Data Table lets an administrator upload a CSV file, pre-render it into a static HTML table, and publish it at a themed page where jQuery DataTables provides client-side sorting, searching, paging, and export.

---

Big Data Table is a config-entity module built for displaying large tabular datasets efficiently. An administrator creates a `big_datatable` configuration entity, uploads a CSV file, and clicks "Generate HTML" (or runs a Drush command); the module parses the CSV once and writes a finished HTML `<table>` to `public://big_data_tables/<id>.html`. Each entity gets a public view page at `/big-data-table/{id}` (with an admin-defined URL alias) that reads back that pre-generated HTML, wraps it with a title and description, and attaches a bundled DataTables library. Because the heavy CSV-to-HTML conversion happens at save time rather than on every request, page loads stay fast even for very large tables, while DataTables handles interactive sort/filter/export entirely in the browser. Management lives under Configuration → Content Authoring; all create/edit/delete operations require the `administer big_datatable` permission, and the public view page requires only `access content`.

---

- Publish a large product catalog or price list as a searchable, sortable table without building a View.
- Turn a research dataset exported as CSV into an interactive on-site table.
- Display an employee or member directory imported from a spreadsheet.
- Present inventory or stock data that editors maintain in Excel and export to CSV.
- Show financial or reporting figures with column-by-column filtering.
- Offer visitors CSV, Excel, PDF, copy, and print exports of a dataset via the DataTables buttons.
- Give each dataset its own friendly URL alias (for example `/price-list`) instead of an internal path.
- Add an introductory title and rich-text description above a data table.
- Serve very large tables quickly by pre-generating the HTML once at upload time.
- Regenerate all table HTML in bulk from the command line with `drush bigdata-generate-html`.
- Refresh a table's HTML after replacing its source CSV file by re-running "Generate HTML".
- Provide a mobile-friendly "Sort by" dropdown for choosing the sort column on small screens.
- Let visitors change page length (10/25/50/100/all rows) on the fly.
- Enable per-column footer search boxes for narrowing results within a single column.
- Highlight matched search terms within the table via the DataTables mark feature.
- Maintain multiple independent data tables, each as its own configuration entity.
- Export configuration entities across environments (the table definitions are config, though the generated HTML files are not).
- Replace a hand-maintained static HTML table with a repeatable CSV-driven workflow.
- Give non-developers a self-service way to publish tabular data through the admin UI.
- Display seasonal or campaign datasets that are swapped out by uploading a new CSV.
- Show reference tables (glossaries, code lists, lookup tables) with instant client-side search.
- Provide a print-friendly view of a dataset through the DataTables print button.
