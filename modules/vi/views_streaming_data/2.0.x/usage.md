<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Streaming Data adds a "Streaming data export" Views display with CSV and JSON style plugins that stream the result set to the client as rows are produced, instead of building the whole response in memory.

---

Exporting from a view works until the export is large, and then it fails in the most annoying way available: the request builds every row into a string, exhausts PHP's memory limit or the execution time, and returns a white screen after two minutes — with nothing partial to show for it. Views Streaming Data inverts that. You add a **Streaming data export** display (`streaming_data_export`, a `PathPluginBase` subclass) to any view, give it a path, and pick the **CSV** (`csv_streaming_data`) or **JSON** (`json_streaming_data`) style; the row plugin is locked to core REST's **`data_field`**. The route it registers is GET-only, carries a `_format` requirement (`csv`/`json`), and optionally a list of authentication providers you enable (cookie, basic_auth, …). When the path is hit, `StreamingDataExport::buildResponse()` returns a Symfony **`StreamedResponse`** with `Content-Disposition: attachment`, calls `set_time_limit(0)`, and — **inside the streaming callback** — checks `$view->access($display_id)` before writing a single byte. The heavy lifting is a swapped query and executable: the display substitutes core's `views_query` with **`streaming_sql_query`** (`StreamingSql extends Sql`), which executes the SQL statement but does **not** buffer the rows — it keeps the PDO `Statement` and sets `$view->result = []`. A **`StreamingViewExecutable`** (an `IteratorAggregate`) then fetches rows from that statement in chunks (**`chunk_size`**, default 50, selectable 5–200), loads the entities for each chunk, renders them, `yield`s them to the style plugin which writes each row straight to `php://output`, and — critically — calls `entity.memory_cache->deleteAll()` after each chunk and reflectively nulls each field handler's `entityFieldRenderer` so neither grows unbounded. Memory stays roughly flat regardless of row count; 100k+ rows is the stated design target. Three consequences follow. **The response starts before the query finishes**, so an error partway through arrives inside a file that has already begun downloading — there is no clean error page, and the user gets a truncated file that looks complete (only live preview is exempt, and preview is disabled for this display). **Buffering defeats it** — a reverse proxy, output filter, or gzip layer that waits for the full body puts the memory back on the proxy instead of PHP, and some contrib modules that hook the normal Views result set are simply incompatible because those hooks are skipped. And **access is still the view's**: streaming changes delivery, not authorisation, so the display needs the same filters, access plugin, and permission as any other view — a fast export of data the user should not have is worse, not better. The CSV style adds delimiter (comma/pipe/tab, which also switches the mime type and extension), strip-tags, decode-entities, and trim options; the file name derives from the path, a custom string, or the view id.

---

- Export a hundred thousand or more rows to CSV without hitting the PHP memory limit.
- Stream a large JSON export as a flat array of row objects.
- Add a downloadable CSV endpoint to an existing view by adding a Streaming data export display.
- Start a file download immediately instead of waiting for the whole response to build.
- Provide a nightly, machine-consumable data feed from a view at a fixed path.
- Export a full content inventory (nodes, fields) for a data warehouse.
- Export orders or line items for accounting in bulk.
- Choose a chunk size (5–200) to trade per-request overhead against memory for entity-heavy rows.
- Emit a tab-separated (.tsv) or pipe-delimited (.txt) file by switching the CSV delimiter.
- Require basic_auth or cookie authentication on the export route while keeping the view's access check.
- Give the export a fixed download filename, or derive it from the view path.
- Export a member or subscriber list on demand.
- Feed a partner an up-to-date product export over HTTP GET.
- Export search or filtered results in bulk using the view's exposed/contextual filters.
- Stream a log or audit extract too large to render as an HTML page.
- Export taxonomy or reference data for offline analysis.
- Reduce export server memory pressure so exports no longer time out or white-screen.
- Provide a large API-style response from Views without the REST module's in-memory serialization.
- Strip HTML tags and trim whitespace from field values in the exported CSV.
- Keep memory flat on shared hosting where the PHP memory_limit is low.
- Serve an export view that respects node access grants (the access query tag is still applied).
- Replace a failing Views REST/CSV export that dies on large result sets.
- Generate a periodic partner or regulator export from a saved, filtered view.
- Decode HTML entities in exported values so downstream tools receive clean text.
- Expose a read-only, GET-only data export route separate from the site's HTML pages.
