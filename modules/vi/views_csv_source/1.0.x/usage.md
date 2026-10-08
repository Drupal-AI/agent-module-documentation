<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views CSV Source adds a Views query backend that reads rows from a CSV file instead of the database, so a spreadsheet — uploaded, stored locally, or fetched over HTTP — can be listed, sorted, filtered, joined and themed with the whole Views toolkit.

---

Views is Drupal's listing engine, and it normally queries SQL. This module supplies an alternative query plugin (`views_csv_source_query`, in `src/Plugin/views/query/ViewsCsvQuery.php`, with `src/Query/Connection.php` and `src/Query/Select.php` behind it) that parses CSV via `league/csv ^9.27` and presents each column as a Views field. You create a view, pick "CSV" as the source, then open Advanced → Query settings and give it the file: an uploaded managed file, an internal path, or an `http(s)` URL. The HTTP branch supports GET and POST with configurable headers and body, so it can also consume a CSV-returning REST endpoint, and remote responses are cached for a configurable duration (settings at `/admin/config/user-interface/views-csv-source-settings`). On top of the query plugin the module ships a full set of handlers — a CSV field (with click-sort and an optional raw-HTML mode), text/options/numeric/date/combine filters, a natural-order sort, a contextual-filter argument, and a relationship handler that joins a second CSV in memory. Group-by aggregation (count/sum/avg/min/max) and a constant field are included, and a `PreCacheEvent` lets other modules rewrite the CSV text before it is cached. Contextual arguments and tokens can be interpolated into the file path so one view can target many files. It shines when you want Views' presentation power over tabular data without modelling it as entities.

---

- List a spreadsheet's rows through Views.
- Publish a CSV export produced by another system.
- Sort and filter a CSV without importing it into content.
- Consume a REST endpoint that returns CSV.
- Show an uploaded price list as a themed table.
- Build a chart from a CSV using a Views chart style.
- Page through a large CSV that would overwhelm entity storage.
- Filter a CSV by a column's unique values with an exposed dropdown.
- Filter CSV rows by a date column, including by year alone.
- Do numeric range filtering on a CSV column.
- Search across several CSV columns at once (combine filter).
- Join a lookup CSV to a main CSV via a relationship.
- Group and aggregate CSV rows (count/sum/avg/min/max).
- Use a contextual filter to pick which CSV file to read.
- Cache a remote CSV between requests to reduce fetches.
- Send custom HTTP headers (e.g. Basic auth) to fetch a protected CSV.
- POST a request body to an endpoint that returns CSV.
- Expose an open-data CSV on a Drupal site.
- Provide a CSV-backed block or attachment display.
- Avoid creating a content type for one-off reference data.
- Refresh a listing simply by replacing the source file.
- Render raw HTML held in a trusted CSV column.
- Prototype a listing before committing to an entity model.
- Give editors a spreadsheet-driven table they can update externally.
