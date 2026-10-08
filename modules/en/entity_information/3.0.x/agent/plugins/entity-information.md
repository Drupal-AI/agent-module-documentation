<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The EntityInformation plugin type, tab/route generation & controller

## The plugin type

- Annotation `@EntityInformation` — `src/Annotation/EntityInformation.php`. Properties:
  `id`, `label` (Translation), `bundles` (string[] of `entity_type.bundle`, `*` = all bundles),
  `description` (Translation|string), `weight` (int, default 0), `open` (bool, default TRUE).
- Manager `EntityInformationManager` — `src/EntityInformationManager.php`, extends
  `DefaultPluginManager`; service **`plugin.manager.entity_information`**. Discovers
  `Plugin/EntityInformation`, interface `EntityInformationInterface`, alter hook
  `entity_information_entity_information_info`, cache key
  `entity_information_entity_information_plugins`.
- Plugin interface `EntityInformationInterface` — `src/Plugin/EntityInformationInterface.php`:
  one method `view(EntityInterface $entity): array` returning a render array.
- Helper `EntityInformationHelperTrait` — lazily provides `entityTypeManager()`.
- Optional access interface `EntityInformationAccessAwareInterface`
  (`src/Access/…`): `access(AccountInterface $account, EntityInterface $entity): AccessResultInterface`.

### Manager key methods

- `getPluggedEntityTypes()`: builds `entityTypes[type][bundle]['plugins'][id] = {label, weight, open}`
  from all definitions. `pluggedEntityBundles()` expands each `entity.bundle` string; a `*` bundle
  is expanded via `allEntityBundles()` (enumerates the entity type's bundle definitions;
  entity types with no bundle entity map to `[type => type]`).
- `isEntityInformationAvailable(string $type)`: TRUE when the type appears in the plugged map.
- `pluggedEntity()`: reads the single route parameter, then
  `entityTypeManager->getStorage($type)->load($id)` to return the current entity
  (returns FALSE when the route has zero or >1 parameters).

## How the tab & route appear

1. `entity_information.module` → `hook_entity_type_alter()` → `EntityTypeInfo::entityTypeAlter()`
   (`src/EntityTypeInfo.php`): for each entity type that `hasLinkTemplate('edit-form')` **and** has a
   `default` or `edit` form class, sets link template
   `entity-information` = `/{type}/{type}/information`.
2. `RouteSubscriber::alterRoutes()` (`src/Routing/RouteSubscriber.php`, `RoutingEvents::ALTER`
   priority 100): for each type where `isEntityInformationAvailable()` is TRUE, adds route
   **`entity.<type>.entity_information`** at `/{type}/{{type}}/information`:
   - `_controller` = `EntityInformationController::render`, `_title` = "Entity Information".
   - requirement `_permission: 'view entity information'`.
   - options: `parameters[<type>][type] = entity:<type>` (param converter loads the entity),
     `_admin_route: TRUE`.
3. `EntityInformationLocalTask` deriver (`src/Plugin/Derivative/…`, wired by
   `entity_information.links.task.yml` → `entity_information.entities`): adds a local task
   **"Information"** (weight 99, `base_route` = `entity.<type>.canonical`) for every type that is
   plugged **and** has the `entity-information` link template.

## Controller — `EntityInformationController::render()`

`src/Controller/EntityInformationController.php` (injects `plugin.manager.entity_information`):

1. `$entity = manager->pluggedEntity()`; `$plugged = manager->getPluggedEntityTypes()`;
   `$enabled = config('entity_information.settings')->get('enabled_plugins')`.
2. From `$plugged[type][bundle]['plugins']` keep plugins that are **enabled**
   (`$enabled[$id] === $id`) and pass `checkPluginAccess($id, $entity)`.
3. If none: render a markup message pointing at the settings route.
4. Sort kept plugins by `weight` (`uasort`); for each, `createInstance($id)`, read its definition,
   and emit `#type => details` with `#title` = plugin label, `#open` = definition `open` (default
   TRUE), `body` = `$plugin->view($entity)`.

`checkPluginAccess()`: if the instance implements `EntityInformationAccessAwareInterface`, allow
only when `access()` returns an `AccessResultAllowed`; **plugins that do not implement it are always
allowed** (per-plugin access is opt-in).

## Bundled plugins (`src/Plugin/EntityInformation/`)

Both declare `bundles = { "node.*" }`.

- **`path_alias`** — `EntityInformationPathAlias` (label "Path aliases", weight 10). If the
  `path_alias` entity type exists, loads `path_alias` entities whose `path` = the node's internal
  path and renders a table of the node's canonical URL/alias + language, with Edit/Delete operation
  links (`entity.path_alias.edit_form` / `.delete_form`). Falls back to a "Path module needed" /
  "no path alias found" message.
- **`menu_link`** — `EntityInformationMenuLink` (label "Menu links", weight 15). Injects
  `plugin.manager.menu.link`; if `menu_link_content` exists, `loadLinksByRoute('entity.node.canonical',
  ['node' => id])`, resolves each `MenuLinkContent` by UUID, and renders a table of title / menu /
  language + Edit/Delete operations. Falls back to a "Custom menu links module needed" /
  "no menu links found" message.

## Writing a plugin

Create `src/Plugin/EntityInformation/MyInfo.php` with an `@EntityInformation` annotation
(`id`, `label`, `bundles`, optional `description`/`weight`/`open`), implement
`EntityInformationInterface::view(EntityInterface $entity)` returning a render array. Optionally
implement `EntityInformationAccessAwareInterface` to gate the block per user/entity. After a cache
rebuild the plugin appears as a checkbox on the settings form; enable it there for it to render.
Existing entity types only gain the tab once a plugin targets one of their bundles (the route and
local task are generated from plugin coverage).
