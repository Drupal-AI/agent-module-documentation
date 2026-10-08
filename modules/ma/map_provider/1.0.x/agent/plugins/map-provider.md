<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MapProvider plugin type

The module defines one plugin type, **MapProvider**, and ships two managers plus a
bridge that lets a provider be declared *either* in PHP (annotation) *or* in a YAML
file. Consumers read every provider — YAML- and PHP-declared alike — through the single
annotation manager.

## The two managers (`map_provider.services.yml`)

| Service id | Class | Discovery |
| --- | --- | --- |
| `plugin.manager.map_provider` | `Drupal\map_provider\Plugin\MapProviderManager` | Annotation `@MapProvider` under `Plugin/MapProvider/` (a `DefaultPluginManager`) |
| `plugin.manager.yaml_map_provider` | `Drupal\map_provider\YamlMapProviderManager` | `YamlDiscovery` over every module's `*.map.provider.yml` |

`MapProviderManager` alter hook: `hook_map_provider_map_provider_info(&$definitions)`.
Cache id `map_provider_map_provider_plugins`; interface `MapProviderInterface`;
annotation class `Drupal\map_provider\Annotation\MapProvider`.

**How the two connect.** The annotation plugin `Plugin/MapProvider/YamlMapProvider`
(id `yaml_map_provider`) carries a deriver, `Plugin/Derivative/YamlMapProvider`. The
deriver asks `plugin.manager.yaml_map_provider` for `getDefinitions()` and emits one
derivative per YAML entry. So each YAML provider surfaces in the annotation manager as
`yaml_map_provider:<id>` (e.g. `yaml_map_provider:osm`). Net effect: **iterate
`plugin.manager.map_provider` and you get all providers**, however declared.

## Plugin interface — `Plugin/MapProviderInterface`

Every provider instance exposes two methods (base class `Plugin/MapProviderBase` extends
`PluginBase`; it adds nothing itself, so implementers supply both):

```php
public function getUrl();          // tile-layer URL template, e.g. https://{s}.tile…/{z}/{x}/{y}.png
public function getAttribution();  // string|array attribution markup shown on the map
```

## Way 1 — declare a provider in YAML (no PHP)

Create `MODULE.map.provider.yml` at your module root. Keys become plugin ids. The
module's own file `map_provider.map.provider.yml` defines `osm`:

```yaml
osm:
  id: osm
  label: OSM
  url: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
```

`YamlMapProviderManager::processDefinition()` **requires non-empty `id` and `url`** —
either missing throws `PluginException`. `label` is translatable; `attribution` is
optional. Defaults filled in: `id`/`label`/`url` = `''`. The consumed class is
`Plugin/MapProvider/YamlMapProvider`, whose `getUrl()` returns the definition's `url`
and `getAttribution()` returns `attribution ?? ''`.

## Way 2 — declare a provider in PHP (annotation)

Put a class under `MODULE/src/Plugin/MapProvider/` extending `MapProviderBase`:

```php
namespace Drupal\your_module\Plugin\MapProvider;

use Drupal\map_provider\Plugin\MapProviderBase;

/**
 * @MapProvider(
 *   id = "osm",
 *   label = @Translation("OSM")
 * )
 */
class OSM extends MapProviderBase {
  public function getUrl() {
    return 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
  }
  public function getAttribution() {
    return '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors';
  }
}
```

## Consume providers

```php
$manager = \Drupal::service('plugin.manager.map_provider');
foreach ($manager->getDefinitions() as $id => $def) {
  $provider = $manager->createInstance($id);           // e.g. 'yaml_map_provider:osm'
  $url = $provider->getUrl();
  $attribution = $provider->getAttribution();
}
```

Feed `$url` / `$attribution` into the `map` render element — see
[../api/render-element.md](../api/render-element.md).
