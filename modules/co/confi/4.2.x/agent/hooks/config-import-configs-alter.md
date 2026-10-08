<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook — `hook_config_import_configs_alter`

An **extension point the module invokes** (declared in `config_import.api.php`). Implement it to
build a denylist of config objects that `config_import.importer` must never import. During
`ConfigImporterService::importConfigs()`, the service calls
`$this->moduleHandler->alter('config_import_configs', $configs)` in its `filter()` step and
deletes every listed name from the temporary storage before the diff/import runs — so those
configs are protected from being changed or deleted by any granular import.

```php
/**
 * Implements hook_config_import_configs_alter().
 *
 * Prevent these config objects from being imported.
 *
 * @param string[] $configs
 *   A list of configuration names restricted from importing.
 */
function mymodule_config_import_configs_alter(array &$configs) {
  $configs[] = 'action.settings';
  $configs[] = 'system.site';
}
```

- `$configs` is a flat, additive list of config object names (no `.yml` suffix). Append to it.
- Applies to every `importConfigs()` call site-wide; there is no per-call override.
- See `ConfigImporterService::filter()` for the exact deletion loop.
