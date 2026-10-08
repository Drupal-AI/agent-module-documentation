<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the Cache-Control header is computed & how to extend it

## The subscriber

`Drupal\ape\EventSubscriber\ApeSubscriber` subscribes to `KernelEvents::RESPONSE` at priority
**-1024** (runs after core's FinishResponseSubscriber). `onRespond()`:

1. Skips sub-requests and any response that is not a `CacheableResponseInterface`
   (e.g. `JsonResponse` is left alone).
2. `$maxAge = ape_cache_set();` — if something pre-set an age (see below), use it as the base.
3. If no pre-set age: evaluate the `request_path` condition against `ape.settings.alternatives`.
   Match → `lifetime.alternatives`; otherwise → `system.performance` `cache.page.max_age`.
4. **Status-code overrides** (these win over the above):
   - `301` → `lifetime.301`
   - `302` → `lifetime.302`
   - `403` → `0` (always; never cache access-denied)
   - `404` → `lifetime.404`
5. Run the alter hook `hook_ape_cache_alter($maxAge, $originalMaxAge)`.
6. `setCacheHeader()`: if the request/response are cacheable (request policy ALLOW, response
   policy not DENY) **and** `maxAge > 0` → `Cache-Control: public, max-age=<maxAge>`; else
   `Cache-Control: no-cache, must-revalidate`.

## Exclusions (response policy)

`Drupal\ape\PageCache\ExcludePages` is tagged `page_cache_response_policy`. It returns
`ResponsePolicyInterface::DENY` when the current path matches `ape.settings.exclusions`
(via the `request_path` condition), so those pages are never stored in the page cache — which
also makes the subscriber emit `no-cache, must-revalidate` for them.

## Extension points

### `ape_cache_set($new_age = NULL): int`
A `drupal_static`-backed helper in `ape.module`. Call it **before** the response event to force
a base max age for the current request (the subscriber uses it as the starting value). This is
how the Rules integration injects a value. Called with no argument it returns the current value.

### `hook_ape_cache_alter(&$max_age, $original_max_age)`
Invoked via `$moduleHandler->alter('ape_cache', $maxAge, $originalMaxAge)` right before the
header is written. Adjust `$max_age` by reference for logic that config can't express:

```php
/**
 * Implements hook_ape_cache_alter().
 */
function mymodule_ape_cache_alter(&$max_age, $original_max_age) {
  // Halve cache time when a global "sale" flag is on.
  if (\Drupal::state()->get('mysite.sale_active')) {
    $max_age = (int) ($max_age / 2);
  }
}
```

## Services

- `ape.subscriber` (`ApeSubscriber`) — the RESPONSE event subscriber above.
- `ape.page_cache_response_policy.exclude_pages` (`ExcludePages`) — the exclusion policy.

No Drush commands, no plugin types, no custom entities.
