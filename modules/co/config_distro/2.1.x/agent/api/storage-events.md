<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Distro storage & transform/import events

## The distro storage service

`config_distro.storage.distro` — a core `ManagedStorage` wrapping
`config_distro.storage.distro.manager` (`DistroStorageManager`, a `final` class).

Every time `getStorage()` is called, the manager:

1. copies the **active** configuration into an internal `MemoryStorage`
   (`StorageCopyTrait::replaceStorageContents`),
2. acquires the `distro_storage_manager` lock (waits/throws `StorageTransformerException` if it
   can't),
3. dispatches `ConfigDistroEvents::TRANSFORM` with a `DistroStorageTransformEvent` carrying that
   mutable memory storage,
4. returns a `ReadOnlyStorage` view of the (now transformed) storage.

So without any transform subscriber the distro storage mirrors active config; subscribers are
what turn it into "the configuration the distribution wants".

```php
$distro = \Drupal::service('config_distro.storage.distro');
$data   = $distro->read('system.site');          // active, as transformed by subscribers
$names  = $distro->listAll();                     // it is read-only: write()/delete() throw
```

## Events

`Drupal\config_distro\Event\ConfigDistroEvents`:

| Constant | Value | When |
|---|---|---|
| `TRANSFORM` | `config_distro.transform` | Each time the distro storage is built; lets subscribers rewrite it. |
| `IMPORT` | `config_distro.import` | After a distribution import completes (dispatched by the Drush command / UI). |

### Subscribe to the transform

```php
use Drupal\config_distro\Event\ConfigDistroEvents;
use Drupal\config_distro\Event\DistroStorageTransformEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyDistroSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [ConfigDistroEvents::TRANSFORM => ['onTransform']];
  }

  public function onTransform(DistroStorageTransformEvent $event): void {
    $storage = $event->getStorage();               // mutable storage to read from / write to
    // e.g. write the distribution's desired version of a config item:
    $storage->write('system.site', ['name' => 'Distro default'] + $storage->read('system.site'));
  }

}
```

`DistroStorageImportEvent` (for `IMPORT`) is an empty marker event — subscribe to it to run
post-import actions.

## Comparing & importing

Consumers compare the distro storage against active and import the diff with a core
`ConfigImporter` (this is what the Drush command does):

```php
use Drupal\Core\Config\StorageComparer;

$comparer = new StorageComparer(
  \Drupal::service('config_distro.storage.distro'),   // source = desired distro state
  \Drupal::service('config.storage')                  // target = active
);
$comparer->createChangelist();
$has = $comparer->hasChanges();
$updates = $comparer->getChangelist('update');        // per op: create/update/delete/rename
```

The config_distro_filter submodule adds a transform subscriber that runs Config Filter plugins
(e.g. config_distro_ignore) over the distro storage — see the submodule docs.
