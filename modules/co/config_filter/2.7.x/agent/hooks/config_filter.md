# Hooks

The module ships no `.api.php`, but its plugin manager calls one alter hook.

## `hook_config_filter_info_alter(array &$definitions)`

Registered via `$this->alterInfo('config_filter_info')` in `ConfigFilterPluginManager`. Lets you
modify discovered `ConfigFilter` plugin definitions before they are used — change `weight`,
flip `status`, adjust `storages`, or remove a filter entirely.

```php
/**
 * Implements hook_config_filter_info_alter().
 */
function mymodule_config_filter_info_alter(array &$definitions) {
  if (isset($definitions['some_filter'])) {
    $definitions['some_filter']['status'] = FALSE;   // disable it
    $definitions['some_filter']['weight'] = 100;     // run it last
  }
}
```

Each definition is the parsed `@ConfigFilter` annotation (`id`, `label`, `weight`, `status`,
`storages`); an empty `storages` has already been defaulted to `['config.storage.sync']` by the
manager.
