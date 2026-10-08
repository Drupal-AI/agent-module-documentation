<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# guzzle_cache — developer API (manual wiring)

Use the base module when you want to cache a **specific** Guzzle client rather than all of
Drupal's outbound traffic. The class you touch is `Drupal\guzzle_cache\DrupalGuzzleCache`.

## The adapter

`DrupalGuzzleCache` implements `Kevinrob\GuzzleCache\Storage\CacheStorageInterface` and stores
Guzzle `CacheEntry` objects in a Drupal `CacheBackendInterface`.

```php
public function __construct(
  CacheBackendInterface $cache,      // any Drupal cache bin
  $prefix = 'guzzle:',               // cid prefix, max 191 chars
  array $tags = [],                  // cache tags applied to every saved item
  ?TimeInterface $time = NULL,       // used only by __invoke()'s MemoryBackend
);
```

Behaviour:

- `fetch($key)` → `$cache->get($prefix.$key)?->data` (a `CacheEntry`) or `NULL`.
- `save($key, CacheEntry $data)` → `$cache->set($prefix.$key, $data, $data->getStaleAt()->getTimestamp(), $tags)`.
  Expiry is the Guzzle-computed stale-at time, so Drupal expires the item in step with the HTTP
  freshness lifetime.
- `delete($key)` → `$cache->delete($prefix.$key)`.
- Prefix longer than 191 chars throws `\InvalidArgumentException` (keeps the cid within Drupal's
  255-char limit alongside the ~64-char Guzzle key).

## Two integration shapes

### 1. Build your own HandlerStack

```php
use GuzzleHttp\Client;
use GuzzleHttp\HandlerStack;
use Kevinrob\GuzzleCache\CacheMiddleware;
use Kevinrob\GuzzleCache\Strategy\PrivateCacheStrategy;
use Drupal\guzzle_cache\DrupalGuzzleCache;

$stack = HandlerStack::create();
// Prefer a dedicated bin so this cache is managed independently of cache.default.
$cache = new DrupalGuzzleCache(\Drupal::service('cache.my_http_cache'), 'myapi:', ['myapi']);
$stack->push(new CacheMiddleware(new PrivateCacheStrategy($cache)), 'cache');

$client = new Client(['handler' => $stack]);
$response = $client->request('GET', 'https://api.example.com/things');
```

Defining a dedicated bin in a `*.services.yml`:

```yaml
cache.my_http_cache:
  class: Drupal\Core\Cache\CacheBackendInterface
  tags:
    - { name: cache.bin }
  factory: cache_factory:get
  arguments: [my_http_cache]
```

### 2. Use the object as a middleware directly

`DrupalGuzzleCache` is invokable. Calling it returns a ready `CacheMiddleware` whose storage is a
`BackendChain` — an in-request `MemoryBackend` (so repeated identical calls within one request
skip the persistent lookup) in front of the injected Drupal backend:

```php
$factory = new DrupalGuzzleCache(\Drupal::service('cache.my_http_cache'), 'myapi:', [], \Drupal::service('datetime.time'));
$middleware = $factory();          // CacheMiddleware instance
$stack->push($middleware, 'cache');
```

This is the exact mechanism the `guzzle_cache_middleware` submodule relies on to register the
adapter as a tagged `http_client_middleware`.

## Keying, bins and freshness — operational notes

- Kevinrob's `PrivateCacheStrategy` derives its primary storage key from the **request method and
  URI**. Additional request headers only enter the key when the upstream response advertises a
  matching `Vary` header (a second, header-qualified key is then stored and matched on fetch).
- The strategy is a *private-client* cache and will store `Cache-Control: private` responses; its
  own docblock warns to "pay attention to share storage between application with caution." Choose
  the cache bin deliberately: a bin is shared across every request and user on the site.
- For endpoints that must not be reused across callers, ensure the upstream sets an appropriate
  `Vary` (or `no-store`) — otherwise scope caching to a client dedicated to that integration, or
  do not cache it. Expiry follows the response's own freshness (`max-age`/`Expires`); a response
  with no freshness directive is stored already-stale and is only reused after revalidation.
- Tags let you invalidate a subsystem's HTTP cache together with its other cache tags. Everything
  clears on a full cache rebuild (`drush cr`).
