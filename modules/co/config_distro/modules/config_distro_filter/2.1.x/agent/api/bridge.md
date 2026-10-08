<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Config Filter → Config Distro bridge

> **Deprecated** (`lifecycle: deprecated`, see
> https://www.drupal.org/project/config_distro/issues/3466112). Kept for backwards
> compatibility; new integrations should subscribe to `config_distro.transform` directly.

## What it registers

One tagged event subscriber:

```yaml
# config_distro_filter.services.yml
services:
  config_distro_filter.event_subscriber:
    class: Drupal\config_distro_filter\ConfigDistroFilterEventSubscriber
    arguments: ['@config_filter.storage_factory']
    tags:
      - { name: event_subscriber }
```

`ConfigDistroFilterEventSubscriber` subscribes to `ConfigDistroEvents::TRANSFORM`
(`config_distro.transform`) via `getSubscribedEvents()`.

## What it does on transform

```php
public function onDistroTransform(DistroStorageTransformEvent $event) {
  $storage = $event->getStorage();                 // the mutable distro (memory) storage
  $temp = new MemoryStorage();
  // Every config_filter plugin whose 'storages' include config_distro.storage.distro:
  $filtered = $this->filterStorageFactory->getFilteredStorage($storage, ['config_distro.storage.distro']);
  self::replaceStorageContents($filtered, $temp);  // simulate the filtered import
  self::replaceStorageContents($temp, $storage);   // write result back onto the event storage
}
```

So it makes the older **Config Filter** plugin API work with Config Distro's newer **Transform
API**: any `@ConfigFilter` plugin declaring `storages = {"config_distro.storage.distro"}` (the
prime example is `config_distro_ignore`) is applied to the distribution storage when it is built.
`config_distro_ignore` depends on this module for exactly that reason.

## Notes

- Config Distro's `config_distro_update_8101()` installs this submodule on existing sites.
- It has **no** configuration, schema, permissions, routes, or Drush commands — enabling it is
  the whole setup; its only effect is the transform subscriber above.
- To modernise, replace reliance on this bridge + a Config Filter plugin with a direct
  `config_distro.transform` subscriber (see the parent `api/storage-events.md`).
