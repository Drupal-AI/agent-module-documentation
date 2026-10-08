<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache-rebuild mechanism (routes, controller, deriver, hook)

Everything the module does. Source is four PHP classes + four YAML files under
`web/modules/contrib/entity_cache_rebuild/`.

## Install & enable

```bash
composer require drupal/entity_cache_rebuild
drush en entity_cache_rebuild -y
```

No dependencies beyond Drupal core, no third-party libraries, no config to import,
no Drush commands. After enabling, grant the permission (below); there is **no
settings form** (`configure` is null).

## Permission

`entity_cache_rebuild.permissions.yml` declares one permission:

- **`rebuild cache for all content entity types`** — "Gives access to the Cache
  Rebuild local task on all entity types." It is the `_permission` requirement on
  every generated route and therefore also gates the local task.

Grant it under *People → Permissions* to trusted roles only.

## Dynamic routes

`entity_cache_rebuild.routing.yml` has no static routes — it registers a route
callback:

```yaml
route_callbacks:
  - '\Drupal\entity_cache_rebuild\Routing\CacheRebuild::routes'
```

`Routing\CacheRebuild::routes()` iterates `entityTypeManager()->getDefinitions()`,
skips anything that is not a `Drupal\Core\Entity\ContentEntityType`, and — for each
type whose definition has a `canonical` link template — creates:

- **Route id**: `entity.<entity_type_id>.cache_rebuild`
- **Path**: `<canonical>/cache-rebuild` (e.g. `/node/{node}/cache-rebuild`,
  `/taxonomy/term/{taxonomy_term}/cache-rebuild`, `/user/{user}/cache-rebuild`)
- **Defaults**: `_controller` → `Controller\CacheRebuild::rebuild`, `_title` →
  "Cache rebuild"
- **Requirement**: `_permission` → `rebuild cache for all content entity types`
- **Option**: `entity_type_id` → the entity type id (read back by the controller)

Config entities and content entity types without a canonical link get no route.

## Local task (tab) deriver

`entity_cache_rebuild.links.task.yml` registers the deriver
`Plugin\Derivative\CacheRebuildLocalTasks` (base plugin weight 100). Its
`getDerivativeDefinitions()` mirrors the route generator: for each
`ContentEntityType` with a canonical link it defines a local task keyed
`entity.<type>.cache_rebuild` with `route_name` = the generated route,
`base_route` = `entity.<type>.canonical`, and title "Cache rebuild". Result: a
**Cache rebuild** tab appears alongside *View* / *Edit* on the entity's canonical
page for users who hold the permission.

## Controller

`Controller\CacheRebuild::rebuild(RouteMatchInterface $route_match)` (services
injected via `create()`: `page_cache_kill_switch`, `entity_type.manager`,
`module_handler`, `messenger`):

1. `$this->killSwitch->trigger()` — disables the internal page cache for this
   response so the redirect is not itself served from cache.
2. Reads `entity_type_id` from the route option, reads the entity id from the route
   parameter of that name, and loads the entity via its storage handler.
3. `$cache_tags = $entity->getCacheTags();` then merges in
   `$entityType->getListCacheTags()` and, when the type has a `bundle` key,
   `$entityType->getBundleListCacheTags($entity->bundle())` (so an entity's own
   tags **plus** its list / bundle-list tags are invalidated).
4. Builds `$message = "Cache rebuilt for $entity_type_id entity $entity_id."`.
5. Fires `$this->moduleHandler->alter('entity_cache_rebuild', $cache_tags, $message, $entity)`.
6. `Cache::invalidateTags($cache_tags)` and `$this->messenger->addMessage($message)`.
7. Redirects (`RedirectResponse`) to `entity.<type>.canonical` for the same entity.

## Alter hook

`entity_cache_rebuild.api.php` documents
`hook_entity_cache_rebuild_alter(array &$cache_tags, &$message, ContentEntityInterface $entity)`.
Implement it (name it `HOOK_entity_cache_rebuild_alter`) to append extra cache tags
— e.g. tags of entities that reference this one — or to change the confirmation
message before invalidation happens.

## Operating notes

- The tab and action exist only for content entity types with a canonical link;
  nodes, taxonomy terms, users, media, comments and most custom content entities
  qualify.
- Invalidating list cache tags means one rebuild also refreshes listing/view
  caches for that entity type, not just the single page.
- Nothing persists: after invalidation the caches simply repopulate on the next
  request. There is no configuration state to export.
