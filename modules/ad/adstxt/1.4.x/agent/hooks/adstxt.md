# ads.txt — hooks

Defined in `adstxt.api.php`. Implement these to append lines to the served files in addition
to the config-stored body. Both receive a cacheable-dependency object so your implementation
can register cache tags/contexts that invalidate the response.

## `hook_adstxt(RefinableCacheableDependencyInterface $metadata): array`

Return an array of strings appended to `/ads.txt`.

```php
function mymodule_adstxt(\Drupal\Core\Cache\RefinableCacheableDependencyInterface $metadata) {
  // Optionally: $metadata->addCacheTags(['mymodule:ads']);
  return [
    'greenadexchange.com, 12345, DIRECT, AEC242',
    'silverssp.com, 9675, RESELLER',
  ];
}
```

## `hook_app_adstxt(RefinableCacheableDependencyInterface $metadata): array`

Same contract, for `/app-ads.txt`.

## How additions are combined

`AdsTxtController::getResponse()` starts with the config value, then
`moduleHandler->invokeAll($hook, [$cacheable_metadata])` collects all module returns, merges
them, trims each line, filters empty strings, and joins with `\n`. If the result is empty a
cacheable 404 is returned; otherwise a `text/plain` `CacheableResponse` with the merged cache
metadata.
