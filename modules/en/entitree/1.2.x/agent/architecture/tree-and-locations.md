<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entitree tree model, storage and path aliases

How the hierarchy is modelled and stored, and how it drives URL aliases. Sources: `src/Entity/`,
`src/EntitreeManager.php`, `src/EntitreeStore.php`, `src/NestedSetFactory.php`, `src/AliasUniquifier.php`,
`entitree.install`, `entitree.module`.

## Two entity types

- **`EntitreeLocation`** (`src/Entity/EntitreeLocation.php`, `@ContentEntityType id="entitree_location"`,
  base table `entitree_location`, `admin_permission="administer entitree"`). One row = one node in the tree.
  Base fields: `id`, `uuid`, `label`, `main_location` (bool), `path_segment`, `pid` (the `path_alias`
  row id), `ref_entity_id`, `ref_entity_type`, `langcode`. Form handler `EntitreeLocationForm` (add/edit).
  In-memory flags `siteRoot`/`entitreeRoot` and `originalParent`/`parentLocation` track tree position and
  change detection; they are **not** stored on the entity — the parent lives in the nested-set table.
- **`EmptyLocation`** (`src/Entity/EmptyLocation.php`, `empty_location`). A placeholder "folder" entity a
  location can reference when there is no real backing content. `EntitreeConfigForm` always forces
  `empty_location` into the enabled `types`.

## Nested-set storage

- `entitree_install()` creates a root nested-set node and a "site root" location (`path_segment "/"`),
  storing the site-root location id in **state** (`entitree.site_root_location`,
  `entitree.initial_tree_created`). `entitree_update_8001` migrated those two values from config to state.
- `entitree_schema()` declares one table **per enabled language**: `entitree_structure_{langcode}` with
  `id, lft, rgt, parent, ordering, depth, location_id` (+ indexes). This is the nested set; `location_id`
  links a nested-set node back to an `entitree_location`.
- **`NestedSetFactory`** (`src/NestedSetFactory.php`) builds a `metalinspired\NestedSet\Config` from
  Drupal's own DB connection options and sets `table = 'entitree_structure_' . $langcode`. It exposes
  `insert`, `move` (`moveMakeChild`), `delete`, `createRootNode`, and find methods (`findDescendants`,
  `findChildren`, `findAncestors`, `findParent`, `findNestedSetIdByLocationId`). The langcode comes from the
  language manager, not from request input.

## Manager and store

- **`EntitreeManager`** (service `entitree.manager`; ctor `@database`, `@config.factory`). Key methods:
  `getStore($langcode)` / `getNestedSetFactory($langcode)` (both memoised per langcode),
  `getLocationsByIdAndType($entityId,$entityType)`, `getMainLocation($entity)`,
  `getLocationByPath($path)`, `getSiteRootLocation($langcode)` (reads the state value),
  `getConfig()`/`updateConfig()`, `generateEntityTypeOperations()`/`getEntityTypeOperations()`,
  token helpers (`getAllSupportedTokenTypes`, `applyEntityTokenReplaceAction`), and
  `generateLocationSelectionFormArray()` (the AJAX browse/select fieldset used by forms). All DB access uses
  parameterised placeholders (`:path`, `condition()` args).
- **`EntitreeStore`** (`src/EntitreeStore.php`, one per langcode). An in-memory `index`
  (locationId → parentLocationId + nestedSetNodeId) and reverse child index over the nested set. Provides
  `getLocation`, `getLocationChildren`, `getLocationAncestors`, `getLocationDescendants`,
  `insertLocation`, `moveLocation`, `removeLocationAndDescendants`. `EntitreeLocation::getChildren()` /
  `getAncestors()` and `postLoad()` delegate here.

## Path-alias lifecycle

- `EntitreeLocation::preSave()`: for a new location with no siblings, sets `main_location = TRUE`; for an
  `empty_location` ref, syncs the placeholder's label; then (unless site root) calls
  `entitree.alias_uniquifier->uniquify(generatePath(), internalPath, langcode)` to pick a unique
  `path_segment`, and if the parent or segment changed calls `updatePathAlias()`.
- `generatePath()` = parent path + `/` + `path_segment` (site root is `/`). `updatePathAlias()` creates or
  updates the `path_alias` row (source from the entity-type plugin's `getSourcePath()`), stores its id in
  `pid`, invalidates the `entitree.breadcrumb` cache tag, then **recursively updates all children** (the
  source flags this as a scaling TODO).
- `preDelete()` deletes the path alias and, for `empty_location` refs, the placeholder entity.
  `deleteDescendants()` bulk-deletes descendant locations and prunes the nested set.
- **`AliasUniquifier`** (`src/AliasUniquifier.php`, adapted from Pathauto 8.x-3.1.8) appends a numeric
  suffix until the alias is free and refuses aliases that collide with a real file/dir or route.

## Hooks (`entitree.module`)

- `entitree_theme()` registers `entitree__tree_display`, `entitree__manage_locations`,
  `entitree__location_operations` (templates in `templates/`).
- `entitree_entity_operation()` adds Open URL / Edit / Add Child / Delete operations to
  `entitree_location` rows (delete/edit link to the confirm form and edit route).
- `entitree_preprocess_breadcrumb()` tags breadcrumbs with `entitree.breadcrumb` so alias changes clear them.
