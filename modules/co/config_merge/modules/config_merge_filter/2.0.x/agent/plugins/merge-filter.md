<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `config_merge` Config Filter plugin

Class: `Drupal\config_merge_filter\Plugin\ConfigFilter\MergeFilter`
(extends `Drupal\config_filter\Plugin\ConfigFilterBase`).

## Plugin definition

```php
/**
 * @ConfigFilter(
 *   id = "config_merge",
 *   label = "Config Merge",
 *   weight = 1000
 * )
 */
```

- **id**: `config_merge`
- **weight**: `1000` (runs late in the filter chain, so it merges after other filters)
- Injected storages (`::create()`): active = `config.storage`, snapshot = `config.storage.snapshot`.

## What it does

On read, it does a three-way merge using `config_merge`'s `ConfigMerger`:

```php
// filterRead($name, $data) -> activeRead($name, $data):
$active   = $this->active->read($name);       // config.storage
$previous = $this->snapshot->read($name);     // config.storage.snapshot
if (!$data || !$active || !$previous) {
  return $data;                               // nothing to merge -> pass through
}
return $this->configMerger->mergeConfigItemStates($previous, $data, $active);
// previous = snapshot, current = $data (incoming import), active = active storage
```

So an import value is merged into the site's active configuration, keeping local customizations
(see the parent doc for the update/ignore/substitute rules).

Other overrides:

| Method | Behavior |
|---|---|
| `filterExists($name, $exists)` | TRUE if the import has it **or** it exists in active storage. |
| `filterReadMultiple($names, $data)` | Merges each name, folding in active data. |
| `filterListAll($prefix, $data)` | Unions import names with active-storage names (so active-only config is surfaced). |
| `filterCreateCollection($collection)` | Returns a MergeFilter bound to the collection's active + snapshot storages. |
| `filterGetAllCollectionNames($collections)` | Adds active-storage collection names. |

## Drive it programmatically

```php
$filter = \Drupal::service('plugin.manager.config_filter')->createInstance('config_merge');
$merged = $filter->filterRead('views.view.content', $incomingData);
// merges $incomingData with config.storage.snapshot (previous) + config.storage (active)
```

In normal use you don't call it directly: enabling the module registers it with
`plugin.manager.config_filter`, and Config Filter storage-factory consumers apply it during
config import automatically. It has no settings — enabling the module is the whole setup.
