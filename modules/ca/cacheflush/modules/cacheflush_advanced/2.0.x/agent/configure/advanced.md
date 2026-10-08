# The "Custom (advanced)" tab

## What it adds to the preset form

`cacheflush_advanced` implements `hook_cacheflush_ui_tabs()` returning one tab:

```php
'vertical_tabs_advance' => [
  'name' => t('Custom (advanced)'),
  'validation' => 'cacheflush_advanced_tab_validation',
  'weight' => -50,
],
```

and alters both the add and edit preset forms (`hook_form_cacheflush_add_form_alter()` /
`hook_form_cacheflush_edit_form_alter()` → `_cacheflush_advanced_form()`) to render inside that tab:

- an **AJAX table** (`cacheflush_advanced_table`) where each row = a **Cache ID** textfield (`cid`)
  and a **Service** select (`table`) listing the available cache bins (from `Cache::getBins()`), with
  Add-row / Remove-row AJAX buttons; and
- a **Cache tags** textfield (comma-separated).

## How selections are stored (preset `data`)

On save, `cacheflush_advanced_tab_validation()` writes into the preset's `data`:

- For each completed row (both cid and a real service chosen):
  ```php
  $data['advanced']['functions'][$key] = [
    '#name'   => '\Drupal\cacheflush\Controller\CacheflushApi::clearBinCache',
    '#params' => [<bin_service_id>, 'delete', <cid>],   // delete that cid from that bin
  ];
  ```
- For the cache-tags field (if non-empty):
  ```php
  $data['cache_tags']['functions'][0] = [
    '#name'   => '\Drupal\cacheflush\Controller\CacheflushApi::clearCacheTags',
    '#params' => ['<comma,separated,tags>'],            // Cache::invalidateTags(explode(','...))
  ];
  ```

Validation errors: a row with a cid but no service → "Service is required!"; a service with no cid →
"Cache ID is required!".

## When the preset runs

`clearPresetCache()` iterates all `data` functions, so the advanced cid deletions
(`clearBinCache($service_id, 'delete', $cid)`) and the tag invalidations (`clearCacheTags($tags)`)
run alongside any standard options selected on the other tabs.

Build equivalently in code by adding those `advanced` / `cache_tags` entries to the preset's data:

```php
$e->setData([
  'cache_tags' => ['functions' => [[
    '#name' => '\Drupal\cacheflush\Controller\CacheflushApi::clearCacheTags',
    '#params' => ['node_list'],
  ]]],
]);
```
