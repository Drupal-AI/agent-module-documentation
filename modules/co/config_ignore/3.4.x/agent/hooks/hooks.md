# Hooks — add/alter ignore rules in code

Declared in `config_ignore.api.php`. Both let a module contribute ignore patterns dynamically
(evaluated on every import/export transform).

## `hook_config_ignore_ignored_alter(ConfigIgnoreConfig $ignored)` (preferred)
Receives the resolved `\Drupal\config_ignore\ConfigIgnoreConfig` and mutates it via
`getList($direction, $operation)` / `setList($direction, $operation, $list)` where
`$direction` ∈ `import|export`, `$operation` ∈ `create|update|delete`.

```php
function mymodule_config_ignore_ignored_alter(\Drupal\config_ignore\ConfigIgnoreConfig $ignored) {
  // Stop forcing an import for a specific config.
  $list = $ignored->getList('import', 'create');
  $list = array_filter($list, fn($line) => $line !== 'webform.webform.*');
  $ignored->setList('import', 'create', $list);
}
```

## `hook_config_ignore_settings_alter(array &$settings)` (deprecated)
Simple-list style: append plain pattern strings. Marked deprecated — use
`hook_config_ignore_ignored_alter()` instead.

```php
function mymodule_config_ignore_settings_alter(array &$settings) {
  $settings[] = 'system.site';
  $settings[] = 'field.*';
}
```

The event subscriber statically caches the hook list and clears it whenever
`config_ignore.settings` is saved.
