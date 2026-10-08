<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API / behaviour — exactly what the two services do

Both classes are `final` and marked `@internal`: *"There is no extensibility promise for
this class."* See **Extending** at the bottom for the sanctioned escape hatches.

## `CacheControlOverrideSubscriber::onRespond(ResponseEvent $event)`

Subscribed to `KernelEvents::RESPONSE` with **no explicit priority** (default `0`).
Constructor takes only `@config.factory`.

It returns early — doing nothing — when any of these hold:

1. `!$event->isMainRequest()` (sub-requests are ignored);
2. the response is not a `CacheableResponseInterface`;
3. the response has **no** `max-age` Cache-Control directive;
4. the response has **no** `public` Cache-Control directive.

Conditions 3 and 4 mean core's `FinishResponseSubscriber` must already have decided the
response is publicly cacheable — this module never makes an uncacheable response cacheable.

Then:

```php
$maxAge = (int) $response->getCacheableMetadata()->getCacheMaxAge();

if ($maxAge !== CacheBackendInterface::CACHE_PERMANENT) {   // i.e. !== -1
  if ($maxAge > 0) {
    $minimum = (int|null) config('cache_control_override.settings')->get('max_age.minimum');
    if ($minimum !== NULL)                 { $maxAge = max($minimum, $maxAge); }
    $maximum = (int|null) config(...)->get('max_age.maximum');
    if ($maximum !== NULL && $maximum !== -1) { $maxAge = min($maximum, $maxAge); }
  }
  $response->headers->set('Cache-Control', 'public, max-age=' . $maxAge);
}
```

Consequences worth remembering:

- **Bubbled `-1` (`Cache::PERMANENT`) → header untouched.** The page keeps whatever
  `system.performance:cache.page.max_age` produced.
- **Bubbled `0` → `Cache-Control: public, max-age=0`.** The clamps are skipped (they only
  run for `> 0`), so a floor cannot resurrect an uncacheable page.
- The header is **replaced wholesale** with `public, max-age=N` — other directives that
  were on it (e.g. `must-revalidate`) are dropped.
- Because the subscriber runs at priority `0` on `kernel.response`, anything that must win
  has to subscribe at a higher priority and call `$event->stopPropagation()`.

## `DenyOnCacheControlOverride::check(Response $response, Request $request): ?string`

Registered `private` and tagged `page_cache_response_policy`, so core's **Internal Page
Cache** consults it before storing a response.

```php
if (!$response instanceof CacheableResponseInterface) { return NULL; }
return $response->getCacheableMetadata()->getCacheMaxAge() === 0
  ? static::DENY
  : NULL;
```

So any response whose bubbled max-age is exactly `0` is never written to the internal page
cache. (A source comment flags that this also affects sites that rely on Internal Page
Cache without a reverse proxy — that is intentional but easy to miss.)

## Interaction map

| Layer | Effect |
|---|---|
| `system.performance:cache.page.max_age` | must be non-zero, otherwise core emits no `max-age` and this module no-ops |
| Dynamic Page Cache | unaffected (it keys on cache contexts, not this header) |
| Internal Page Cache | responses with bubbled max-age `0` are denied storage |
| Reverse proxy / CDN | sees the per-page TTL instead of the global one |

## Extending

The class docblocks name the supported options explicitly:

1. **Subscribe earlier.** Register your own `kernel.response` subscriber with a priority
   higher than `0` and call `$event->stopPropagation()` to keep this module out of it.
2. **Decorate the service.**

   ```yaml
   # mymodule.services.yml
   mymodule.cache_control_decorator:
     class: Drupal\mymodule\MyCacheControl
     decorates: cache_control_override.cache_control_override_subscriber
     arguments: ['@mymodule.cache_control_decorator.inner', '@config.factory']
   ```

3. **Replace or remove it** in a `ServiceProvider`
   (`Drupal\mymodule\MyModuleServiceProvider::alter(ContainerBuilder $container)`), e.g.
   `$container->removeDefinition('cache_control_override.page_cache_response_policy.deny_on_cache_override');`

There are no hooks, no events and no plugin type of the module's own.

## Bubbling a max-age so you can see the effect

```php
// In a controller / block / lazy builder:
$build['#cache']['max-age'] = 300;
// or on a response object:
$response->getCacheableMetadata()->setCacheMaxAge(300);
```

With the module enabled and `system.performance:cache.page.max_age` non-zero, an anonymous
request to that page returns `Cache-Control: public, max-age=300` (clamped by the two
settings), rather than the site-wide value.
