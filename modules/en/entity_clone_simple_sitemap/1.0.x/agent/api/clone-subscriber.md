<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The clone event subscriber

Everything this module does lives in one event subscriber.

## Service & wiring

- File: `entity_clone_simple_sitemap.services.yml`
- Service id: `entity_clone_simple_sitemap.subscriber`
- Class: `Drupal\entity_clone_simple_sitemap\EventSubscriber\SimpleSitemapCloneSubscriber`
- Argument: `@simple_sitemap.entity_manager` (Simple Sitemap's entity manager, typed
  `SitemapGetterInterface`, stored as `$entityManager`).
- Tag: `event_subscriber`.

## Install / enable

1. `composer require drupal/entity_clone_simple_sitemap` (pulls `drupal/entity_clone:^2.0`
   and `drupal/simple_sitemap:^4.1`).
2. `drush en entity_clone_simple_sitemap -y`.

No configuration. After enable it acts automatically on every clone.

## Subscribed event

`getSubscribedEvents()` returns a single mapping:

```
EntityCloneEvents::POST_CLONE => 'onEntityClone'
```

So the handler runs *after* Entity Clone has created the duplicate entity (the clone already
has an id).

## What `onEntityClone(EntityCloneEvent $event)` does

1. `$original = $event->getEntity()`, `$cloned = $event->getClonedEntity()`.
2. Reads `$entity_type = $original->getEntityTypeId()`, `$original_id = $original->id()`,
   `$cloned_id = $cloned->id()`.
3. Iterates every sitemap variant from
   `$this->entityManager->setSitemaps()->getSitemaps()` (keyed by `$variant`).
4. For each variant, reads the original's instance settings:
   `setSitemaps($variant)->getEntityInstanceSettings($entity_type, $original_id)`.
5. Only when `!empty($settings[$variant])` (the original has a real override for that
   variant), it writes them onto the clone:
   `setSitemaps($variant)->setEntityInstanceSettings($entity_type, $cloned_id, $settings[$variant])`.

## Behavior (confirmed by the kernel tests)

`tests/src/Kernel/SimpleSitemapCloneSubscriberTest.php` verifies:

- Per-entity overrides (index, priority, changefreq, include_images) are copied so the clone's
  instance settings equal the original's.
- If the original has **no** instance override (only bundle defaults), the clone also gets
  **no** override row — bundle defaults are not duplicated as overrides.
- An index-exclusion override (`index => FALSE`) is copied.
- Overrides are copied independently for **each** sitemap variant (e.g. `default` and a
  `secondary` sitemap keep their distinct per-variant priorities).

## Operating notes

- Scope is instance/per-entity overrides only; bundle-level sitemap defaults are handled by
  Simple Sitemap itself and are inherited by the clone as usual.
- Works for any content entity type Entity Clone can clone (nodes, terms, media, etc.).
- Nothing to tune; disable the module to stop copying sitemap overrides on clone.
