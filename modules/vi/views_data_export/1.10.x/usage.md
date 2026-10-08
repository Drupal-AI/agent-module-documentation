Views Data Export adds a "Data export" Views display and style that render a View's results as a downloadable file — CSV, XML, JSON, or XLS — and can handle very large result sets via batching.

---

The module ships a Views **display plugin** (`data_export`, built on `rest_export`) and a matching **style plugin** (`data_export`) that serialize View rows into a file instead of an HTML page. You add a Data Export display to any View, pick one or more formats (CSV via the required `csv_serialization` module, XML and JSON via core serialization, XLS/XLSX via the optional `xls_serialization` module), and expose it either as a standalone download URL or as an attachment/link on a normal page display. For big exports it offers batched generation (`export_method`, `export_batch_size`, `export_limit`) so it can stream tens of thousands of rows without exhausting memory, optionally saving the file and redirecting or auto-downloading when done. CSV settings (delimiter, enclosure, escape char, strip tags, trim, encoding, UTF-8 BOM, header row) and XML settings (root/item node names, encoding, formatting) are all configurable in the style options. Exports respect the View's fields, filters, sorts, contextual arguments, and access, and integrate with Search API and Facets. A Drush command (`views_data_export:views-data-export`, alias `vde`) runs an export headless for cron or scripting, and `hook_views_data_export_row_alter()` lets you tweak each row before it is written. It is the standard way to give site builders one-click, format-flexible data downloads from any View.

---

- Add a "Download CSV" link to a content listing View.
- Export nodes, users, or taxonomy terms to a spreadsheet.
- Produce an XLS/XLSX report for stakeholders (with xls_serialization).
- Emit a JSON feed of View results for another system to consume.
- Generate an XML export with custom root and item node names.
- Export very large datasets (tens of thousands of rows) using batch mode.
- Attach a data-export download button to an existing page display.
- Schedule a nightly export via cron using the `vde` Drush command.
- Script report generation as part of a deployment or ETL pipeline.
- Save the export file to a chosen file system and redirect after download.
- Auto-download the file immediately when the export URL is visited.
- Configure CSV delimiter/enclosure for a downstream tool's import format.
- Add a UTF-8 BOM so Excel opens the CSV with correct encoding.
- Strip HTML and trim whitespace from exported field values.
- Include or omit the header row in a CSV export.
- Export Search API-indexed results to a file.
- Export faceted search results honoring the active facets.
- Provide contextual-filter-driven exports (e.g. one file per author).
- Give editors a one-click "export current view" download.
- Export order or transaction data from a Commerce report View.
- Deliver data downloads that respect View access and permissions.
- Alter each exported row in code with `hook_views_data_export_row_alter()`.
- Limit an export to the first N rows with the export limit option.
- Offer multiple formats (CSV + XML + JSON) from a single View.
- Build a public open-data download endpoint from a View.
- Redirect users to a specific display or path after the export completes.
