# Presets & the clear routes

## Ready-made routes (base module)

| Route | Path | Controller | Permission |
|---|---|---|---|
| `cacheflush.presets` | `/admin/cacheflush` | SystemController admin menu block | `cacheflush clear cache` |
| `cacheflush.presets.clearall` | `/admin/cacheflush/clear/all` | `CacheflushApi::clearAll` | `cacheflush clear cache` |
| `cacheflush.presets.clear_id` | `/admin/cacheflush/clear/{cacheflush}` | `CacheflushApi::clearById` | `cacheflush clear cache` (cacheflush_ui's route subscriber additionally sets `_entity_access: cacheflush.clear`) |

`clearAll()` calls `drupal_flush_all_caches()`, shows a message, logs the clear with the acting
username, and redirects back. `clearById()` runs the preset's `clearPresetCache()`.

## What a preset is

A preset is a **`cacheflush` content entity** (base table `cacheflush`, provided by
`cacheflush_entity`). Relevant fields: `title`, `status` (1 = published/enabled; a disabled preset
throws 403 when cleared), `data` (a serialized map of the selected clear options), plus `menu`
(added by cacheflush_ui) and `cron` (added by cacheflush_cron).

`data` is a map keyed by option id; each option has a `functions` array of
`['#name' => <callable>, '#params' => [...]]` entries. Example (clear the render bin):

```php
[
  'render' => [
    'functions' => [
      ['#name' => '\Drupal\cacheflush\Controller\CacheflushApi::clearBinCache', '#params' => ['cache.render']],
    ],
  ],
]
```

`clearPresetCache($entity)` checks the entity is enabled, invokes `hook_cacheflush_before_clear`,
iterates `data`'s functions calling each `#name` with `#params` (via `call_user_func_array`, warning
if not callable), then invokes `hook_cacheflush_after_clear`.

## The option catalog (`getOptionList()`)

`CacheflushApi::getOptionList()` = `createTabOptions()` (one entry per registered **cache bin** from
the `cache_bins` container parameter, each mapped to `clearBinCache(<service_id>)`, categorised
core vs custom) **merged** with every `hook_cacheflush_tabs_options()` implementation. The base
module (`cacheflush.module`) contributes these function-style options:

| Option | Clears |
|---|---|
| `static` | `drupal_static_reset()` |
| `asset` | css/js collection optimizers + `_drupal_flush_css_js()` |
| `kernel` | invalidate the container |
| `twig` | `clearStorageCache('twig')` — wipe Twig PHP storage |
| `plugin` | `plugin.cache_clearer` clearCachedDefinitions |
| `module` | `clearModuleCache()` (rebuild module/theme data) |
| `router` | `router.builder` rebuild |

## Build a preset programmatically

```php
$e = \Drupal::entityTypeManager()->getStorage('cacheflush')->create(['title' => 'Render only', 'status' => 1]);
$e->setData([
  'render' => ['functions' => [
    ['#name' => '\Drupal\cacheflush\Controller\CacheflushApi::clearBinCache', '#params' => ['cache.render']],
  ]],
]);
$e->save();
// Then clear it: \Drupal::service('cacheflush.api')->clearById($e);
```

`setData()` serialises the array into the `data` map field; `getData()` returns it back. The normal
way to build presets is the **cacheflush_ui** form at `/admin/structure/cacheflush/add`, which
renders the option catalog as checkboxes across vertical tabs.
