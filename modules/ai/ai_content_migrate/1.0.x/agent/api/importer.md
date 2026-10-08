<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Importer service, queue worker & migrate process plugins

## `ai_content_migrate.importer` — `src/Importer.php`

Service class `Importer` (defined in `ai_content_migrate.services.yml`), args `@entity_type.manager`,
`@entity_field.manager`, `@file.repository`, `@http_client`, `@logger.factory`. It converts a page's
HTML plus a JSON model into a single node.

- `importFromUrl(string $url, mixed $model): string` — GETs `$url` with `http_client` (UA
  `Drupal Crawler/1.0`, 20s timeout), then delegates to `importContent()`. Returns the created node
  id (string) or `''` on failure.
- `importContent(string $html, mixed $model): string` — the main entry point. `$html` may be raw
  markup **or a filesystem path** (if `is_file($html)`, it is read and its dir becomes `$baseDir` for
  resolving relative asset paths). Steps:
  1. Normalize the model (array / JSON string / object). If there is no top-level `content_types`, it
     unwraps `$model[0]['model']`.
  2. Parse the HTML into `DOMDocument` + `DOMXPath` (libxml errors suppressed).
  3. **Media** (`model['media_bundles']`): for each item `url` (resolved via `resolveUrl()`),
     `http_client->get()` fetches the referenced image bytes; they are written via
     `file.repository->writeData()` to `public://aicontent/<basename>` (`EXISTS_RENAME`) and wrapped
     in a `Media` entity of the bundle's source field. Alt text falls back item.alt → page title
     (`og:title` / `//h1`) → `default_alt` (`'Image'`).
  4. **Taxonomies** (`model['taxonomies']`): create missing `Term`s per vocabulary (queries use
     `accessCheck(FALSE)`); cache lowercased-name → tid.
  5. **Node** (`model['content_types']`): for each field, resolve the machine name (`title`, else
     `field_<name>`), skip unknown fields. Image/media entity-reference fields download URLs into
     files/media on the fly (`$downloadToFile`, `$createMediaFromFile`); taxonomy references resolve
     a vocabulary heuristically (`$resolveVocabulary`) and create terms; scalar fields take the first
     matching XPath value (`integer` cleaned via regex, others trimmed). Creates **one node per run**
     (breaks after the first content type) and returns its id.

## Queue worker `ai_content_migrate.import_content` — `src/Plugin/QueueWorker/ImportContentQueue.php`

`@QueueWorker(id="ai_content_migrate.import_content", cron={"time"=60})`. `processItem($data)` expects
`$data['url']` (string) and optional `$data['model']`. It GETs the URL's HTML with `http_client`
(same UA/timeout) and calls `importer->importContent($html, $data['model'] ?? [])`. Fetch failures are
logged and re-thrown (so the item can be retried). Queue items are produced by the agent flow, not by
any public endpoint.

## Migrate process plugins — `src/Plugin/migrate/process/`

Used only inside the **generated `migrate_plus` migration definitions** (see
[../config/entities-routes.md](../config/entities-routes.md)), which run via Drush / migrate_plus:

- `download_or_skip` (`DownloadOrSkip`, extends core `Download`) — downloads a file; on any exception
  throws `MigrateSkipRowException` instead of failing the whole migration.
- `get_full_path` (`GetFullPath`) — rebuilds an absolute asset URL from the row's `url` scheme+host
  plus the selected relative path (`UrlHelper::parse()`), or stops the pipeline when empty.
- `empty_coalesce` (`EmptyCoalesce`, extends core `NullCoalesce`) — returns the first non-empty value
  from the input array, else `configuration['default_value']`, else NULL.

## Operating notes

- Media and files land in `public://aicontent/`; migrate-generated files in
  `public://ai_migrations/files/`. Ensure the public filesystem is writable.
- Term/entity queries in the importer use `accessCheck(FALSE)` by design (system-level import).
- The Importer downloads assets synchronously with a 20-second per-request timeout; large pages or
  many media items make the run proportionally long — prefer the queue for bulk work.
