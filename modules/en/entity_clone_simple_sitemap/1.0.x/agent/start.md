<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Clone Simple Sitemap (entity_clone_simple_sitemap) — agent index

Glue module: extends **Entity Clone** so that a cloned entity keeps its **Simple XML Sitemap**
per-entity (instance-level) settings. Package `Entity Clone`. Core `^10 || ^11 || ^12`.
License GPL-2.0-or-later. Version 1.0.x (installed 1.0.3).

- **The one event subscriber, what it copies, and how to operate it** →
  [api/clone-subscriber.md](api/clone-subscriber.md)

## What it actually is

- **No** config page (`configure: null`), **no** routes, **no** permissions, **no** config
  schema/install, **no** Drush, **no** plugins, **no** hooks. Purely a service.
- One service `entity_clone_simple_sitemap.subscriber`
  (`entity_clone_simple_sitemap.services.yml`) → class `SimpleSitemapCloneSubscriber` in
  `src/EventSubscriber/SimpleSitemapCloneSubscriber.php`, tagged `event_subscriber`,
  constructed with `@simple_sitemap.entity_manager`.
- Subscribes to `EntityCloneEvents::POST_CLONE` (`onEntityClone()`). After Entity Clone
  duplicates an entity, it copies the original's Simple Sitemap *instance* overrides onto the
  clone, for every sitemap variant. Bundle-level defaults are untouched (no override row is
  created when the original has none).

## Dependencies

- Drupal modules: `entity_clone`, `simple_sitemap` (both hard deps in `.info.yml`).
- Composer: `drupal/entity_clone:^2.0`, `drupal/simple_sitemap:^4.1`.

## Notes

- Nothing to configure — it works automatically once enabled alongside its two dependencies.
- It runs whatever access already governs the clone action; it adds no access surface of its own.
