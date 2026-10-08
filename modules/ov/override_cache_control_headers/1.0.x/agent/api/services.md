# Mechanism, services, Drush and hook (API)

## Event subscriber — how the header is applied

Service `override_cache_control_headers_subscriber` =
`Drupal\override_cache_control_headers\EventSubscriber\OverrideCacheControlHeaders`
(args: `@config.factory`, `@state`, `@override_cache_control_headers_utility`, `@path.matcher`).

- Subscribes to `KernelEvents::RESPONSE`, method `onViewResponse`, **priority `10000`**.
- `onViewResponse()` reads config `override_cache_control_headers.settings`.`urls_header`
  (`explode(PHP_EOL, …)`, `array_filter`), merges in the active timed entries from State
  (`Utility::getTempHeadersInState()` → `processTempUrlHeaders()`), and calls `setHeaders()`.
- `setHeaders()` (private): for each `path|directives[|…]` entry it splits on `|`, matches
  `path.matcher`.`matchPath($current_uri, $path)` against the request URI, and on the **first** match
  does `$event->getResponse()->headers->set('Cache-Control', $directives)` then `return`.

Ordering with core (important when reasoning about what actually ships): this subscriber runs at
priority 10000, i.e. *before* core `FinishResponseSubscriber::onRespond` (priority 0). Core's
`onRespond` then runs and:
- for a `CacheableResponseInterface` response core computes not-cacheable (open session / logged-in /
  POST / kill-switch): core calls `setResponseNotCacheable()` and overwrites the header back to
  `no-cache, must-revalidate` — this module's value is discarded;
- for an anonymous cacheable page, or for a plain non-`CacheableResponseInterface` response, core
  sees a customized `Cache-Control` (`isCacheControlCustomized()` true) and leaves this module's value
  in place.

## Utility service — `override_cache_control_headers_utility`

`Drupal\override_cache_control_headers\Utility` implements `UtilityInterface`
(args: `@path.validator`, `@state`, `@cache_tags.invalidator`, `@config.factory`,
`@path_alias.manager`, `@language_manager`, `@module_handler`). Constants on the interface:
`SETTINGS = 'override_cache_control_headers.settings'`,
`STATE_NAME = 'override_cache_control_headers.urls_headers'`.

Key methods:
- `validateCacheControlStrings(array $lines, string $pattern_type = '')` — regex + directive-allowlist
  + internal-URL validation; returns an array of error strings (empty = valid). `$pattern_type =
  'urls_header_temp'` requires the trailing `|minutes`.
- `validateDuplicateUrls(array $urls_headers, bool $validate_config_data = FALSE)` — flags a `path`
  reused across the submitted entries, existing State entries, and (when the flag is set) the stored
  config.
- `getTempHeadersInState()` / `setTempHeadersInState(array $headers)` / `resetTempHeadersInState(array
  $headers)` / `deleteAllTempurls()` — read/write the State list. `setTempHeadersInState()` appends
  `start_ts` and `expiry_ts` (`start + minutes*60`) and fires the hook for the added URLs.
- `processTempUrlHeaders(array $entries, bool &$state_changed)` — drops entries whose `expiry_ts`
  (`$exploded[4]`) is in the past; sets `$state_changed = TRUE` when it removed any.
- `invalidateCache()` — `configFactory->reset(SETTINGS)` + invalidate cache tag
  `config:override_cache_control_headers.settings`.
- `stripLeadingCountryLanguagePrefix(string $url)` — removes a leading `/xx-yy` locale prefix.
- `triggerHook(array $urls)` — `moduleHandler->invokeAll('override_cache_control_headers', [$urls])`
  (wrapped in try/catch that swallows exceptions).

## Drush

Service `override_cache_control_headers_drush_commands`
(`Drush\Commands\OverrideCacheControlHeadersDrushCommands`, arg `@override_cache_control_headers_utility`).

- `override_cache_control_headers:set-temp-headers` (alias **`occh:set-temp-headers`**) —
  `setHeaders(string $url_headers)`. Validates the single `path|directives|minutes` argument
  (`validateCacheControlStrings(..., 'urls_header_temp')` and `validateDuplicateUrls(..., TRUE)`), then
  `setTempHeadersInState()` + `invalidateCache()`.

  ```
  drush occh:set-temp-headers "/sitemap.xml|must-revalidate, no-cache, private|10"
  drush occh:set-temp-headers "/search?category=blog|no-cache, private|15"
  ```

## Cron & the integrator hook

- `hook_cron` (`override_cache_control_headers_cron`): loads the State entries, runs
  `processTempUrlHeaders()`, and if anything expired writes the pruned list back via
  `resetTempHeadersInState()`. So timed overrides are cleaned up on cron *and* opportunistically on
  each matching response.
- `hook_override_cache_control_headers(array $url)` (declared in
  `override_cache_control_headers.api.php`): invoked (via `invokeAll`) with the list of URLs whenever
  overrides are added/set — the intended place to purge a reverse-proxy/CDN cache for those paths.

  ```php
  function mymodule_override_cache_control_headers(array $url) {
    // $url = ['/sitemap.xml', '/blog', ...] — e.g. issue a Varnish/CDN purge here.
  }
  ```
