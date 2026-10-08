# Services & storage decorators

## Storage factory — `config_filter.storage_factory`

`Drupal\config_filter\ConfigFilterStorageFactory` builds the filtered sync storage.

```php
/** @var \Drupal\config_filter\ConfigFilterStorageFactory $f */
$f = \Drupal::service('config_filter.storage_factory');

$sync     = $f->getSync();                              // filtered config.storage.sync
$partial  = $f->getSyncWithoutExcluded(['some_filter']); // exclude filters by id
$wrapped  = $f->getFilteredStorage($storage, ['config.storage.sync'], $excluded = []);
```

All return a `FilteredStorage` (implements `FilteredStorageInterface` / core `StorageInterface`).

## Plugin manager — `plugin.manager.config_filter`

`Drupal\config_filter\Plugin\ConfigFilterPluginManager` implements
`ConfigFilterManagerInterface`:

```php
$m = \Drupal::service('plugin.manager.config_filter');
$filters  = $m->getFiltersForStorages(['config.storage.sync'], $excluded = []); // active filters, weight-sorted, keyed by id
$instance = $m->getFilterInstance('mymodule_filter');                           // one filter or NULL
```

## FilteredStorage decorator

`Drupal\config_filter\Config\FilteredStorage` wraps any `StorageInterface` with an ordered
array of `StorageFilterInterface` filters and applies them on every read/write/list/delete.

```php
use Drupal\config_filter\Config\FilteredStorage;
$storage = new FilteredStorage($innerStorage, $filters);
```

## Helper storage decorators (`src/Config/`)

- `ReadOnlyStorage` — passes reads through, throws `UnsupportedMethod` on any write/delete/rename.
- `GhostStorage` (extends `ReadOnlyStorage`) — reads pass through; writes/deletes are silently
  ignored but report success.

## How it plugs into core

`ConfigFilterEventSubscriber` listens to core's `config.transform.import` /
`config.transform.export` events (Drupal 8.8+) and applies the filtered storage there, so
filters run automatically during a normal config import/export — you rarely call the factory yourself.
