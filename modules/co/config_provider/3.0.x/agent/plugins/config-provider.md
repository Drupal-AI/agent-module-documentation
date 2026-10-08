<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Implement a `ConfigProvider` plugin

## The plugin type

| Piece | Value |
|---|---|
| Discovery dir | `src/Plugin/ConfigProvider/` |
| Manager service | `plugin.manager.config_provider.processor` (`ConfigProviderManager`) |
| Annotation | `@ConfigProvider` (`Drupal\config_provider\Annotation\ConfigProvider`) |
| Interface | `ConfigProviderInterface` |
| Base class | `ConfigProviderBase` |
| Alter hook | `hook_config_provider_config_provider_info_alter()` |
| Cache | `config_provider_config_provider_plugins` |

Definitions are sorted by `weight` (`SortArray::sortByWeightElement`), so a heavier provider
runs after and can alter config added by a lighter one.

## Built-in plugins (your models)

- `config/install` — `ConfigProviderInstall`, weight **-10**. Reads an extension's
  `config/install`, across all config collections, applying profile overrides; writes each item
  to the provider storage (with a `default_config_hash`).
- `config/optional` — `ConfigProviderOptional`, weight **10**. Reads `config/optional`, keeps
  only configuration entities, dependency-sorts with `ConfigDependencyManager`, and drops items
  whose dependencies are unmet, before writing to the provider storage.

Both use their `const ID` (the directory name) as the plugin id and `getDirectory()` return.

## Methods to implement

`ConfigProviderBase` implements the setters and helpers; you typically override two methods:

```php
namespace Drupal\my_module\Plugin\ConfigProvider;

use Drupal\config_provider\Plugin\ConfigProviderBase;
use Drupal\Core\Config\StorageInterface;

/**
 * @ConfigProvider(
 *   id = "my_dir",
 *   weight = 0,
 *   label = @Translation("My provider"),
 *   description = @Translation("Provides config from config/my_dir."),
 * )
 */
class MyProvider extends ConfigProviderBase {

  const ID = 'config/my_dir';

  // Called at extension-install time (config passed by reference). Often a no-op
  // because install/optional config is handled by core / the other providers.
  public function addConfigToCreate(array &$config_to_create, StorageInterface $storage, $collection, $prefix = '', array $profile_storages = []) {}

  // Called to compute what is installable; write results into $this->providerStorage.
  public function addInstallableConfig(array $extensions = []) {
    $storage = $this->getExtensionInstallStorage(static::ID); // ExtensionInstallStorage
    foreach ($this->listConfig($storage, $extensions) as $name) {
      $data = $this->addDefaultConfigHash($storage->read($name));
      $this->providerStorage->write($name, $data);
    }
  }

}
```

Helpers available on the base class: `getExtensionInstallStorage()`, `getActiveStorages()`,
`getProfileStorages()`, `getEnabledExtensions()`, `listConfig()`, `validateDependencies()`,
`addDefaultConfigHash()`, and `providesFullConfig()` (return `FALSE` for partials such as a set
of permissions merged into a role).

## Injected state

The collector calls these setters on each instance before use: `setConfigFactory()`,
`setActiveStorages()`, `setConfigManager()`, `setProviderStorage()`, `setInstallProfile()`,
`setExtensionPathResolver()`. Inside `addInstallableConfig()` you can rely on
`$this->providerStorage`, `$this->configManager`, `$this->configFactory`, etc.

## Register it

Put the class under your module's `src/Plugin/ConfigProvider/`; the manager auto-discovers it.
Clear caches so the plugin is picked up.
