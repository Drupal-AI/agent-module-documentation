# How headers are emitted

One service does all the work: `s_max_age_event_subscriber`
(`Drupal\http_cache_control\EventSubscriber\CacheControlEventSubscriber`), constructed with
`@config.factory`. It subscribes to `KernelEvents::RESPONSE` at **priority -10** via
`setHeaderCacheControl(ResponseEvent $event)`. There are no public methods to call and no
hooks to implement — behaviour is driven entirely by `http_cache_control.settings`.

## Order of operations in `setHeaderCacheControl()`

1. **Vary** — if `cache.http.vary` is non-empty, each comma-separated header name is appended
   to the response `Vary`, plus `Cookie` unless `Settings::get('omit_vary_cookie')` is TRUE.
   This runs **before** the cacheability check, so `Vary` is applied even to uncacheable
   responses.
2. **Cacheability gate** — `if (!$response->isCacheable()) return;`. Everything below only
   applies to responses Drupal already considers cacheable (typically anonymous page-cache
   hits). Authenticated/dynamic responses (`no-cache, private`) are left untouched.
3. **`s-maxage`** — chosen by status code:
   - `404` → `cache.http.404_max_age`
   - `302` → `cache.http.302_max_age`
   - `301` → `cache.http.301_max_age`
   - otherwise → `cache.http.s_maxage`

   Applied via `$response->setSharedMaxAge($sMaxAge)` only when `$sMaxAge > 0`, it differs from
   the response's current max-age, and no `s-maxage` directive is already set.
4. **Non-error extras** (only when status `< 400`):
   - `must-revalidate`, `no-cache`, `no-store` — added when their bool config is truthy.
   - `stale-if-error=N` from `cache.http.stale_if_error` when `> 0`.
   - `stale-while-revalidate=N` from `cache.http.stale_while_revalidate` when `> 0`.
   - `Surrogate-Control` — built from `cache.surrogate.nostore` (`no-store`) and
     `cache.surrogate.maxage` (`max-age=N`), joined with `, `.
5. **Targeted headers** — for each `cache.targeted.items` entry, emit `{target}-Cache-Control`
   with a directive string. Note these are set inside the cacheable branch but are **not**
   gated by the `< 400` check.

## Targeted header value builder

`buildTargetedCacheControlHeaderValue()` assembles directives in this order:
`visibility` (`public`/`private`) → `no-cache` → `max-age=N` (only if `> 0`) →
`must-revalidate` → `no-store` → `no-transform` → `proxy-revalidate`.
`getTargetedCacheControlHeaderName()` trims a trailing `-Cache-Control`, validates the prefix
against `^[A-Za-z0-9][A-Za-z0-9-]*$` (guards against header injection), and returns
`{prefix}-Cache-Control` or NULL (item skipped) if invalid.

## Verifying live

```bash
# emitted headers on an anonymous, cacheable request:
curl -sI https://module-documentor.ddev.site/ | grep -iE 'cache-control|surrogate|vary'
```

If a directive doesn't appear, confirm the response is actually cacheable (anonymous, page
cache enabled) — the subscriber returns early otherwise.
