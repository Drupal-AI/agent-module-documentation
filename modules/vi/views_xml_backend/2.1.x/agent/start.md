<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views XML Backend (views_xml_backend) — agent index

A Views **query backend** that reads a local or remote **XML document** as the data source and
queries it with **XPath 1.0**, instead of running SQL against the database. Depends only on core
`views`. Core requirement `^8.8 || ^9 || ^10 || ^11`. Not covered by the security advisory policy;
minimally maintained.

## How it works
- Registers one Views base table, `XML` (`hook_views_data`, group `XML`), whose `query_id` is
  `views_xml_backend`. The query plugin (`src/Plugin/views/query/Xml.php`) extends
  `QueryPluginBase` and overrides `build()`/`execute()`.
- Display **Query settings** hold: `xml_file` (URL or local/stream path, required), `row_xpath`
  (XPath selecting record nodes, required), `default_namespace` (name for the document's
  unprefixed namespace, default `default`), and `show_errors` (surface libxml errors in preview).
- Each field/filter/sort/argument handler carries its own **`xpath_selector`**, evaluated
  relative to a row node. Filters and arguments `__toString()` to XPath predicate fragments and
  are appended to the row XPath as `row_xpath[frag and frag …]`.
- Execution: fetch file contents → build a `DOMXPath` → run `row_xpath` predicate → one
  `ResultRow` per node, each field's selector queried within the row → **sorts and paging applied
  in PHP** (no push-down; whole document is parsed and held in memory).

## Fetch + cache
- Local path (no URL host) → `file_get_contents`. Remote URL → dedicated Guzzle client
  `views_xml_backend.http_client` (a clone of core `http_client`).
- Conditional caching: ETag/Last-Modified stored in the `views_xml_backend_download` cache bin;
  body written to a `sha256(url)`-named file under `public://views_xml_backend`
  (`$settings['views_xml_backend_cache_directory']`). `304` reuses the on-disk copy; a failed
  request falls back to the last good file. `hook_cron()` deletes cache files older than
  `$settings['views_xml_backend_expire']` (default `604800`).
- Alter hook: `hook_views_xml_backend_http_request_alter(&$url, &$options, &$context)` — mutate
  URL/Guzzle options before the GET (e.g. add an API key header). See `views_xml_backend.api.php`.

## XML parsing
- `DOMDocument::loadXML` with `recover = TRUE` (forgiving), `resolveExternals = FALSE`,
  `substituteEntities = TRUE`, options `LIBXML_NONET | LIBXML_COMPACT | LIBXML_PARSEHUGE |
  LIBXML_BIGLINES`. On PHP < 8 it also toggles `libxml_disable_entity_loader`.
- Any document containing a DOCTYPE node is discarded (replaced with an empty document) — a
  deliberate anti-XXE / "suspicious document" defense.
- Namespaces auto-registered from the parsed document; unprefixed default namespace bound to
  `default_namespace`; `php:` bound only for the two registered XPath-callable PHP functions
  `views_xml_backend_date` and `views_xml_backend_format_value` (dates).

## Provided plugins
See [plugins/handlers.md](plugins/handlers.md) for the full handler set (query, field, filter,
sort, argument) with plugin IDs, the XPath they emit, and the `views_xml_backend_*` data columns
declared in `hook_views_data`.

## Gotchas
- **XPath is the ceiling.** Filtering/sorting capability is whatever XPath 1.0 can express against
  that document — not SQL. Filter values are quote-escaped via `Xpath::escapeXpathString()`.
- **No push-down.** Sorting and paging happen in PHP after the full parse; large documents are a
  memory/latency risk on hot paths.
- **Render-time remote dependency.** A remote `xml_file` is fetched when the view runs, so upstream
  availability, latency, TLS and trust become the site's problem. Decide caching/failure handling.
- **Trust the source.** The XML content becomes view output; the HTML Markup field runs values
  through a chosen text format (choose a safe format for untrusted feeds).
- Configuring an XML view needs the standard *administer views* permission; the module adds no
  permissions, routes, services beyond the two above, or Drush commands.
