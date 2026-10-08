# Hooks

Documented in `editoria11y.api.php`. Both let you customize the configuration handed to the
front-end checker; add cacheability metadata so responses vary/expire correctly.

### `hook_editoria11y_alter_config(array &$attach, CacheableMetadata $cacheableMetadata)`
Alter the per-page config attached to the page (drupalSettings) when the checker loads.

```php
function mymodule_editoria11y_alter_config(array &$attach, CacheableMetadata $meta) {
  $attach['editoria11y']['ignoreElements'] .= ', .my-widget';
  $meta->addCacheContexts(['route']);
}
```

### `hook_editoria11y_alter_global_config(array &$data, CacheableMetadata $cacheMetadata)`
Alter the global config returned by the `/editoria11y/api/config` endpoint (applies site-wide
rather than per attachment).

```php
function mymodule_editoria11y_alter_global_config(array &$data, CacheableMetadata $meta) {
  $data['contentRoot'] = '#app-root';
}
```

Use these to inject dynamic selectors, per-role tuning, or context-specific test toggles
without changing saved settings.
