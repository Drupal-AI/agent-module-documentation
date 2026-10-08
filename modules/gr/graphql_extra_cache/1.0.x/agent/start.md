<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Extra Cache (graphql_extra_cache) — agent index

An **early request-lifecycle response cache** for GraphQL queries served by a `graphql_core_schema`
server. Requires `graphql` and `graphql_core_schema`. Own description: *"Cache all the things"*.
Version **1.0.5** (branch `1.0.x`). Core `^8 || ^9 || ^10 || ^11` (tested here against `graphql` 5.x).
No UI, no permissions, no config schema, no Drush.

## What it actually does

- **`Routing\RouteSubscriber`** loads every `graphql_server` entity and, for each whose schema is
  `core_composable`, overrides the `_controller` of route **`graphql.query.<server_id>`** to
  `CachedRequestController::handleRequest`. (Other schemas are untouched — bring your own subscriber.)
- **`Controller\CachedRequestController`** extends the graphql module's `RequestController`. Per single
  (non-batch) operation, when the server's `caching` flag is not `FALSE`:
  1. **prefix** = `sha256(query + operationName + serialize(ksort(variables)))` (`cachePrefix()`);
     returns `NULL` for non-serializable variables (e.g. file-upload mutations) → not cached.
  2. **read** (`cacheRead`): fetch `contexts:<prefix>` (the cache-context list a prior run declared),
     resolve those tokens to concrete keys for *this* request via `cache_contexts_manager`, hash them
     into a **suffix**, and return the `CachedResult` stored at `result:<prefix>:<suffix>` if present.
  3. **hit** → build `CacheableJsonResponse` from the stored `ExecutionResult` and re-attach the stored
     `CacheableMetadata` (contexts + tags + max-age). **No access re-check is run on a hit.**
  4. **miss** → execute; then `cacheWrite` stores the result and its **cache tags** under both
     `contexts:<prefix>` and `result:<prefix>:<suffix>`. **Skips writing when `max-age === 0`** (so
     mutations are not cached). `max-age` maps to an `expire` timestamp.
- **`CachedResult`** wraps `ExecutionResult` + `CacheableMetadata` + expiry.
- **`Plugin/GraphQL/PersistedQuery/DynamicCachedPersistedQuery`** — on a miss the controller stashes the
  raw query in `extensions['graphql_extra_cache']`, sets `queryId = sha256(query)`, nulls `query`; this
  plugin then parses/validates the string once and stores it (normalizing legacy `DocumentNode` entries
  to source text), so subsequent runs skip re-parsing the POST body.
- **Bins** (`.services.yml`): `graphql_extra_cache_response` (results) and `graphql_extra_cache_query`
  (persisted query strings).

## Caching model — the thing to get right

Variation is carried **entirely by the result's cache contexts**, the same cache-redirect pattern
core uses for the dynamic page cache. The prefix keys only on query + variables; **all per-user /
per-permission variance lives in the suffix**, which is derived from the contexts the *result*
declared. So correctness depends on the schema's resolvers bubbling **every** context their data
varies by (`user`, `user.permissions`, `user.node_grants`, `session`, …). A resolver that returns
access-controlled data **without** declaring the matching context caches per query string but **not**
per user — a classic response-cache cross-user leak. Invalidation, by contrast, is sound: cache
**tags** are stored and honored, so a node save clears every response carrying that node.

**Verify concretely:** run a query returning unpublished content for an editor and nothing for
anonymous — in that order, then reversed — and confirm each identity gets its own answer.

## Files

- `graphql_extra_cache.info.yml`, `graphql_extra_cache.services.yml`, `Readme.MD`
- `src/Routing/RouteSubscriber.php`, `src/Controller/CachedRequestController.php`
- `src/CachedResult.php`, `src/Plugin/GraphQL/PersistedQuery/DynamicCachedPersistedQuery.php`

## Docs

- `../usage.md` — short / paragraph / use-case bullets.
- `../data.json` — metadata.
