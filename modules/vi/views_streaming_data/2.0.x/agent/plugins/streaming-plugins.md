<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins and classes

All paths are under `src/` of `views_streaming_data`.

## Display: `streaming_data_export`

`Plugin/views/display/StreamingDataExport.php` — `class StreamingDataExport extends PathPluginBase
implements StreamingDisplayInterface`.

- Annotation: `uses_route = TRUE`, `returns_response = TRUE`, `admin = "Streaming data export"`.
- `usesPager = FALSE`, `usesAJAX = FALSE`, `usesMore = FALSE`, `usesAreas = FALSE`, `usesOptions = FALSE`.
- `getType()` → `streaming_data`. `usesExposed()` → TRUE, `displaysExposed()` → FALSE.
- `defineOptions()`: default style `csv_streaming_data`, default row `data_field`, pager `none`; adds
  `auth` (`[]`), `chunk_size` (`DEFAULT_CHUNK_SIZE` = 50), `export_file_from_path` (FALSE),
  `export_file_name` (`''`). Removes exposed_form/exposed_block/css_class.
- `getPlugin('query')`: looks up the base table's `query_id`; if it is `views_query` it substitutes
  **`streaming_sql_query`**. This is how the streaming query is injected.
- `collectRoutes()`: after `parent::collectRoutes()`, restricts the view route to **GET**, sets the
  `_format` requirement to the style's format (`csv`/`json`), and if `auth` is set adds it as the route
  `_auth` option.
- `buildResponse($view_id, $display_id, $args)` (static): loads a `StreamingViewExecutable` via the
  `views_streaming_data.views.executable` service, inits the style (to fix mime/extension), builds the
  filename, `set_time_limit(0)`, and returns a `StreamedResponse`. **The callback wraps everything in
  `if ($view->access($display_id))`** before executing the display and flushing/closing the stream.
  Response headers: `Content-Type: <mime>; charset=utf-8`, `Content-Disposition: attachment;
  filename="…"`, `Cache-Control: must-revalidate, no-cache, private`, `Max-Age: 0`.
- `render()`: runs `style_plugin->render()` inside a fresh `RenderContext`; returns `#markup` (expected
  empty — the bytes went straight to the output stream).
- `getOutputStream()`: lazily `fopen('php://output', 'wb')`; overridable via `setOutputStream()`
  (the kernel tests inject a memory stream here).
- `getExportFileName()`: from path basename, or custom name, else `{view-id}-{display-id}`, plus the
  serializer extension.
- `preview()`: returns a "No preview is available for a streaming export" notice; only builds the query
  (for the SQL-preview debug box) when `live_preview` is set.

`StreamingDisplayInterface` (extends `ResponseDisplayPluginInterface`) declares `DEFAULT_CHUNK_SIZE = 50`
and the stream/mime/extension/filename accessors.

## Query: `streaming_sql_query`

`Plugin/views/query/StreamingSql.php` — `class StreamingSql extends Sql`.

- `execute(ViewExecutable $view)`: only takes the streaming path when `$view instanceof
  StreamingViewExecutable`; otherwise defers to `parent::execute()`. It adds the base table's
  **access query tag** and query metadata (unless `disable_sql_rewrite`), runs `$query->execute()`,
  sets the statement fetch mode to `FETCH_CLASS` of `ResultRow`, stores it in `$this->result`, and sets
  `$view->result = []` and `$view->total_rows = NULL`. No count query, no pager — by design.
- `loadEntities(&$results)`: calls parent then `entity.memory_cache->deleteAll()` to prevent OOM.
- Constructor adds the `entity.memory_cache` service to the standard `Sql` dependencies.

## Executable: `StreamingViewExecutable`

`src/StreamingViewExecutable.php` — `extends ViewExecutable implements IteratorAggregate`.

- `getIterator()`: the generator. Fetches rows from `query->result` in `chunk_size` batches, assigns a
  running `index`, calls `query->loadEntities()` and `renderResult()` per chunk, `yield`s each row, then
  reflectively sets each field handler's private `entityFieldRenderer` back to NULL so the per-chunk
  render state does not accumulate across chunks.
- `execute()` / `render()`: trimmed copies of core's, skipping count/pager logic; never run the query in
  live preview.
- `ViewExecutableFactory` (`src/ViewExecutableFactory.php`, service
  `views_streaming_data.views.executable`) builds a `StreamingViewExecutable` for a view id and attaches
  the current request.

## Styles

`Plugin/views/style/StreamingCsvSerializer.php` (`csv_streaming_data`) and
`StreamingJsonSerializer.php` (`json_streaming_data`). Both: `usesRowPlugin = TRUE`,
`usesGrouping = FALSE`, `CacheableDependencyInterface` with max-age 0 and `request_format` context.

- CSV: `init()` sets mime/extension from the delimiter — comma → `text/csv`/`.csv`, pipe → `text/plain`/
  `.txt`, tab → `text/tab-separated-values`/`.tsv`. Options: `delimiter`, `strip_tags` (default TRUE),
  `decode_entities` (default FALSE), `trim` (default TRUE). `render()` iterates the traversable view,
  renders each row via the `data_field` row plugin, writes a header row from field labels, and writes
  each data row with `fputcsv` (comma) or a manual `implode` (pipe/tab, replacing the delimiter inside
  values). Formatting uses `csv_serialization`'s `CsvEncoder::formatRow()`.
- JSON: `init()` sets `application/json` / `.json`. `render()` manually writes `[`, then each row as
  `json_encode($data)` separated by commas, then `]`.

## Module glue

`views_streaming_data.module`: `hook_views_plugins_row_alter()` registers `streaming_data` as an allowed
display type for the `data_field` row plugin; `hook_help()` for the help page.
