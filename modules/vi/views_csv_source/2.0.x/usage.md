<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views CSV Source adds a Views query backend that reads rows from a CSV file instead of the database, so a spreadsheet — a managed file, a local path, or one fetched over HTTP — can be listed, sorted, filtered, related and aggregated with the whole Views toolkit.

---

Views is Drupal's listing engine and it normally queries SQL. This module supplies an alternative query plugin (`src/Plugin/views/query/ViewsCsvQuery.php`, backed by `src/Query/Connection.php` and `src/Query/Select.php`) that parses CSV via `league/csv ^9.27` and exposes the columns as Views fields. When you build a view you pick "CSV" in the "Show" field, then open the Query "Settings" and enter the source as one of three URI forms: an `entity:file/{fid}` reference to an uploaded managed file (an autocomplete restricted to `text/csv` files by the module's own selection handler), an `internal:/path` path relative to the docroot, or an `http(s)` URL fetched with Guzzle. The HTTP branch supports GET or POST with configurable headers and a multipart request body, so it can also consume a CSV-returning REST endpoint, and remote responses are cached for a configurable TTL. Version 2.0 adds a rich handler set: a plain text filter plus options/select, numeric, date and combine filters, string and date sorts, a contextual-filter argument, a "Constant Value" field, aggregation (count/sum/avg/min/max with group-by), and CSV-to-CSV relationships (joins). The URI accepts Drupal and Views tokens (including view arguments), so contextual filters can point the view at a different file per request. A settings form at `/admin/config/user-interface/views-csv-source-settings` (gated by `administer site configuration`) sets the remote cache duration, and a `PreCacheEvent` lets other code rewrite CSV content before it is cached. The source URI is a *view* setting configured with `administer views`.

---

- List a spreadsheet's rows through Views.
- Publish a CSV export from another system.
- Sort and filter a CSV without importing it.
- Consume a REST endpoint that returns CSV.
- Show an uploaded price list as a table.
- Restrict the file picker to CSV (text/csv) uploads.
- Theme CSV data with a Views template.
- Page through a large CSV.
- Aggregate CSV rows (count, sum, average, min, max) with group-by.
- Join a second CSV file with a CSV relationship.
- Filter a CSV column by a dropdown of its unique values.
- Filter CSV dates chronologically, including by year alone.
- Compare CSV numbers with a numeric filter.
- Search across multiple CSV columns with a combine filter.
- Use a contextual filter to select the file per request.
- Send a POST request with a multipart body to fetch data.
- Set custom auth headers on the data request.
- Cache a remote CSV between requests, or disable caching for huge files.
- Rewrite CSV content before caching via the PreCacheEvent.
- Avoid a migration for read-only reference data.
- Refresh data by replacing one file.
- Expose an open-data CSV on a site.
- Give editors a spreadsheet-driven listing.
- Prototype a listing before building a content type.
