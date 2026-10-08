<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services

The module is a pure programmatic API. There is no UI, route, form, or Drush command. You
drive it from `hook_update_N()`, a `drush php:eval`, or any custom code. Two services.

## `config_import.importer` — `Drupal\config_import\ConfigImporterService`

Implements `ConfigImporterServiceInterface`. Imports/exports a **named subset** of config
without running a full core `config:import`. Everything not named is left as-is in the active
store.

```php
/** @var \Drupal\config_import\ConfigImporterServiceInterface $importer */
$importer = \Drupal::service('config_import.importer');
// Import just these two config objects from the sync directory.
$importer->importConfigs(['user.role.authenticated', 'user.role.anonymous']);
// Export active config objects to files on disk.
$importer->exportConfigs(['core.extension']);
```

| Method | Signature | Behavior |
|--------|-----------|----------|
| `setDirectory` | `setDirectory(string $directory)` | Source/target dir for `.yml` files. Must be an existing directory — throws `\InvalidArgumentException` otherwise. |
| `getDirectory` | `getDirectory(): string` | Current directory. |
| `importConfigs` | `importConfigs(array $configs)` | Import the named config objects (names without the `.yml` suffix). |
| `exportConfigs` | `exportConfigs(array $configs)` | Write the named **active** config objects out to `<directory>/<name>.yml`. |

**Default directory.** The constructor calls `setDirectory(Settings::get('config_sync_directory'))`,
so imports read from the site's sync directory unless you override with `setDirectory()`. You may
point it at any existing path, e.g. `$importer->setDirectory('/var/config')`.

**How `importConfigs()` works (`ConfigImporterService::importConfigs`):**
1. Exports the *entire* current active config into a temporary directory
   (`temporary://confi_<uuid>`, or `/tmp/confi_<uuid>` during `MAINTENANCE_MODE`).
2. For each named config, copies `<directory>/<name>.yml` over the temp copy. If that file is
   **absent**, the config is deleted from the temp storage *and* from active storage — i.e.
   naming a config whose file is missing **removes it from the site**.
3. Applies the `hook_config_import_configs_alter` denylist (see
   [../hooks/config-import-configs-alter.md](../hooks/config-import-configs-alter.md)) via
   `filter()`, deleting those names from the temp storage so they can never be imported.
4. Builds a core `StorageComparer` (temp vs. active) and runs core `ConfigImporter`
   `->validate()->import()`. Because only the named files differ from active, only they are
   applied. On a `ConfigException` it rethrows `ConfigImporterException` with the importer's errors.

This diff-against-active approach is what makes the import "granular": a full active snapshot is
the baseline, so unrelated divergences in the sync directory do not block or get pulled in.

**Note.** The constructor disables `FileCacheFactory` (`DISABLE_CACHE => TRUE`) for the service's
lifetime and restores it in `__destruct()` — a workaround for stale file-cache reads during import.

## `config_import.param_updater` — `Drupal\config_import\ConfigParamUpdaterService`

Copies a **single nested value** from a YAML file on disk into an existing active config object,
at the same dotted path. Useful when you only want to update one property, not replace the config.

```php
/** @var \Drupal\config_import\ConfigParamUpdaterService $updater */
$updater = \Drupal::service('config_import.param_updater');
$file = \Drupal::service('extension.list.module')->getPath('my_module')
  . '/config/install/views.view.images_library.yml';
$updater->update($file, 'views.view.images_library', 'display.default.display_options.pager');
```

`update(string $config, string $config_name, string $param)`:
- `$config` — filesystem path to a YAML file (config name + path).
- `$config_name` — the active config object to write into (e.g. `views.view.images_library`).
- `$param` — dotted path of the property to lift and set (`NestedArray::getValue` on `explode('.', $param)`).

It reads the value at `$param` from the file, then `getEditable($config_name)->set($param, $value)->save()`.
All outcomes log to the `config_update` logger channel. It returns early (logging) when: the file is
missing; the value at `$param` is **falsy** (`if (!$update_value)` — so `0`, `''`, `false`, or an empty
array are treated as "not present" and skipped); or the target config does not exist.
