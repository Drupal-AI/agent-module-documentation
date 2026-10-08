# config_update services

Three injectable services. Inject by id or `\Drupal::service(...)`.

## `config_update.config_list` — `ConfigListByProviderInterface` (`ConfigListerWithProviders`)
Enumerate and attribute configuration.
- `listTypes()` → array of config entity type definitions.
- `getType($name)` / `getTypeByPrefix($prefix)` / `getTypeNameByConfigName($name)` — resolve a config type.
- `listConfig($list_type, $name)` — list config for a `type`/`module`/`theme`/`profile`. Returns `[active_list, extension_list]`.
- `getConfigProvider($name)` — which extension provides a config item.
- `providerHasConfig($type, $name)` — bool.

## `config_update.config_diff` — `ConfigDiffInterface` (`ConfigDiffer`)
- `same($source, $target)` → bool, after normalization (ignores ordering/`uuid`/`_core`).
- `diff($source, $target)` → a `Diff` object (core `Diff` component) for rendering.

## `config_update.config_update` — `ConfigRevertInterface` (`ConfigReverter`)
Read defaults from extension storage and write to active storage. `$type` is a config
entity type id (or `''` when `$name` is the full config name), `$name` is the item name
without prefix.
- `import($type, $name)` — install a currently-missing item from its default. Fires `PRE_IMPORT`/`IMPORT`. Returns bool.
- `revert($type, $name)` — overwrite the active item with the shipped default. Fires `PRE_REVERT`/`REVERT`. Returns bool.
- `getFromActive($type, $name)` — current active value (or FALSE).
- `getFromExtension($type, $name)` — value from `config/install` or `config/optional` (or FALSE).

```php
$reverter = \Drupal::service('config_update.config_update');
if (!$differ->same($reverter->getFromActive('view', 'frontpage'),
                   $reverter->getFromExtension('view', 'frontpage'))) {
  $reverter->revert('view', 'frontpage');   // restore shipped default
}
```

Notes: operates on **base** config only — no `settings.php` overrides, no translations.
Install-profile defaults take precedence over module/theme defaults for the same item.
