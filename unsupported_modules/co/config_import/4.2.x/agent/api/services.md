<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Import — services & API

Everything is programmatic. `composer require drupal/confi`; `drush en config_import`. No routes,
permissions, forms, config objects, schema, or Drush commands ship with the module.

## Service `config_import.importer` — `ConfigImporterService`

Interface `ConfigImporterServiceInterface` (`src/ConfigImporterServiceInterface.php`), impl
`src/ConfigImporterService.php`.

Get it: `$importer = \Drupal::service('config_import.importer');`

### `setDirectory($directory)` / `getDirectory()`
Sets the source directory that import/export read from. Constructor defaults it to
`Settings::get('config_sync_directory')` (the sync dir). `setDirectory()` calls `is_dir()` and
throws `\InvalidArgumentException` if the path is not an existing directory — so the argument must
be a real filesystem directory, not a config-dir alias name.

### `importConfigs(array $configs)`
Imports only the named objects. Flow:
1. Makes a temp dir (`temporary://confi_<uuid>`, or `/tmp/...` under `MAINTENANCE_MODE`); throws
   `ConfigImporterException` if `mkdir` fails.
2. `export()` — dumps **all** active config into that temp `FileStorage`.
3. For each name: copies `"$directory/$config.yml"` over the temp copy. **If that file does not
   exist**, it deletes the object from the temp storage *and* from active `config.storage` — i.e.
   the object is removed on import.
4. `filter()` — runs `hook_config_import_configs_alter()` and deletes any returned names from the
   temp storage so they are excluded from the import.
5. `import()` — builds a `StorageComparer(temp, active, config.manager)`; if `hasChanges()`, runs
   a real core `ConfigImporter->validate()->import()`. Validation failures are rethrown as
   `ConfigImporterException` with the collected errors.

Because it round-trips through core's `ConfigImporter`, dependency ordering, config events, and
locking all apply — this is a genuine partial import, not a raw storage write.

### `exportConfigs(array $configs)`
For each name, reads it from active `config.storage` and writes it to a `FileStorage` at the
current directory. Straight dump to `.yml`, no diffing.

### Alter hook `hook_config_import_configs_alter(array &$configs)`
Defined in `config_import.api.php`; consumed by `ConfigImporterService::filter()`. Append config
names to **prevent them from being imported** (e.g. environment-specific settings). Applies to
every `importConfigs()` call.

## Service `config_import.param_updater` — `ConfigParamUpdaterService`

`src/ConfigParamUpdaterService.php`, deps `config.manager` + `logger.factory` (channel
`config_update`). Not covered by the interface above.

### `update($config, $config_name, $param)`
- `$config` — path to a YAML file on disk (e.g. `<module path>/config/install/test.config.yml`).
- `$config_name` — active config object to patch (e.g. `views.view.who_s_online`).
- `$param` — dot-delimited nested key (e.g. `dependencies.module`).

Reads the YAML file, extracts the value at `$param` via `NestedArray::getValue(..., explode('.', $param))`,
then `getEditable($config_name)->set($param, $value)->save()`. Guard clauses log and return early
when: the file is missing (error), the param is absent or falsy in the file (info), or the target
config does not exist (`isNew()` + empty original → error). Use it to backfill/patch one nested
value in already-active config from a shipped YAML source.

## Operating notes
- Both services are meant to be called from `hook_update_N()` (or a one-off script) during
  deployment; there is no admin surface. Inputs (directory paths, config-name lists) come from your
  PHP code, not from HTTP requests.
- Overwrite/delete semantics: an existing object listed for import is overwritten (live edits lost);
  a listed object with no source `.yml` is deleted. Scope the list tightly.
- `ConfigImporterService` disables the file cache (`FileCacheFactory`) while active and restores the
  prior configuration in `__destruct()` (core issue 2758325).
