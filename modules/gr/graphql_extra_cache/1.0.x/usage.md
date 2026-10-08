<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Extra Cache adds an early-lifecycle response cache for GraphQL queries served by a `graphql_core_schema` server, storing the whole execution result keyed on the query, its variables and the result's own cache contexts, and invalidating it by cache tags — the module's own description reads "Cache all the things".

---

GraphQL's flexibility is exactly what makes it hard to cache: a REST endpoint has a URL that identifies its response, but a GraphQL request is a POST whose body describes an arbitrary selection, so nothing outside the application can key on it. This module's `RouteSubscriber` swaps the controller on the `graphql.query.<server>` route of every `core_composable` server for a `CachedRequestController` that extends the `graphql` module's `RequestController`. On a single (non-batch) operation it computes `sha256(query + operationName + serialized-sorted-variables)` as a *prefix*, looks up a stored list of the cache contexts that a previous execution of that query declared, resolves those contexts to concrete keys for the current request to form a *suffix*, and returns the stored `CachedResult` under `result:<prefix>:<suffix>` when present — re-attaching the original result's cacheable metadata so downstream caches still vary correctly. This is the same cache-redirect pattern Drupal core uses for its dynamic page cache: variation is carried entirely by the result's cache contexts, so correctness depends on the schema's resolvers bubbling every context their data varies by (notably user / permission / node-grant contexts for access-controlled fields) — an under-declared context caches per query string but not per user. Misses execute normally, then `cacheWrite` stores the result plus its tags under both the contexts slot and the result slot, skipping anything with `max-age` 0 (mutations) or non-serializable variables (file-upload mutations). Two dedicated cache bins back it: `graphql_extra_cache_response` for results and `graphql_extra_cache_query` for a `DynamicCachedPersistedQuery` plugin that memoizes parsed/validated query strings so cache hits skip re-parsing the POST body. It requires `graphql` and `graphql_core_schema`, honors a server's `caching` flag (delegating to the stock controller when off), ships no config UI, permissions or config schema, and targets Drupal `^8` through `^11` (tested here against `graphql` 5.x). Verify safety concretely: run a query that returns unpublished content for an editor and nothing for anonymous, in that order and then reversed, and confirm each identity gets its own answer.

---

- Cache full GraphQL execution results for a decoupled front end.
- Speed up a headless Nuxt, Next.js or SvelteKit site backed by `graphql_core_schema`.
- Serve a repeated common query (navigation, footer, site settings) from cache.
- Skip re-parsing and re-validating the POST body on a cache hit.
- Reduce repeated resolver execution for identical queries.
- Invalidate cached GraphQL responses automatically via Drupal cache tags on node/entity save.
- Vary a cached response per user by relying on the result's cache contexts.
- Cache a listing or search query keyed on its variables.
- Cache expensive deeply-nested queries.
- Reduce database load from a high-traffic GraphQL API.
- Lower response latency for a mobile client hitting GraphQL.
- Improve build times for a static-site generator pulling from GraphQL.
- Keep mutations uncached (max-age 0 is never written).
- Keep file-upload mutations uncached (non-serializable variables are skipped).
- Toggle the whole layer off per server via the GraphQL server's caching flag.
- Add response caching without touching the graphql module's own late-stage cache.
- Memoize validated persisted query strings in a dedicated cache bin.
- Front a `core_composable` server automatically once the module is enabled.
- Adapt the pattern to a custom schema by writing your own RouteSubscriber to alter its route.
- Audit whether an access-controlled query truly varies per user before trusting the cache.
- Reduce CPU on servers where GraphQL parsing/validation dominates request time.
- Cache a query whose result carries a finite max-age so entries auto-expire.
- Support many clients issuing the same query with different variables.
- Cut origin work behind a CDN for a decoupled app.
