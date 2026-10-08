<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entitree (entitree) — agent index

Provides a **hierarchical (tree) structure for content entities** and manages their URL aliases from
that hierarchy. The tree is a **nested set** (`allegiance-group/nested-set`) stored in per-language
`entitree_structure_{langcode}` tables; each tree node is an **`entitree_location`** content entity that
references a real entity or an **`empty_location`**. Version **1.2.0**. Core `^10 || ^11`. PHP `>=8.3`.
Package `Entitree`. License GPL-2.0-or-later. Depends on core **`path`** + contrib **`token`**.

- **Tree model, nested-set storage, EntitreeLocation entity, path-alias generation, manager/store API** →
  [architecture/tree-and-locations.md](architecture/tree-and-locations.md)
- **Settings form, `entitree.config` object + schema, routes, permission, admin UI** →
  [config/settings.md](config/settings.md)
- **The `EntitreeEntityType` plugin type, dynamic routes, and the four submodules** →
  [plugins/entity-type-and-submodules.md](plugins/entity-type-and-submodules.md)

## What it actually is (from source)

- **One permission**: `administer entitree` (`entitree.permissions.yml`). Every Entitree route and every
  Entitree entity's `admin_permission` uses it. There is **no Drush** and **no update path beyond
  `entitree_update_8001`**.
- **Entities**: `EntitreeLocation` (`entitree_location`, base table `entitree_location`) and
  `EmptyLocation` (`empty_location`), both in `src/Entity/`. A location references an entity by
  `ref_entity_type` + `ref_entity_id` and carries a `path_segment`, `pid` (path_alias id) and `langcode`.
- **Services** (`entitree.services.yml`): `entitree.manager` (`EntitreeManager`), the
  `plugin.manager.entitree_entity_type` plugin manager, `entitree.twig.extension`
  (`entitree_location_operations()` Twig function), and `entitree.alias_uniquifier` (a trimmed copy of
  Pathauto's `AliasUniquifier`).
- **Storage helpers**: `EntitreeStore` (per-langcode in-memory index of the tree) and `NestedSetFactory`
  (wraps `metalinspired\NestedSet` HybridFind/HybridManipulate against `entitree_structure_{langcode}`).
- **Config**: object `entitree.config` (`types`, `entity_type_operations`); schema in
  `config/schema/entitree.schema.yml`; install default `types: [empty_location]`.
- **Routes** (`entitree.routing.yml` + `DynamicEntitreeRoutes::routes`): browse tree, add/edit/delete
  locations, plus dynamic per-entity-type "manage locations" routes built by each `EntitreeEntityType`
  plugin. All require `administer entitree`.
- **Plugin type provided**: `EntitreeEntityType` (`Plugin/EntitreeEntityType`, annotation
  `@EntitreeEntityType`).

## Submodules (each `dependencies: entitree`)

- **`entitree_node`** — node support plugin + "Manage Locations" operation/route.
- **`entitree_taxonomy_term`** — taxonomy-term support plugin + route.
- **`entitree_location_rules`** — auto-creates locations on entity insert/update from rulesets
  (`entitree_location_ruleset` entity, `EntitreeLocationRule` plugin type). Pathauto-style automation.
- **`entitree_permissions`** — tree-position access rules (`EntitreePermissionsType` plugin type: role/user),
  evaluated as an extra `_entity_access` check **on top of** core entity access.

See [plugins/entity-type-and-submodules.md](plugins/entity-type-and-submodules.md) for submodule detail.
