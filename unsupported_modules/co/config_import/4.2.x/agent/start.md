<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Import (config_import) — agent index

Developer helper that imports/exports a **named subset** of configuration programmatically
(typically from `hook_update_N()`), instead of a full site config import. No routes, no
permissions, no forms, no config schema, no plugins, no Drush of its own, no module deps.
Core `^11` only. License GPL-2.0-or-later. Version 4.2.x.

> **Naming:** the drupal.org project is **`confi`**; the module machine name, namespace and
> services are all **`config_import`**. Install: `composer require drupal/confi` then
> `drush en config_import`.

- **The two services, methods, the alter hook, and how to drive them** →
  [api/services.md](api/services.md)

## What it actually is (from source)

- Service **`config_import.importer`** → `ConfigImporterService` (interface
  `ConfigImporterServiceInterface`), `src/ConfigImporterService.php`:

  | Method | Purpose |
  |---|---|
  | `setDirectory($dir)` / `getDirectory()` | Source dir for import (defaults to `Settings::get('config_sync_directory')`; throws `\InvalidArgumentException` if not a real dir) |
  | `importConfigs(array $configs)` | Import just the named config objects |
  | `exportConfigs(array $configs)` | Export the named objects to the source dir |

  `importConfigs()` exports the whole active store to a temp `FileStorage`, overlays each named
  object from `"$directory/$config.yml"` (missing file → the object is **deleted** from both temp
  and active storage), runs `filter()` (the alter hook) to drop restricted names, then diffs via
  `StorageComparer` and runs core's real `ConfigImporter->validate()->import()`. Constructor deps:
  `uuid`, `config.storage`, `config.manager`, `event_dispatcher`, `lock`, `config.typed`,
  `module_handler`, `module_installer`, `theme_handler`, `string_translation`, `file_system`,
  `extension.list.module`, `extension.list.theme`. It disables `FileCacheFactory` for the duration
  (see core issue 2758325) and restores it in `__destruct()`.

- Service **`config_import.param_updater`** → `ConfigParamUpdaterService`
  (`src/ConfigParamUpdaterService.php`, deps `config.manager`, `logger.factory`). One method
  `update($config, $config_name, $param)`: reads a YAML file at `$config`, pulls the nested value
  at `$param` (dot path via `NestedArray::getValue`), and writes it into the editable active
  config `$config_name` with `$config->set($param, $value)->save()`. Logs to the `config_update`
  channel; no-ops (logs error/info) if the file is missing, the param is absent/falsy, or the
  target config does not exist.

- **Alter hook** `hook_config_import_configs_alter(array &$configs)` (`config_import.api.php`):
  add config names to **block them from import** (used by `ConfigImporterService::filter()`).

  ```php
  function hook_config_import_configs_alter(array &$configs) {
    $configs[] = 'action.settings';
  }
  ```

- `ConfigImportServiceProvider` (`src/ConfigImportServiceProvider.php`) is a near-empty
  `ServiceProviderBase` — just captures the container, no runtime effect.

## Typical use

```php
function mymodule_update_10001() {
  /** @var \Drupal\config_import\ConfigImporterServiceInterface $importer */
  $importer = \Drupal::service('config_import.importer');
  $importer->setDirectory(\Drupal::service('extension.list.module')->getPath('mymodule') . '/config/install');
  $importer->importConfigs(['views.view.my_view']);
}
```

Caveat: importing an object that already exists **overwrites** it (including live editor changes);
listing a name whose `.yml` is absent **deletes** that object. List only what you intend to reset.
