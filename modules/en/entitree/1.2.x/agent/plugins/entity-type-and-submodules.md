<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntitreeEntityType plugin type and the submodules

Sources: `src/Plugin/EntitreeEntityType*.php`, `src/Annotation/EntitreeEntityType.php`,
`src/Routing/DynamicEntitreeRoutes.php`, and the four `modules/*` submodules.

## The `EntitreeEntityType` plugin type (provided by the base module)

- Manager `plugin.manager.entitree_entity_type` (`EntitreeEntityTypeManager`) discovers plugins in
  `Plugin/EntitreeEntityType`, annotation `@EntitreeEntityType` (`id`, `entity_id`, `entity_name`),
  interface `EntitreeEntityTypeInterface`, base class `EntitreeEntityTypeBase`. Alter hook
  `entitree_entitree_entity_type_info`.
- A plugin teaches Entitree how to support one Drupal entity type. Interface methods:
  `buildManageLocationRoute(&$routes)`, `getSourcePath($id)` (internal path for aliases),
  `loadEntityByRouteParams()` / `loadEntityById()`, `getLocationsPathById()`, `getLocalTasks()`,
  `getOperations()`, static `getTokenTypes()` / `applyTokenReplaceActions()`,
  `getExistingPathAliases()` / `getOrphanedpathAliases()`.
- `DynamicEntitreeRoutes::routes()` iterates every plugin definition and calls
  `buildManageLocationRoute()` to register per-type routes. The base module ships only the
  `EntitreeEmptyLocation` plugin (`empty_location`); real entity types come from submodules.

## `entitree_node`

- Plugin `EntitreeNode` (`@EntitreeEntityType id="node"`). `buildManageLocationRoute()` registers
  `entitree.locations.node` (`/node/{node}/locations/{entity_type}` →
  `EntitreeDisplayController::renderEntityLocations`) and `entitree.locations.organize`
  (`/node/{id}/locations/organize/{entity_type}` → `LocationOrganizeForm`). Both require
  `administer entitree`. `applyTokenReplaceActions()` runs the `token` service with the `node` context.
- `entitree_node.module`: `hook_entity_operation_alter` adds a *Manage Locations* op to nodes (when `node`
  is an enabled type); `hook_form_node_form_alter` hides the core path field (`$form['path']['#access']
  = FALSE`) so Entitree owns node aliases.
- `LocationOrganizeForm` (`ConfirmFormBase`, base module) reconciles a node's orphaned path aliases against
  its Entitree locations (deletes duplicates).

## `entitree_taxonomy_term`

- Plugin `EntitreeTaxonomyTerm` (`@EntitreeEntityType id="taxonomy_term"`). Registers
  `entitree.locations.taxonomy_term` (`/taxonomy/term/{taxonomy_term}/locations/{entity_type}`, requires
  `administer entitree`, `_admin_route`). Token type `term`; source path `/taxonomy/term/{id}`.

## `entitree_location_rules` (Pathauto-style automation)

- On `hook_entity_insert` / `hook_entity_update`, `EntitreeLocationRulesService::applyLocationRules()` runs.
  For each `entitree_location_ruleset` entity it evaluates its rules (via `EntitreeLocationRule` plugins);
  if all pass, it creates locations under each configured destination, generating label + path segment from
  the ruleset templates through `EntitreeManager::applyEntityTokenReplaceAction()` and slugging with
  `cleanPathString()`.
- Config entity `entitree_location_ruleset` (`src/Entity/EntitreeLocationRuleset.php`, base table
  `entitree_location_ruleset`, `admin_permission="administer entitree"`, access handler
  `EntitreeLocationRulesetAccessControlHandler` which allows only `administer entitree`). Rules are stored
  serialized in the `rules_string` field and read back via `getRules()` (`unserialize`). Admin UI at
  `/admin/structure/entitree/rules` (list/add/edit/delete, provided by the entity's HTML route provider).
- Plugin type `EntitreeLocationRule` (manager `plugin.manager.entitree_location_rule`, annotation
  `@EntitreeLocationRule`, base `EntitreeLocationRuleBase`). Shipped rules:
  `EntityTypeLocationRule` and `EntityBundleLocationRule` (match by entity type / bundle).

## `entitree_permissions` (tree-position access rules)

- Adds an access checker `EntitreePermissionsAccessCheck` (service `entitree_permissions.access_checker`,
  tagged `access_check applies_to: _entity_access`). It runs **in addition to** core's own
  `_entity_access` check — Drupal's `AccessManager::check()` combines all applicable checks with `andIf`, so
  this checker is layered on top of core entity access rather than replacing it.
- For a route whose entity is an Entitree-managed type it finds the applicable access rule (main-location or
  path-matched location, then cascading ancestor rules where `apply_to_descendants = 1`, ordered by
  `weight`) and returns the matching `EntitreePermissionsType` plugin's `checkUserAccess()` result; user 1
  is always allowed; with no rule it falls back to core (`parent::access()`).
- Rules live in a DB table `entitree_permissions` (`location`, `type`, `operation`, `access_type`,
  `apply_to_descendants`, `weight`, `value`). `EntitreePermissionsManager` reads them with parameterised
  queries (`getAccessList`, `getAncestorsAccessList`, `loadAccessRule`).
- Plugin type `EntitreePermissionsType` (manager `plugin.manager.entitree_permissions_type`, annotation
  `@EntitreePermissionsType`, base `EntitreePermissionsTypeBase`): `role`
  (`EntitreePermissionsTypeRole`) and `user` (`EntitreePermissionsTypeUser`), each implementing
  `checkUserAccess()` returning allowed/forbidden/neutral.
- Admin UI: `LocationPermissionsController` + `RoleAccessForm` / `UserAccessForm` /
  `EntitreePermissionsRuleDeleteForm`, routes under `/admin/structure/entitree/location/{location}/access`,
  all `administer entitree`. `hook_entity_operation` adds a *Manage Permissions* op to locations. An event
  subscriber flags `edit`/`delete` operations as `main_location_permission_only`.

## Extending

Write your own `EntitreeEntityType` plugin (implement `buildManageLocationRoute`, `getSourcePath`,
`loadEntityByRouteParams`, token methods) to bring another entity type into the tree; optionally add
`EntitreeLocationRule` or `EntitreePermissionsType` plugins for rule/permission behaviour. The
`EntitreeOperationsEvent` (`src/Event/EntitreeOperationsEvent.php`) lets modules alter the per-type
operation set.
