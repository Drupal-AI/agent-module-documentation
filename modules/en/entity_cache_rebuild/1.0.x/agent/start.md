<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Cache Rebuild (entity_cache_rebuild) — agent index

Adds a permission-gated **"Cache rebuild"** local task (tab) to every **content entity type that has a canonical link**, invalidating that entity's cache tags on demand. No settings form, no dependencies beyond Drupal core, no config, no Drush. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x (installed 1.0.2).

- **The whole mechanism — dynamic routes, controller, local-task deriver, permission, and the alter hook** → [api/cache-rebuild.md](api/cache-rebuild.md)

## What it actually is

- **No** `composer.json`, `*.services.yml`, `*.module`, `*.install`, `config/`, or `config/schema/`. The project is four PHP classes plus four YAML files.
- **Permission** (`entity_cache_rebuild.permissions.yml`): a single permission `rebuild cache for all content entity types`, which gates every generated route and its local task.
- **Routes**: no static routes; `entity_cache_rebuild.routing.yml` delegates to the route callback `\Drupal\entity_cache_rebuild\Routing\CacheRebuild::routes()`, which builds one route `entity.<type>.cache_rebuild` at path `<canonical>/cache-rebuild` for each `ContentEntityType` that defines a `canonical` link template.
- **Controller**: `\Drupal\entity_cache_rebuild\Controller\CacheRebuild::rebuild()` collects the entity's cache tags, merges in its list / bundle-list cache tags, fires the alter hook, calls `Cache::invalidateTags()`, adds a status message, and redirects to the canonical page.
- **Local task deriver**: `\Drupal\entity_cache_rebuild\Plugin\Derivative\CacheRebuildLocalTasks` (registered via `entity_cache_rebuild.links.task.yml`) adds a "Cache rebuild" tab next to *View*/*Edit* for each such entity type.
- **Alter hook**: `hook_entity_cache_rebuild_alter(array &$cache_tags, &$message, ContentEntityInterface $entity)` (documented in `entity_cache_rebuild.api.php`) lets other modules add cache tags or change the confirmation message.

## Operate it

Enable the module and grant `rebuild cache for all content entity types` to trusted roles; there is nothing else to configure. See [api/cache-rebuild.md](api/cache-rebuild.md).
