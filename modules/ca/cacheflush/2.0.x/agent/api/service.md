# The `cacheflush.api` service

Service id **`cacheflush.api`**, class `Drupal\cacheflush\Controller\CacheflushApi` (a
`ControllerBase` that is also registered as a service). Inject it or
`\Drupal::service('cacheflush.api')`.

| Method | Purpose |
|---|---|
| `clearAll()` | `drupal_flush_all_caches()`, message, log with username, redirect. (Route controller.) |
| `clearById(CacheflushEntity $cacheflush)` | Run a preset then redirect. (Route controller.) |
| `clearPresetCache(CacheflushEntity $entity)` | Core engine: checks the preset is enabled, invokes `cacheflush_before_clear`, calls each stored `#name`/`#params` function, invokes `cacheflush_after_clear`. |
| `getOptionList()` | Catalog of clearable options: cache bins + `hook_cacheflush_tabs_options()`. |
| `createTabOptions()` | Builds one option per `cache_bins` service (core vs custom category). |
| `clearBinCache($service_id, $function = 'deleteAll', $cid = NULL)` | `\Drupal::service($service_id)->{$function}($cid)` — clear a cache bin (or delete a specific `$cid`). |
| `clearStorageCache($type, $function = 'deleteAll')` | `PhpStorageFactory::get($type)->{$function}()` — e.g. wipe Twig storage. |
| `clearModuleCache()` | Invalidate container + rebuild module/theme data and kernel. |
| `clearCacheTags($tags)` | `Cache::invalidateTags(explode(',', $tags))`. |
| `coreBinMapping()` | List of core bin names used to categorise options. |

Notes:
- The option functions stored in presets use static-method callables like
  `'\Drupal\cacheflush\Controller\CacheflushApi::clearBinCache'` with `#params`; they are invoked via
  `call_user_func_array`.
- `clearBinCache` can pass a non-default method: e.g. `['kernel', 'invalidateContainer']` or
  `['router.builder', 'rebuild']` (see the base `hook_cacheflush_tabs_options`).
- Clearing a **disabled** preset (`status == 0`) throws a 403 `HttpException`; a missing entity → 404.

```php
$api = \Drupal::service('cacheflush.api');
$api->clearBinCache('cache.render');                 // clear render bin
$api->clearStorageCache('twig');                     // wipe Twig PHP storage
$api->clearCacheTags('node:1,node_list');            // invalidate tags
```
