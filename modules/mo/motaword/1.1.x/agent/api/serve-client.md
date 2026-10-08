<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ServeClient, MetadataStore & MetadataRefresher

The HTTP layer that talks to MotaWord Active Serve and the per-environment cache of what Serve returns.

## ServeClient (`src/ServeClient.php`, service `motaword.serve_client`)

Thin Guzzle wrapper over core `http_client`. Constructor args: `config.factory`, `http_client`, `logger.channel.motaword`, `motaword.metadata_store`. Resolves the outbound host from `serve_host_internal` → `serve_host` → `DEFAULT_SERVE_HOST` (`https://serve.motaword.com`), trimmed of trailing slash (`getServeHost()`). Authenticates every call with the `X-MotaWord-Token` request header. **Reliability rule:** every method fails open — on any error it logs at WARNING/NOTICE and returns `null`/`false`/`[]`; it never throws, so a Serve outage never breaks the site.

Methods:

- `getLocalMetadata(string $token, ?int $timeout = null): ?array` — `GET /get-local-metadata?documents=0`. Returns decoded `['project', 'widget']` (drops `documents`). When `$timeout` is passed (visitor path) it sets `connect_timeout = min(2, $timeout)` to fail fast. Uses `stripTopLevelKey()` to cut the huge `documents` member out of the raw JSON string before decoding, to bound memory on large projects.
- `prepareCustomerUrls(string $token, array $urls, ?string $urlModeOverride = null): ?array` — `POST /prepare-customer-urls` (JSON body `{urls:[…]}`). Returns the `urls` array of localized mappings. Used by the menu manipulator.
- `purgePages(string $token, array $urls, ?string $reason = null): bool` — `POST /purge-page`, `application/x-www-form-urlencoded` body `pages[]=…`. Cache invalidation.
- `refreshDomain(string $token, string $homeUrl, array $targetLocales): bool` — `POST /crawler/` (JSON `operation:refresh`, followLinks, maxConcurrency 1). Token is sent in both the header and the body (ported verbatim from the WP plugin).
- `fetchTranslated(string $token, string $sourceUrl, array $extraHeaders = []): ?ResponseInterface` — `GET /<urlencoded source URL>`. The proxy fetch. Sends `allow_redirects=false`, forces `Accept-Encoding: gzip, deflate, br`, returns the raw Guzzle response (caller inspects status). Timeouts: metadata 60s, url-details/purge/crawler 30s, proxy 70s.

`computeUrlModeOverride(): ?string` returns `'path'` when the proxy is enabled and the project's saved `urlMode` is not already `path` (else `null`). This override is embedded inside the customer URL as `?mwActiveUrlMode=path` in `fetchTranslated()` (embedding, not an outer query param, survives CDN path normalisation and avoids a proxy loop).

## MetadataStore (`src/MetadataStore.php`, service `motaword.metadata_store`)

Stores the project + widget records in the **State API** (`STATE_KEY = 'motaword.metadata'`), not in config — so `drush cim`/`deploy` never wipes them and they don't leak between environments. Constructor: `state`, `config.factory`, `cache_tags.invalidator`.

- `getToken(): string` — effective token: a non-empty `settings.php` override wins, otherwise the saved `active_token`. An empty override is ignored (missing env var must not shadow a saved token).
- `isTokenOverridden(): bool` — true only when `settings.php` supplies a non-empty override.
- `getProject()` / `getWidget()` / `hasMetadata()` — read the cached records.
- `save(string $token, array $metadata)` — writes a record stamped with `hashToken()` (SHA-256 of the token); skips the write + cache-tag invalidation when nothing changed.
- `clear()` — deletes the stored record.
- Reads compare the stored `token_hash` with `hash_equals()`; a **different** token returns empty records (forces a refetch), but a currently-empty token still returns the last record so off-locale redirects keep working.
- `CACHE_TAG = 'motaword_metadata'` is invalidated on every change; pages that embed metadata-derived markup carry it.
- `fromCoreServices()` builds the store from core services for the stale-container window right after a code update (before `drush updb` / cache rebuild); every 1.1 class that gained a constructor arg falls back to it.

## MetadataRefresher (`src/MetadataRefresher.php`, service `motaword.metadata_refresher`)

Fetches metadata into the store. Separate service because ServeClient itself reads the store, so the store cannot depend on ServeClient. Constructor: store, serveClient, state, logger, `lock`.

- `refresh(?string $token = null, ?int $timeout = null): bool` — fetch + save; clears the retry back-off on usable metadata.
- `ensureLoaded(int $timeout = AUTO_TIMEOUT)` — refetches when a token is set but metadata is missing (env-var token, config import, copied DB). Bounded for the visitor path: no-op when metadata is present; one fetch at a time site-wide via `lock`; consecutive failures back off `RETRY_SECONDS` (300s) doubling to `MAX_RETRY_SECONDS` (3600s); the fetch is capped (visitor `AUTO_TIMEOUT` 5s, background `BACKGROUND_TIMEOUT` 60s). A visitor-path fetch that hits its timeout is marked `slow` so only cron / the settings page retry it thereafter. Called from the proxy subscriber, settings form, and `hook_cron`.
