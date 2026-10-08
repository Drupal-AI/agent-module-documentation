# Drush command & the depcalc cache

## Command

| Command | Alias | Effect |
|---|---|---|
| `depcalc:clear-cache` | `dep-cc` | Empties the depcalc cache bin (`$cache->deleteAllPermanent()`) |

Class `Drupal\depcalc\Commands\DepcalcCommands` (drush service `depcalc.commands`, arg
`@cache.depcalc`). Example: `drush depcalc:clear-cache` → "Cleared depcalc cache."

## The cache bin

- Service `cache.depcalc` → `Drupal\depcalc\Cache\DepcalcCacheBackend` (decorates a database
  backend; DB table `cache_depcalc`).
- It is **tag-aware** and, unlike normal bins, **`deleteAll()` is a no-op** — a routine
  `drush cr` / "Clear all caches" does NOT clear it (by design, so expensive dependency data
  persists). Only `deleteAllPermanent()` (the Drush command, or the `depcalc_ui` button) or
  targeted tag invalidation empties it.
- Invalidation: `invalidateTags()` matches UUID tags; the `InvalidateDepcalcCache` subscriber
  and the `depcalc_invalidate_dependencies` / `invalidate_depcalc_cache` events handle
  cascading invalidation when entities change.

Inspect / clear from PHP or SQL:

```php
\Drupal::service('cache.depcalc')->deleteAllPermanent();          // clear
$n = \Drupal::database()->query('SELECT COUNT(*) FROM {cache_depcalc}')->fetchField();  // count rows
```
