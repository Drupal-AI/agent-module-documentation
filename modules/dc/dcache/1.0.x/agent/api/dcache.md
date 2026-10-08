<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DCache developer API

## Building a chain
```php
$dcache = \Drupal::service('dcache.factory')
  ->get($memoryBackend, $persistentBackend);
// or inject the prebuilt service:
$dcache = \Drupal::service('dcache.bin.default_memory_persistent');
```
Backends are tried in the order given (fastest first).

## Single item
Implement `CacheItemGeneratorInterface` (`getCacheId()`, `getCacheTags()`, `getData()`), then:
```php
$value = $dcache->lookupOrGenerate($generator);
```
`DCache::doLookupOrGenerate()` checks each backend for `getCacheId()`; on a miss it recurses to the next tier and finally calls `getData()`, writing the result back into every tier with `Cache::PERMANENT` and the generator's tags.

## Multiple items
Implement `CacheItemListGeneratorInterface` (`getCacheIds()`, `withCacheIds()`, `generateCacheItemList()`), then:
```php
$list = $dcache->lookupOrGenerateMultiple($listGenerator);  // returns CacheItemList
```
Found ids are served from the current backend; the still-missing ids are passed down the chain via `withCacheIds()` and merged back with `CacheItemList::extend()`, then written up with `setMultiple()`.

## Notes
- Values are stored permanently and invalidated via the cache tags you return.
- No configuration or routes — this is a service-only API for module developers.
