<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_cache — backend internals & the alter hook

Two classes in `src/`, wired by one service. No routes, controllers, forms, or DB access beyond
core `DatabaseBackend`.

## Service
`custom_cache.services.yml`:
```yaml
services:
  cache.backend.custom_cache:
    class: Drupal\custom_cache\CustomCacheBackendFactory
    arguments: ['@database', '@cache_tags.invalidator.checksum', '@settings']
```
The service id is what you place in `$settings['cache']['bins'][...]`.

## `CustomCacheBackendFactory` (`src/CustomCacheBackendFactory.php`)
Extends core `Drupal\Core\Cache\DatabaseBackendFactory`. Overrides only:
```php
function get($bin) {
  return new CustomCacheDatabaseBackend($this->connection, $this->checksumProvider, $bin);
}
```
So every bin assigned to the service gets a `CustomCacheDatabaseBackend` instead of core's
`DatabaseBackend`. (Note it constructs the backend with three args; the extra settings/max-rows
handling of newer core factories is not passed through.)

## `CustomCacheDatabaseBackend` (`src/CustomCacheDatabaseBackend.php`)
Extends core `Drupal\Core\Cache\DatabaseBackend`. Overrides three things; all other cache operations
(`get`, `set`, `delete*`, `invalidate*`, `garbageCollection`, tag checksums) are inherited unchanged.

### `setMultiple(array $items)` — the TTL cap + exclude list
For each incoming `$cid => $item`:
1. **Exclude (intended):** if `custom_cache_exclude_cids` is non-empty and the cid contains any
   listed substring (`strpos(...) !== FALSE`), the item is `unset()` from `$items` — the intent is
   to skip persisting it. **Accuracy note (implementation quirk):** the matching `continue` only
   breaks the *inner* exclude loop, and after `unset($items[$cid])` execution falls through to the
   cap step and `$NewItems[$cid] = $item`, so the item is still added to `$NewItems` and written.
   As written, `custom_cache_exclude_cids` does not reliably prevent the write; do not depend on it
   to protect a cid.
2. **Cap:** if `!isset($item['expire'])` or `$item['expire'] === Cache::PERMANENT`, rewrite
   `$item['expire'] = \Drupal::time()->getRequestTime() + Settings::get('custom_cache_melt_time', 86400)`.
   Finite expiries are untouched.
3. **Normalise cid:** `$cid = self::clearCid($cid);` and store under the normalised key in
   `$NewItems`.
Finally, if `$NewItems` is non-empty, delegates to `parent::setMultiple($NewItems)`.

### `getMultiple(&$cids, $allow_invalid = FALSE)` — cid normalisation on read
Maps each requested cid through `self::clearCid()` before delegating to `parent::getMultiple()`, so
reads resolve to the same normalised keys writes used.

### `clearCid($cid)` (private static) — cid normaliser + extension point
Normalises a cid, then fires an alter hook and returns it. Its final two lines are the public
contract worth knowing:
```php
\Drupal::moduleHandler()->alter('custom_cache_cid', $cid);
return $cid;
```

## `hook_custom_cache_cid_alter(&$cid)`
Any module can implement this to rewrite a cache ID immediately before it is used for a get/set on a
bin backed by `cache.backend.custom_cache`:
```php
function mymodule_custom_cache_cid_alter(&$cid) {
  // Adjust $cid as needed; it is passed by reference.
}
```
It runs on both read (`getMultiple`) and write (`setMultiple`) paths, so an alteration must be
deterministic for the same logical entry or reads and writes will not line up.

## Operating notes
- Entries live in the normal `cache_<bin>` tables; inspect/clear with the usual tooling
  (`drush cr`, `DELETE FROM cache_render`, etc.).
- The cap only bites on `CACHE_PERMANENT` writes; nothing shortens an already time-limited entry.
- Excluded cids are not written by this backend, so they will simply be recomputed on the next
  request rather than kept — the "exclude" name means "exclude from being written by custom_cache",
  not "keep forever in a separate store".
