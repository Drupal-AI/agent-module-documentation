# Hooks

There is no `cacheflush.api.php`; these hooks are discovered from the code
(`invokeAll`/`->alter` calls and the base `cacheflush.module`).

## `hook_cacheflush_tabs_options()`

Contribute clearable **options** to the preset catalog (`CacheflushApi::getOptionList()` merges all
implementations). Return an array keyed by option id; each option:

```php
function mymodule_cacheflush_tabs_options() {
  return [
    'my_thing' => [
      'description' => t('Clear my custom cache.'),
      'category' => 'vertical_tabs_functions', // which UI tab it appears under
      'functions' => [
        ['#name' => '\Drupal\cacheflush\Controller\CacheflushApi::clearBinCache', '#params' => ['cache.my_bin']],
      ],
    ],
  ];
}
```

`category` values used by the UI: `vertical_tabs_core`, `vertical_tabs_functions`,
`vertical_tabs_custom`, `vertical_tabs_often` (contrib options only shown if the providing module is
enabled). The base module implements this hook to add `static`, `asset`, `kernel`, `twig`, `plugin`,
`module`, `router`.

## `hook_cacheflush_before_clear($entity)` / `hook_cacheflush_after_clear($entity)`

Invoked (via `invokeAll`) immediately before and after a preset's functions run in
`clearPresetCache()`. `$entity` is the `cacheflush` preset. Use them to warm caches, log, or notify.

```php
function mymodule_cacheflush_after_clear($entity) {
  \Drupal::logger('mymodule')->notice('Preset @t cleared', ['@t' => $entity->getTitle()]);
}
```

## Related hooks in submodules

- `hook_cacheflush_ui_tabs()` (cacheflush_ui / cacheflush_advanced) — declares the vertical **tabs**
  (name + validation callback) the options are grouped into on the preset form.
- The advanced submodule also triggers core `hook_cache_flush()` while building its bin list.
