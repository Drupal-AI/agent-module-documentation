<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — VariationCache

## Service

`variation_cache_factory` (class `Drupal\variationcache\Cache\VariationCacheFactory`,
implements `VariationCacheFactoryInterface`). Constructor args: `@request_stack`,
`@cache_factory`, `@cache_contexts_manager`.

```php
/** @var \Drupal\variationcache\Cache\VariationCacheInterface $cache */
$cache = \Drupal::service('variation_cache_factory')->get('my_bin');
```

`VariationCacheFactoryInterface::get($bin)` returns (and memoizes) a
`VariationCacheInterface` wrapping the named cache bin. `$bin` is a plain bin name string
(e.g. `default`, or a custom bin); the real storage is the underlying core cache backend.

## VariationCacheInterface methods

All methods take `$keys` (a `string[]` of cache keys, not a single cid) and one or two
`\Drupal\Core\Cache\CacheableDependencyInterface` arguments. The variation is selected from
the current request's values for the cacheability's cache contexts.

- `get(array $keys, CacheableDependencyInterface $initial_cacheability)`
  — Returns the cache item object, or `FALSE` on miss. `$initial_cacheability` is the
  "pre-bubbling" cacheability (the metadata known before other systems added contexts).

- `set(array $keys, $data, CacheableDependencyInterface $cacheability, CacheableDependencyInterface $initial_cacheability)`
  — Stores `$data`. `$cacheability` is the full/folded cacheability; `$initial_cacheability`
  is the pre-bubbling cacheability. Throws `\LogicException` if `$initial_cacheability`'s
  contexts are not fully contained in `$cacheability`'s contexts. Items with max-age `0`
  are silently not stored.

- `delete(array $keys, CacheableDependencyInterface $initial_cacheability)`
  — Deletes only the **active** variation for the current request, not every variation.

- `invalidate(array $keys, CacheableDependencyInterface $initial_cacheability)`
  — Invalidates only the **active** variation for the current request.

Cache tags/max-age come from the passed `CacheableMetadata`/`CacheableDependencyInterface`
objects (build one with `new \Drupal\Core\Cache\CacheableMetadata()` and set contexts/tags/
max-age), so tag-based invalidation works as with any core backend.

## Typical pattern

```php
use Drupal\Core\Cache\CacheableMetadata;

$factory = \Drupal::service('variation_cache_factory');
$cache = $factory->get('default');
$keys = ['my_module', 'expensive_thing'];

// Pre-bubbling cacheability: what you know up front.
$initial = new CacheableMetadata();
$initial->addCacheContexts(['user.permissions']);

if ($hit = $cache->get($keys, $initial)) {
  $data = $hit->data;
}
else {
  $data = build_expensive_thing();      // may add more contexts/tags while building
  $cacheability = new CacheableMetadata();
  $cacheability->addCacheContexts(['user.permissions', 'languages:language_interface']);
  $cacheability->addCacheTags(['node_list']);
  $cache->set($keys, $data, $cacheability, $initial);
}
```

## Notes

- Under the hood, resolution walks a chain of `Drupal\variationcache\Cache\CacheRedirect`
  value objects (marked `@internal`); each redirect narrows to a more specific set of cache
  contexts until the concrete item for the current context values is found.
- This is the same service and semantics core uses for render caching and dynamic page
  cache. On Drupal 10.2+ `variation_cache_factory` is provided by core; this module's
  class name resolves to `\Drupal\Core\Cache\VariationCache` via `class_alias()`.
- Prefer injecting the service (`variation_cache_factory`) over the `\Drupal::service()`
  static call in real code.
