<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Tools (cache_tools) — agent index

Developer caching enhancements over core: (1) **sanitize** overly generic cache tags/contexts on
named blocks and views, and (2) place **precise published-entity cache tags** (`node_article_pub`,
optionally `node_article_pub:field_name:value`) with **automatic invalidation** on entity ops.
Package `Cache`. Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.8.

- Composer: requires **`drunomics/service-utils`** (used for `EntityTypeManagerTrait`). No declared
  Drupal module dependencies in `.info.yml`, but at runtime it needs core **block** (it overrides the
  block view builder) and **views** (ViewsCache plugins). No routes, no permissions, no Drush, no hooks
  beyond the entity + entity-type-alter hooks, no config entities/schema.
- **All configuration is a service-container parameter** named `cache_tools` (defaults in
  `cache_tools.services.yml`); override it in a site `services.yml`. There is no admin form.

## What it provides (from source)

- **`cache_tools_entity_type_alter()`** (`cache_tools.module`) swaps the `block` entity's view builder to
  `Drupal\cache_tools\CachewiseBlockViewBuilder`.
- **Two services** (`cache_tools.services.yml`), both constructed with the `%cache_tools%` parameter:
  - `cache_tools.cache.invalidator` → `Service\CacheInvalidator` (tags + invalidation logic).
  - `cache_tools.cache.sanitizer` → `Service\CacheSanitizer` (context/tag stripping).
- **`CachewiseBlockViewBuilder`** extends core `BlockViewBuilder`; sanitizes in both `viewMultiple()` and
  `preRender()`.
- **Two ViewsCache plugins** in `src/Plugin/views/cache/`:
  - `cache_tools_sanitized_cache_tag` → `SanitizedCacheTag` (auto-invalidated).
  - `cache_tools_sanitized_cache_field_tag` → `SanitizedCacheFieldTag` (adds `:field:value`; **not**
    auto-invalidated — you invalidate it yourself).
- **Entity hooks** (`cache_tools.module`): `hook_entity_insert/update/delete` call
  `CacheInvalidator::invalidatePublishedEntity()` and `invalidatePublishedEntityFields()`.

## Solution docs

- **The `cache_tools` parameter — every key, sanitize + invalidate maps, and how to override** →
  [config/settings.md](config/settings.md)
- **Published-entity tags & the invalidation lifecycle (`CacheInvalidator`)** →
  [api/invalidation.md](api/invalidation.md)
- **Block/view sanitizing + the two ViewsCache plugins** →
  [plugins/views-cache.md](plugins/views-cache.md)
