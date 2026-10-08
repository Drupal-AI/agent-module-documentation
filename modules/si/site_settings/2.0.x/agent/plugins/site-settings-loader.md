<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `site_settings_loader`

The module defines exactly one plugin type.

| | |
|---|---|
| Manager service | `plugin.manager.site_settings_loader` (`SiteSettingsLoaderPluginManager`) |
| Discovery directory | `src/Plugin/SiteSettingsLoader` |
| Interface | `Drupal\site_settings\SiteSettingsLoaderInterface` |
| Annotation | `Drupal\site_settings\Annotation\SiteSettingsLoader` (`@SiteSettingsLoader`) |
| Alter hook | `hook_site_settings_loader_plugin_info_alter()` |
| Cache | `cache.discovery`, key `site_settings_loader_plugins` |
| Base class | `Drupal\site_settings\SiteSettingsLoaderBase` |

Annotation properties: `id` (string), `label` (`@Translation`), `autoload_by_default` (bool).

## Shipped plugins

| id | Class | `autoload_by_default` | `allowAutoload()` | `loadAll()` returns |
|---|---|---|---|---|
| `full` | `FullSiteSettingsLoader` | `FALSE` | `FALSE` | `SiteSettingEntity` objects keyed by id |
| `flattened` | `FlattenedSiteSettingsLoader` | `TRUE` | `TRUE` | nested `[group][type]` arrays of plain values, cached in the `site_settings` bin |

The active one is `site_settings.config:loader_plugin`.

```php
$manager = \Drupal::service('plugin.manager.site_settings_loader');
$manager->getActiveLoaderPlugin();     // instance, or FALSE when loader_plugin is empty
$manager->getLoaderPlugin('flattened');
$manager->setActiveLoaderPlugin('full');   // writes site_settings.config:loader_plugin
array_keys($manager->getDefinitions());    // ['full', 'flattened']
```

## Writing your own

`mymodule/src/Plugin/SiteSettingsLoader/CachedSiteSettingsLoader.php`:

```php
<?php

namespace Drupal\mymodule\Plugin\SiteSettingsLoader;

use Drupal\site_settings\SiteSettingsLoaderBase;
use Drupal\site_settings\SiteSettingsLoaderInterface;

/**
 * @SiteSettingsLoader(
 *   id = "mymodule_cached",
 *   label = @Translation("Cached Site Settings Loader"),
 *   autoload_by_default = FALSE
 * )
 */
class CachedSiteSettingsLoader extends SiteSettingsLoaderBase implements SiteSettingsLoaderInterface {

  public function allowAutoload(): bool {
    return FALSE;
  }

  public function loadAll(bool $rebuild_cache = FALSE, ?string $langcode = NULL): array {
    return $this->entityTypeManager->getStorage('site_setting_entity')->loadMultiple();
  }

  public function loadByGroup(string $group, ?string $langcode = NULL): array {
    $properties = ['group' => $group] + ($langcode ? ['langcode' => $langcode] : []);
    return $this->entityTypeManager->getStorage('site_setting_entity')->loadByProperties($properties);
  }

  public function rebuildCache($langcode): void {}

  public function clearCache(): void {}

}
```

`SiteSettingsLoaderBase` already provides the injected services plus `allowAutoload()`,
`getGroups()` and `loadByEntityBundleClass()`; the interface requires `loadAll()`,
`loadByGroup()`, `loadByEntityBundleClass()`, `getGroups()`, `rebuildCache()`, `clearCache()`
and `allowAutoload()`.

Activate it:

```bash
drush cset site_settings.config loader_plugin mymodule_cached -y
drush cr
```

## Things to know before swapping loaders

- The Twig functions `site_settings_by_group()` and `all_site_settings()` call the **active**
  loader and then render whatever it returns, so a loader that returns arrays rather than entities
  breaks them — that is why `full` is the recommended loader.
- `hook_preprocess()` only auto-loads when `allowAutoload()` is TRUE **and**
  `site_settings.config:disable_auto_loading` is FALSE.
- `site_settings_token_info()` also builds the flattened `site_settings` token list from the
  **active** loader's `loadAll()`, so with `full` active that token list is effectively empty and
  you should use the `site_settings_entity` token type instead.
- `autoload_by_default` in the annotation is documentation for the settings form; the runtime
  decision is `allowAutoload()`.
