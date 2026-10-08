<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# devutils.update_import service (ConfigImport)

Source: `src/ConfigImport.php`, class `Drupal\devutils\ConfigImport`, service id `devutils.update_import` (autowired, in `devutils.services.yml`). Purpose: import specific configuration objects that ship inside a module's `config/install` / `config/optional` directory into the site's active config storage — typically from a `hook_update_N()` so a module release can roll out new/changed config without a full config sync.

## API

`public function import(string $module, array $configs = []): void`

- `$module` — machine name of the module whose config directory is the source.
- `$configs` — array of config object names (without `.yml`). Empty (default) = import every config found in that module's `config/install` and `config/optional`.
- Throws `\Exception` if the underlying `ConfigImporter` reports errors.

Usage from an update hook:
```php
// One config object.
\Drupal::service('devutils.update_import')->import('my_module', ['my_module.settings']);

// Several.
\Drupal::service('devutils.update_import')
  ->import('my_module', ['my_module.settings', 'views.view.my_view']);

// All of the module's install + optional config.
\Drupal::service('devutils.update_import')->import('my_module');
```

## How it works

- `getReplacementStorage()` resolves the module path via `ModuleExtensionList::getPath()`, opens `FileStorage` on `config/install` and `config/optional` (`InstallStorage::CONFIG_INSTALL_DIRECTORY` / `CONFIG_OPTIONAL_DIRECTORY`). When `$configs` is empty it merges `listAll()` of both. For each requested name it reads from install (preferred) or optional and stacks it onto a `Drupal\config\StorageReplaceDataWrapper` over the active `config.storage`.
- `import()` builds a `StorageComparer(source=replacement, target=active)`, calls `createChangelist()`, and returns early (logging "There are no changes to import.") when there are no changes.
- Otherwise it constructs a core `ConfigImporter` (with `config.manager`, `event_dispatcher`, `lock`, `config.typed`, `module_handler`, `module_installer`, `theme_handler`, `string_translation`, `extension.list.module`, theme extension list) and runs the sync steps manually (`initialize()` / `doSyncStep()`), logging each `Synchronized …` message, then `cache.config->deleteAll()`.
- On `ConfigException`/importer errors it logs the collected errors and rethrows as `\Exception`.
- All log output goes to the `devutils` logger channel.

## Scope / caveats

- Only imports the config names you pass (or all of a module's own install+optional set) — it is not a full site config import and does not process other storage collections except the config translation (language) collections that core's importer handles for those objects.
- The source is the module's own on-disk YAML (trusted, developer-provided), not user input.
- Depends on the core `config` module (`StorageReplaceDataWrapper`), though `info.yml` does not declare it.
