<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime services & middleware

Defined in `crawler_rate_limit.services.yml`. There is no public "API" you call to configure —
these are the internal pieces that enforce the limits. Useful to know for debugging/extending.

| Service id | Class | Role |
|---|---|---|
| `crawler_rate_limit.middleware` | `CrawlerRateLimitMiddleware` | `http_middleware` (priority **240**), decorates the HTTP kernel. |
| `crawler_rate_limit.manager` | `RateLimitManager` | Decides block / limit per request. |
| `crawler_rate_limit.backend_factory` | `RateLimitBackendFactory` | Builds the right `nikolaposa/rate-limit` limiter for the backend. |
| `crawler_rate_limit.crawler_detect` | `Jaybizzle\CrawlerDetect\CrawlerDetect` | Bot detection from the User-Agent. |

## Middleware flow (`CrawlerRateLimitMiddleware::handle()`)

1. `$manager->block($request)` → if the client's ASN is on `asn_blocklist`, return
   `403` with body `Blocked.` (precedence over everything).
2. `$manager->limit($request)` → if a limit is exceeded, return `429 Too many requests` with
   `Retry-After: $manager->retryAfter()`.
3. Otherwise delegate to the decorated kernel (normal Drupal response).

Because it is a middleware at priority 240 it runs **before routing/bootstrap of the page**, so
blocked/limited requests are cheap.

## `RateLimitManager` (interface `RateLimitManagerInterface`)

Public methods: `limit(Request)`, `block(Request)`, `isEnabled()`, `retryAfter()`, plus the
static `RateLimitManager::getSettings()` (merged settings, the best way to introspect config)
and static helpers `toIntOrZero()`, `defaultPathAllowlist()`.

- Identifiers: bots → `CrawlerDetect::getMatches()` (bot name); visitor → `hash('crc32c', ip .
  user-agent)`; ASN → `'asn-' . <asn>`. All limiter keys are prefixed `crawler_rate_limit:`.
- Counting is delegated to `RateLimitBackendFactory::get($backend, Rate::custom($requests,
  $interval), 'crawler_rate_limit:')`; a `RateLimit\Exception\LimitExceeded` means "limit hit".
- Fails **open**: any backend/dependency exception in `limitReached()` returns FALSE (request
  allowed), so a broken backend never takes the site down — it just stops limiting.

## `RateLimitBackendFactory`

`get($backend_name, Rate $rate, $keyPrefix)` returns a `RedisRateLimiter`/`PredisRateLimiter`
(needs the `redis` Drupal module + PhpRedis or Predis), `ApcuRateLimiter` (needs the APCu PECL
ext), or `MemcachedRateLimiter` (needs the `memcache` Drupal module + Memcached ext). Missing
prerequisites throw a `\RuntimeException` that the manager catches (→ fails open).

## Extending

There is no plugin/hook surface. To customize behavior you would decorate/replace
`crawler_rate_limit.manager` or `crawler_rate_limit.middleware` in your own module's services.
Most needs are met by the `settings.php` keys — see
[../configure/settings.md](../configure/settings.md).
