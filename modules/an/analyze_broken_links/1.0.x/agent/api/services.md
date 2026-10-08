<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & data model

Three services, all `final` and using `DependencySerializationTrait`. Defined in
`analyze_broken_links.services.yml`.

## `analyze_broken_links.link_extractor` — `Service\LinkExtractorService`

Args: `entity_type.manager`, `renderer`, `config.factory`, `request_stack`.

- `extractLinks(EntityInterface): array` — renders the entity's `default` view mode with
  `renderer->renderInIsolation()` (`renderEntity()`), loads the HTML into `\DOMDocument`
  (`@loadHTML`, warnings suppressed), and walks the tags in `URL_ATTRIBUTES`:
  `a→href, img→src, link→href, script→src, iframe→src, source→src, video→src, audio→src`. For each it
  captures `link_text` (anchor `textContent` for `a`, `alt` for `img`), normalizes, drops excluded
  and duplicate URLs, and returns `{url, link_text (≤512 chars), field_name=<tag>, is_internal}`.
- `normalizeUrl(string, $entity): ?string` — trims; skips empty/`#`/`data:`; **allows only
  `http`/`https` schemes** (regex; anything with another scheme is dropped); upgrades protocol-relative
  `//host` to `https://host`; forces a leading `/` on relative paths; strips fragments.
- `isExcluded(string): bool` — matches against `excluded_patterns` (simple `*` → `.*` wildcard → regex,
  case-insensitive).
- `isInternal(string): bool` — relative URLs are internal; absolute URLs compared host-insensitively to
  `request->getHost()`.
- `matchesScope(string): bool` — honors `check_scope` (`both`/`internal`/`external`).

## `analyze_broken_links.link_checker` — `Service\LinkCheckerService`

Args: `http_client` (Guzzle), `config.factory`, `logger.channel.analyze_broken_links`,
`analyze_broken_links.storage`, `request_stack`, `datetime.time`.

- `checkUrls(array $urls, ?int $concurrency = NULL): array` — the concurrent checker.
  1. Serves fresh results from cache: for each URL, `storage->getUrlResult()`; if `last_checked > 0`,
     `status_code !== 0`, and `age < recheck_ttl`, reuse it.
  2. Resolves the rest via `resolveUrl()` (absolute passthrough; internal paths prefixed with the site
     base URL from `request->getSchemeAndHttpHost()`, CLI fallback `$base_url`/`http://localhost`).
  3. Runs a Guzzle **`Pool`** of `HEAD` requests: `concurrency` from config (default 5),
     `timeout`+`connect_timeout` from config (default 10), `allow_redirects.max = 10` with
     `track_redirects`, `http_errors => FALSE`, **`verify => TRUE`** (TLS on).
  4. `fulfilled`: records `status_code` + final redirect (`X-Guzzle-Redirect-History`); on **405 or
     403** retries once with `GET` via `checkSingleUrl()`. `rejected`: extracts a status if any, else
     retries `GET`; stores an `error_message` (≤512 chars) and logs a `warning`.
- `checkSingleUrl(string $url, string $method = 'HEAD'): array` — single request with the same options
  (`verify => TRUE`), measuring `response_time_ms`; catches `ConnectException`/`RequestException`/
  `\Exception` and returns `status_code=0` + a truncated message on failure.
- `recheckStaleUrls(int $limit, ?int $concurrency = NULL): int` — pulls `storage->getStaleUrls()` and
  re-runs `checkUrls()` on them (cron uses `limit=50`).

## `analyze_broken_links.storage` — `Service\BrokenLinksStorageService`

Args: `database`, `entity_type.manager`, `renderer`, `config.factory`, `datetime.time`. All queries
use the DB API query builder with bound conditions/placeholders (no string-concatenated SQL).

- `saveEntityUrl(...)` / `ensureUrlRecord()` — `merge()` on `analyze_broken_links_entity_urls`
  (keyed by type/id/url_id/langcode) and inserts a URL row keyed by `url_hash = sha256(url)`.
- `saveUrlResult(url, status, redirect, ms, error?)` — `merge()` on `analyze_broken_links_urls` by
  `url_hash`, incrementing `check_count`.
- `getUrlResult(url)` / `getScores($entity)` / `getValidScores($entity)` — cache reads; `getValidScores`
  compares stored `content_hash` (`generateContentHash()` = sha256 of rendered content) against current.
- `getStaleUrls(limit)` — URLs with `last_checked < now − recheck_ttl`.
- `getStatistics()` — total/broken/redirect/healthy counts (broken = `broken_status_codes`).
- `getUrlsWithEntities(filters, limit)` — the site-wide report query: joins entity_urls↔urls, excludes
  unchecked (`status_code > 0`), applies status/scope/content-type filters (node bundle via a
  `node_field_data`/`node` join with a bound `:node_type`), and attaches entity labels via
  `loadMultiple()`.
- `deleteScores($entity)` / `invalidateConfigCache()` (truncates entity_urls) /
  `countAnalyzedEntities($type,$bundle)`.

## Schema (`.install`, `hook_schema()`)

- **`analyze_broken_links_urls`**: `id` (serial PK), `url` (varchar 2048), `url_hash` (varchar 64,
  unique), `is_internal`, `status_code` (0 = unreachable), `redirect_url`, `response_time_ms`,
  `error_message` (varchar 512), `last_checked`, `check_count`. Indexes on status/internal/last_checked.
- **`analyze_broken_links_entity_urls`**: `id` (serial PK), `entity_type`, `entity_id`, `langcode`,
  `url_id` (FK), `link_text`, `field_name`, `content_hash`, `extracted_at`. Unique key on
  (entity_type, entity_id, url_id, langcode). `hook_uninstall()` empties both tables.
