<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Guzzle Cache Backend gives Kevinrob's Guzzle caching middleware a Drupal-backed store, so responses to outbound HTTP requests are cached in a Drupal cache backend following the HTTP caching model instead of being refetched on every call.

---

The common performance problem with an outbound integration is that a block or service calls a remote API on every render, so the site's latency becomes the API's latency added to its own. The usual fix is to cache the parsed result in `cache.default` with a fixed lifetime, but that throws away what the HTTP response already told you: its `Cache-Control` directives, its `ETag` and its `Last-Modified`, and therefore the ability to revalidate cheaply with a conditional request rather than refetching. This module bridges the two worlds. The base module provides `DrupalGuzzleCache`, an adapter implementing Kevinrob's `CacheStorageInterface` that stores Guzzle `CacheEntry` objects in any Drupal `CacheBackendInterface` (keys prefixed `guzzle:`, expiry taken from the entry's stale-at timestamp, optional cache tags). You wire it manually by wrapping it in a `CacheMiddleware(new PrivateCacheStrategy($cache))` and pushing that onto a Guzzle `HandlerStack` — typically against a dedicated cache bin. The class is also invokable, returning a ready-built `CacheMiddleware` (a `BackendChain` of an in-request `MemoryBackend` in front of the persistent Drupal backend), which is what lets it be registered as an `http_client_middleware`. Enabling the `guzzle_cache_middleware` submodule does exactly that: it registers the `guzzle_cache.middleware` service against `cache.default` and tags it so that every request made through Drupal's shared `http_client` (`\Drupal::httpClient()`) is cached automatically. The `PrivateCacheStrategy` follows RFC 7234 — it honours `no-store`, treats `no-cache` as needing revalidation, uses `max-age`/`Expires` for freshness, matches on `Vary`, and only stores cacheable status codes — so cache entries live alongside the rest of the site's cache (Redis/Memcached/database), clear on a cache rebuild, and are visible to the same tooling. Version 3.1.0 on core `^10 || ^11`, no Drupal dependencies, requiring the `kevinrob/guzzle-cache-middleware` PHP library.

---

- Cache the responses of outbound HTTP/API calls made through Guzzle.
- Stop a block or service from calling a remote API on every page render.
- Honour a remote API's own `Cache-Control`, `ETag` and `Last-Modified` instead of a hardcoded TTL.
- Revalidate a cached response with a conditional request instead of a full refetch.
- Store cached HTTP responses in the site's Redis or Memcached backend.
- Clear all cached API responses as part of a normal `drush cr` cache rebuild.
- Automatically cache every `\Drupal::httpClient()` request by enabling `guzzle_cache_middleware`.
- Wire caching onto a specific Guzzle client only, via a manual `HandlerStack`.
- Route HTTP caching to a dedicated cache bin, managed independently of `cache.default`.
- Reduce latency on a page that aggregates a slow third-party service.
- Cut outbound request volume and cost against a metered or rate-limited API.
- Cache a slowly-changing feed such as weather, currency rates or exchange data.
- Add resilience so brief upstream slowness does not stall page rendering.
- Reduce load on a partner's service during traffic spikes.
- Speed up a decoupled/JSON data fetch that repeats across requests.
- Tag cached HTTP entries so they can be invalidated with the rest of a subsystem's tags.
- Share a cached response across requests via an in-memory-plus-persistent backend chain.
- Keep an in-request `MemoryBackend` in front of the persistent store to avoid repeat lookups within one request.
- Give the Kevinrob Guzzle cache middleware a Drupal-native storage adapter.
- Monitor HTTP-response caching with the same tools already watching Drupal's cache.
