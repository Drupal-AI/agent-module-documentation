<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entitree configuration, routes and permission

Sources: `entitree.routing.yml`, `entitree.permissions.yml`, `entitree.links.menu.yml`,
`config/install/entitree.config.yml`, `config/schema/entitree.schema.yml`, `src/Form/EntitreeConfigForm.php`,
`src/Controller/EntitreeDisplayController.php`, `src/Form/DeleteLocationForm.php`.

## Install / enable

`composer require drupal/entitree` then enable `entitree` (pulls in core `path` + contrib `token`; requires
PHP >= 8.3, the `allegiance-group/nested-set` PHP library, Drupal 10/11). Enabling runs
`entitree_install()`, which seeds the nested-set root, the Entitree root location and the site-root location
(state keys `entitree.site_root_location`, `entitree.initial_tree_created`). Enable one or more of the
entity-type / feature submodules to do anything useful (see the plugins doc).

## Permission

Single permission `administer entitree` (`entitree.permissions.yml`): *"Grants access to manage and
configure everything related to Entitree."* It gates every route below, is the `admin_permission` of the
`entitree_location` and `entitree_location_ruleset` entities, and is what the location-rules access handler
checks. No public/anonymous or lower-privilege route is defined.

## Config object `entitree.config`

Schema `config/schema/entitree.schema.yml` (`type: config_object`):

- `types`: sequence of enabled entity-type machine names. Install default: `[empty_location]`.
- `entity_type_operations`: sequence of `{ entity_type, operations: [ { operation_name, weight } ] }` —
  the operations Entitree surfaces per enabled type (extended with keys such as
  `main_location_permission_only` by the permissions submodule's event subscriber).

**`EntitreeConfigForm`** (route `entitree.entitree_config_form`, `/admin/structure/entitree/settings`):
a checkboxes form of available `EntitreeEntityType` plugins (excluding `empty_location`). `submitForm()`
writes the selected `types` via `EntitreeManager::updateConfig('types', …)` and rebuilds
`entity_type_operations` via `generateEntityTypeOperations()` (which dispatches `EntitreeOperationsEvent`
so other modules can alter the operation list).

## Routes (all `_permission: 'administer entitree'`)

Static (`entitree.routing.yml`), all under `/admin/structure/entitree`:

- `entitree.entitree_config_form` — settings form (above).
- `entitree.entitree_display_controller_RenderTreeDisplay` — `/{parent}` browse the tree
  (`EntitreeDisplayController::renderTreeDisplay`; parent upcast to `entitree_location`, defaults to site root).
- `entitree.entitree_display_controller_renderTreeAndAdd` — `/add/{entityType}/{entityId}/{parent}`: browse
  to pick a parent, then link to the add-location route (used when placing a new entity).
- `entitree.entitree_display_controller_renderTreeAndEdit` — `/edit/{parent}/{location}`: browse to re-parent.
- `entitree.location.add_empty` — add an empty (placeholder) child location under `{parent}`.
- `entitree.location.add` — `/location/add/{entity_type}/{entity_id}/{parent}`: build the add form for a real
  entity's location.
- `entitree.location.edit` — `_entity_form: entitree_location.edit`.
- `entitree.location.delete` — `DeleteLocationForm` (a `ConfirmFormBase`, so POST + CSRF token).

Dynamic: `route_callbacks: DynamicEntitreeRoutes::routes` adds one "manage locations" route per enabled
`EntitreeEntityType` plugin (e.g. `entitree.locations.node`, `entitree.locations.taxonomy_term`,
`entitree.locations.organize`) — see the plugins doc.

Menu links (`entitree.links.menu.yml`): *Entitree* under *Structure* (the tree browser) with *Entitree
Settings* beneath it.

## Controller notes

`EntitreeDisplayController` renders the `entitree__tree_display` / `entitree__manage_locations` themes and
attaches the `entitree/entitree` library (`css/entitree.css`, `js/entitree.js`, deps core/drupal, jquery,
once). `renderEntityLocations()` resolves the entity through the matching `EntitreeEntityType` plugin
(`loadEntityByRouteParams`) and lists that entity's locations with their ancestors.
