<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CacheAlter (cache_alter) — agent index

Two HTTP stack middlewares that rewrite the **anonymous page-cache key**. No admin UI, routes,
permissions, config, DB, external calls, or output. Package `Performance and scalability`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 8.x-2.2. (info.yml declares **no**
`dependencies`, but `CacheAlter` extends the core **page_cache** module's class — see below.)

- **How the two middlewares rewrite the cache key, load order, and operational caveats** →
  [architecture/cache-key.md](architecture/cache-key.md)

## What it actually is (from source)

- `CacheAlterServiceProvider::alter()` (`src/CacheAlterServiceProvider.php`) fetches the
  `http_middleware.page_cache` service definition (in a try/catch that swallows a missing
  service) and, if present, calls `setClass()` to replace it with
  `Drupal\cache_alter\StackMiddleware\CacheAlter`.
- `CacheAlter` (`src/StackMiddleware/CacheAlter.php`) extends core
  `Drupal\page_cache\StackMiddleware\PageCache` and overrides **`getCacheId()`** only. The cid
  becomes `implode(':', [schemeAndHttpHost . REQUEST_URI, requestFormat, cookie 'cache_context'])`.
  So the anonymous page cache now varies by the client-sent `cache_context` cookie.
- `ClearRequest` (`src/StackMiddleware/ClearRequest.php`) is a separate `http_middleware`
  registered in `cache_alter.services.yml` at **priority 450** (runs outside/before core
  page_cache at 200). `handle()` calls `fixServer()` then `fixQuery()` and forwards to the
  decorated kernel. It strips a fixed `queryMask` — `utm_source, utm_medium, utm_campaign,
  utm_term, utm_content, gclid, yclid, ysclid` (case-insensitive) — from `$request->query` and
  rebuilds `REQUEST_URI`/`QUERY_STRING` via `parse_url` + `parse_str` + `http_build_query`.

## Provides

- Services: `cache_alter.clear_request` (http_middleware, priority 450). Plus the class-swap of
  `http_middleware.page_cache` via the service provider.
- No entities, plugins, routes, permissions, hooks, forms, Drush, config schema, or libraries.

## Key facts for agents

- Affects **only** the anonymous `page_cache` (Internal Page Cache). Authenticated users bypass
  that cache, so the cookie-key change does not apply to them.
- The `queryMask` list is **hard-coded**; there is no setting to add/remove parameters.
- The cookie-key half is inert unless the core **page_cache** module is enabled (its class must
  exist and its middleware service must be registered for the swap to happen).
