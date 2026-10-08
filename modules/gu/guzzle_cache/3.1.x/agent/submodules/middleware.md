<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# guzzle_cache_middleware — automatic site-wide HTTP caching

The `guzzle_cache_middleware` submodule turns the base adapter into a global middleware, so that
**every** request made through Drupal's shared `http_client` service (`\Drupal::httpClient()`,
i.e. the autowired `GuzzleHttp\ClientInterface`) is cached — no per-client wiring required.

## What it does

`modules/guzzle_cache_middleware/guzzle_cache_middleware.services.yml`:

```yaml
services:
  guzzle_cache.middleware:
    class: \Drupal\guzzle_cache\DrupalGuzzleCache
    arguments: ['@cache.default', 'guzzle:', [], '@datetime.time']
    tags:
      - { name: http_client_middleware }
```

- Drupal collects services tagged `http_client_middleware` and pushes them onto the handler stack
  of the container's `http_client`. Because `DrupalGuzzleCache` is invokable and its `__invoke()`
  returns a `CacheMiddleware`, the tag wires HTTP caching into every `http_client` request.
- Storage bin: **`cache.default`** (the shared default cache bin — the `cache_default` table, or
  Redis/Memcached if configured). Key prefix `guzzle:`. No cache tags. The `datetime.time` service
  feeds the in-request `MemoryBackend` in the backend chain.
- Strategy: `PrivateCacheStrategy` (RFC 7234) — see the caching-semantics section of
  [`../start.md`](../start.md).

## Enabling

```
drush en guzzle_cache_middleware -y
```

The base `guzzle_cache` module alone registers **no** service and changes no runtime behaviour —
it only ships the `DrupalGuzzleCache` class for manual use. Automatic caching happens only once
this submodule is enabled (or you wire the adapter yourself; see [`../api/developer.md`](../api/developer.md)).

## Scope and consequences

- This is **global**: core subsystems, contrib modules and your own code that fetch over
  `\Drupal::httpClient()` will all have their responses cached according to each response's HTTP
  caching headers. Only responses the upstream marks cacheable (freshness via `max-age`/`Expires`,
  cacheable status codes, not `no-store`) are actually reused.
- Cached entries share the site-wide `cache.default` bin and clear on `drush cr`.
- Because caching is keyed on request method + URI (headers enter the key only via the response's
  `Vary`), pick this submodule when your outbound traffic is dominated by cacheable, non-caller-
  specific GETs. Where responses differ per caller or per credential and the upstream does not
  advertise a matching `Vary`, prefer manual per-client wiring (base module) so caching is scoped
  to the integration you intend, rather than applied to all of `http_client`.
