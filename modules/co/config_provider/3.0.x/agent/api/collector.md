<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collect installable config programmatically

## Services

| Service | Class | Role |
|---|---|---|
| `config_provider.collector` | `ConfigCollector` | Runs every provider plugin |
| `config_provider.storage` | core `MemoryStorage` | Where collected config lands |
| `plugin.manager.config_provider.processor` | `ConfigProviderManager` | Provider plugin manager |
| `config_provider.config.installer` | `ConfigProviderConfigInstaller` | Decorates `config.installer` |

## Collect and read back

`ConfigCollector::addInstallableConfig(array $extensions = [])`:
1. wipes `config_provider.storage` (default collection **and** every other collection),
2. instantiates all provider plugins (via `getConfigProviders()`), injecting services,
3. calls each provider's `addInstallableConfig($extensions)` in weight order.

The result is the union of all providers' output, sitting in the provider storage:

```php
$collector = \Drupal::service('config_provider.collector');
$collector->addInstallableConfig();                 // all enabled extensions
$storage = \Drupal::service('config_provider.storage');
$names = $storage->listAll();                        // every installable config name
$data  = $storage->read('system.site');             // one item's data (if provided)
```

Limit to specific extensions by passing an Extension array keyed by name:

```php
$modules = \Drupal::service('extension.list.module');
$ext = ['node' => $modules->get('node')];
$collector->addInstallableConfig($ext);
$node_config = \Drupal::service('config_provider.storage')->listAll();
```

`getConfigProviders()` returns the fully initialised provider instances (each already given the
config factory, active storage, config manager, provider storage, install profile, and path
resolver) if you want to drive individual providers.

## Install-time decoration

`ConfigProviderConfigInstaller` decorates core's `config.installer`. Because
`config_provider_install()` sets the module weight to 100, its service-provider alterations run
after other modules', letting provider plugins contribute configuration during normal extension
installation without patching core. `container_rebuild_required: true` in the info file ensures
the container is rebuilt when the module is enabled.

## Notes

- The provider storage is a `MemoryStorage`: it is **request-scoped**, rebuilt each time you call
  the collector. It is not persisted to the database — read it back within the same PHP process.
- Provided items carry `_core.default_config_hash` (added by `addDefaultConfigHash()`), matching
  how core marks unchanged default config for localisation.
