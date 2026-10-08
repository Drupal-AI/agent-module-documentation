<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, importer, generators & the database profile flow

Services are declared in `ai_content_migrate.services.yml`.

## Legacy HTML import

- **`ai_content_migrate.importer`** (`Importer`, `src/Importer.php`) — args `@entity_type.manager`,
  `@entity_field.manager`, `@file.repository`, `@http_client`, `@logger.factory`. Converts a page's
  HTML + a JSON model into one node.
  - `importFromUrl($url, $model)` — GETs `$url` with `http_client`, then `importContent()`.
  - `importContent($html, $model)` — `$html` may be raw markup **or a filesystem path**. Normalizes
    the model, parses HTML into `DOMDocument`/`DOMXPath`, downloads `media_bundles[].items[].url`
    bytes to `public://aicontent/<basename>` wrapped in Media, creates missing taxonomy terms
    (`accessCheck(FALSE)`), and fills one node's fields from the first matching XPath. One node per run.
- **`ai_content_migrate.import_content`** queue worker (`ImportContentQueue`) — cron worker that GETs
  `$data['url']` HTML and calls `importContent()`; fetch failures logged and re-thrown.

## Sitemap flow services

- **`ai_content_migrate.migrator`** (`ContentMigrator`) — args `@ai.provider`, `@logger.factory`,
  `@ai_content_migrate.sitemap_parser`, `@entity_type.manager`. `parseSitemap()`, model-similarity
  matching (`isModelMatch()`, `MIN_MATCH_RATIO = 0.92`, `MIN_MATCH_THRESHOLD = 3`) and
  `groupModelsBySimilarity()` — one representative `content_model` per distinct template, so the
  sitemap batch calls the AI once per structure, not once per URL.
- **`ai_content_migrate.sitemap_parser`** (`SitemapParser`) — args `@http_client`, `@logger.factory`.
  `parse()` fetches a sitemap URL (or accepts inline text), handles `urlset`, recurses
  `sitemapindex` one level, and plain-text URL lists; dedups, keeps only `http(s)` URLs, caps at
  `MAX_URLS = 200`. `parseAlternates()` reads per-URL `xhtml:link rel="alternate"` hreflang data so
  known translations reuse one model.
- **`ai_content_migrate.html_fetcher`** (`HtmlFetcher`, `src/Utility/HtmlFetcher.php`, static) —
  `fetch($url)` validates the URL with `FILTER_VALIDATE_URL`, then renders it with headless Chromium
  (`BrowserFactory`, `CHROME_PATH` or `/usr/bin/chromium`), waiting for
  `NETWORK_IDLE` up to `FETCH_TIMEOUT_MS = 20000` (catching `OperationTimedOut` to still read the
  DOM). In-memory LRU cache of the last `CACHE_SIZE = 50` pages. Used by both the AI analysis and the
  migration's field extraction so both see the same rendered DOM.

## Generators

- **`ai_content_migrate.migrate_file_generation`** (`MigrateFileGeneration`) — builds and writes
  `migrate_plus.migration.*` YAML (+ CSV) into `public://ai_migrations/`.
- **`ai_content_migrate.canvas_template_generator`** (`CanvasTemplateGenerator`) — generates a Canvas
  (Experience Builder) template per content type.

## Database profile flow

- **`ai_content_migrate.database_profile_migrator`** (`DatabaseProfileMigrator`) — args include the
  source-profile manager, `@keyvalue`, `@file_system`, `@plugin.manager.migration`, `@ai.provider`.
  Drives analyze → review → generate → run/rollback. `detect($sql)` extracts table names
  (`SqlDumpParser`) and asks the profile manager for a match. Analysis state and dataset rows live in
  the `ai_content_migrate.profile_analysis` key/value collection; migrations are saved as
  `migrate_plus` config in the `ai_content_migrate_database` group (run/rolled back via Batch API,
  25 rows/request, or `drush migrate:import --group=ai_content_migrate_database`).
- **`ai_content_migrate.schema_profiler`** (`SchemaProfiler`) — describes a dump locally: tables,
  columns + declared types, row counts, fill/uniqueness, value *shapes* (date/email/identifier/
  HTML/…), markup element/class inventories, and value-inferred relations. **Values are never in the
  result** except distinct values of short code columns (`CODE_COLUMNS` regex, `MAX_CODES = 12`,
  excluding `NOT_CODES` shapes), needed to write filters. `SAMPLE_ROWS = 3000`. `anonymizeRows()`
  replaces each sample value with its shape. This metadata is all the AI ever receives.
- **`ai_content_migrate.profile_drafter`** (`ProfileDrafter`, args `@ai.provider`,
  `@extension.list.module`, `@ai_content_migrate.profile_verifier`) — asks the AI (one call) to draft
  a declarative YAML profile from that metadata; up to 2 automatic corrections on verify errors.
- **`ai_content_migrate.profile_verifier`** (`ProfileVerifier`) — runs a profile against the whole
  dump importing nothing; the report holds only counts, names and masked path patterns (safe to send
  back to the AI).
- **`ai_content_migrate.canvas_tree_builder`** (`CanvasTreeBuilder`),
  **`ai_content_migrate.wiki_breadcrumb`** (`WikiBreadcrumbBuilder`, breadcrumb_builder priority
  1010) — wiki page-tree layout and breadcrumbs for migrated wiki nodes.

Shipped Confluence migration (see `README.md`, `example/confluence/`, `example/bookstack/`): spaces →
"Wiki space" nodes, current page versions → "Wiki page" nodes (pathauto `/wiki/{space}/{title}`), page
tree + labels + attachments + author, storage-format bodies converted to the `wiki_html` text format,
301 redirects, and a Canvas template per type.

## Operating notes

- Imported media/files land in `public://aicontent/`; migrate-generated files in
  `public://ai_migrations/`. Ensure the public filesystem is writable.
- Entity queries in the importer/sitemap code use `accessCheck(FALSE)` by design (system-level
  import).
- Headless Chromium is required for all page rendering; set `CHROME_PATH` if the binary is not at
  `/usr/bin/chromium`.
