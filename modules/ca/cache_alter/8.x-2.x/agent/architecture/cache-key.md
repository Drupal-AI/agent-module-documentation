<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CacheAlter — anonymous page-cache key rewriting

Everything the module does lives in three files. There is no config, so "operating" it is just
enabling/disabling the module (`drush en cache_alter` / `drush pmu cache_alter`) and, optionally,
having your front end set a `cache_context` cookie.

## Install / enable

- `drush en cache_alter -y`. No config form, no permissions, no schema.
- Core requirement `^10 || ^11` (`cache_alter.info.yml`). No composer requirements.
- The info.yml declares no module dependencies, yet `CacheAlter` `extends` the **page_cache**
  module's `PageCache` class and the service provider swaps `http_middleware.page_cache`. If the
  core Internal Page Cache module is **not** enabled, that service is absent — the service
  provider's try/catch swallows it and no swap occurs, so the cookie-key feature is a no-op. The
  UTM-stripping middleware (`ClearRequest`) does not depend on page_cache and runs regardless.

## Middleware 1 — ClearRequest (UTM/click-id stripping)

Registered in `cache_alter.services.yml`:

```
cache_alter.clear_request:
  class: Drupal\cache_alter\StackMiddleware\ClearRequest
  tags:
    - { name: http_middleware, priority: 450 }
```

- Priority **450** > core page_cache's **200**, so `ClearRequest` wraps page_cache and mutates the
  request *before* the cache id is computed and before the kernel renders.
- `handle()` runs `fixServer($request)` then `fixQuery($request)` and forwards to
  `$this->httpKernel->handle(...)`.
- `queryMask` (constructor): `utm_source, utm_medium, utm_campaign, utm_term, utm_content, gclid,
  yclid, ysclid`. Matching is case-insensitive (`strtolower`).
- `fixQuery()` removes masked keys from the `$request->query` ParameterBag, so downstream Drupal
  (routing, `dynamic_page_cache`, render cache) never sees them.
- `fixServer()` re-parses `REQUEST_URI` (`parse_url` → `getRequestPath` + `getQueryString`), drops
  masked keys from the query (`parse_str` → filter → `http_build_query`), and writes back
  `REQUEST_URI` and `QUERY_STRING`. `http_build_query` re-encodes/normalizes the surviving params.
- Net effect: two URLs identical except for UTM/click-id params resolve to the same cleaned URI and
  therefore the same page-cache entry — better hit rate for campaign/ad traffic.

## Middleware 2 — CacheAlter (cookie-varied cache id)

- `CacheAlterServiceProvider::alter()` replaces the class of `http_middleware.page_cache` with
  `CacheAlter` (only `getCacheId()` is overridden; all other PageCache behavior is inherited).
- Overridden `getCacheId(Request $request)` builds:
  - `getSchemeAndHttpHost() . server->get('REQUEST_URI')` (the URI already cleaned by ClearRequest),
  - `getRequestFormat(NULL)`,
  - `cookies->get('cache_context')`,
  - joined with `:`.
- So the anonymous static cache varies by the `cache_context` cookie. Typical use: a front-end
  "choose your city" control sets `cache_context=<city>`, and each value gets its own cached HTML.

## Operating notes / correctness caveats

- **Anonymous only.** `page_cache` caches responses for anonymous users; logged-in users bypass it
  entirely, so the cookie-key variation never applies to them.
- **Consistency with the render cache.** `getCacheId()` varies the *page* cache on the cookie, but
  the upstream `dynamic_page_cache`/render cache do **not** know about the `cache_context` cookie
  unless your blocks/theme declare a matching `cookies:cache_context` cache context. Without that,
  the first-rendered variant can be reused across cookie values before the page cache stores it —
  the two layers can disagree. Add the appropriate render cache context if per-cookie content must
  be correct, not just per-page-cache.
- **Cardinality.** Each distinct `cache_context` cookie value multiplies the number of stored page
  entries; keep the value set small (low cardinality).
- **UTM stripping assumes UTM does not affect output.** Since masked params are removed before
  rendering, any code that reads them from the query (server-side analytics, param-driven content)
  will no longer see them. Client-side analytics reading `document.location` are unaffected.
- The mask is hard-coded; adding a parameter requires patching `ClearRequest::$queryMask`.
