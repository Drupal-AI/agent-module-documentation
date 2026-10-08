<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Snapshot API

Everything here is code-level; there is no UI. Namespaces are under
`Drupal\config_snapshot\`.

## The three coordinates

Every snapshot is addressed by:

- **snapshotSet** — a string namespaced to the module introducing the snapshot (e.g. `features`).
- **extensionType** — `module` or `theme`.
- **extensionName** — the machine name of the extension the config belongs to.

Persisted as the config entity `config_snapshot.snapshot.<set>.<type>.<name>`; the entity's
`id()` is `<set>.<type>.<name>`.

## The config entity: `Entity\ConfigSnapshot`

Config entity type id `config_snapshot`, `config_prefix: snapshot`,
`admin_permission: administer site configuration`. Exported keys: `id`, `snapshotSet`,
`extensionType`, `extensionName`, `items`. Each **item** is
`['collection' => ..., 'name' => ..., 'data' => [...]]`. Useful methods:

```php
use Drupal\config_snapshot\Entity\ConfigSnapshot;

$snapshot = ConfigSnapshot::load('features.module.mymodule'); // or NULL
$snapshot->getSnapshotSet();          // 'features'
$snapshot->getExtensionType();        // 'module'
$snapshot->getExtensionName();        // 'mymodule'
$snapshot->getItems();                // all items
$snapshot->getItem($collection, $name);       // one item array or NULL
$snapshot->setItem($collection, $name, $data)->save();
$snapshot->clearItem($collection, $name)->save();
```

On `save()` items are sorted by collection then name, and the entity declares a dependency on
its extension (`addDependency($extensionType, $extensionName)`).

## The storage: `ConfigSnapshotStorage`

A full `Drupal\Core\Config\StorageInterface` implementation backed by one `ConfigSnapshot`
entity. Construct directly or (preferably) via the trait below.

```php
use Drupal\config_snapshot\ConfigSnapshotStorage;
use Drupal\Core\Config\StorageInterface;

$storage = new ConfigSnapshotStorage('mytool', 'module', 'mymodule');   // default collection
$storage->write('mymodule.settings', ['enabled' => TRUE]);              // TRUE
$storage->exists('mymodule.settings');                                  // TRUE
$data = $storage->read('mymodule.settings');                           // array or FALSE
$names = $storage->listAll();                                          // config names in this collection
$storage->delete('mymodule.settings');
$storage->rename($old, $new);

// Collections (e.g. language overrides):
$langStorage = $storage->createCollection('language.de');
$storage->getAllCollectionNames();   // non-default collections present
$storage->writeToCollection($name, $data, 'language.de');
```

`encode()`/`decode()` are pass-through (data is stored as-is, not serialized to YAML).

## Getting a storage the right way: the trait

Use `ConfigSnapshotStorageTrait::getConfigSnapshotStorage()` inside a class rather than `new`,
so you get the registered container service when it exists:

```php
use Drupal\config_snapshot\ConfigSnapshotStorageTrait;
use Drupal\Core\Config\StorageInterface;

class MyService {
  use ConfigSnapshotStorageTrait;

  public function example(): void {
    // signature: ($snapshot_set, $extension_type, $extension_name,
    //             $collection = StorageInterface::DEFAULT_COLLECTION, ?ConfigSnapshot $snapshot = NULL)
    $storage = $this->getConfigSnapshotStorage('mytool', 'module', 'mymodule');
    // ... read()/write()/listAll() ...
  }
}
```

It looks up the service id `config_snapshot.<set>.<type>.<name>`; if the container does not
have it yet (e.g. the extension was just installed and the container has not been rebuilt), it
returns a fresh `ConfigSnapshotStorage` so callers never fail. Switch collections via the
`$collection` argument.

## Service registration: `ConfigSnapshotServiceProvider`

At container-build time it reads bootstrap config for all `config_snapshot.snapshot.*` entries
and registers one service **`config_snapshot.<set>.<type>.<name>`** per snapshot (arguments:
set, type, name). Invalid/partial snapshot data is skipped and logged via `error_log`, so a
malformed entry does not break the container. Because services are registered at build time,
a brand-new snapshot only has its service after the next container rebuild — the trait's
fallback covers the gap.
