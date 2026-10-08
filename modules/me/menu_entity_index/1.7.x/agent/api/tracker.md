<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracker service, index table & Views

## The service

`menu_entity_index.tracker` → `Drupal\menu_entity_index\Tracker`
(implements `Drupal\menu_entity_index\TrackerInterface`). Key methods:

| Method | Purpose |
|---|---|
| `getHostData(EntityInterface $entity)` | Reverse lookup: array of menu links referencing `$entity`, each with `menu_name`, `level`, `label`, `link` (Url to the link's edit page, or `''` if no access), `language`. |
| `updateEntity(EntityInterface $entity)` | (Re)index a host/target entity; called from `hook_entity_insert/update`. |
| `deleteEntity(EntityInterface $entity)` | Remove all index rows for a deleted entity. |
| `getTrackedMenus()` / `getTrackedEntityTypes()` | Current tracking config. |
| `getAvailableMenus()` / `getAvailableEntityTypes()` | What *can* be tracked. |
| `isTrackedEntityType(EntityTypeInterface $type)` | Is this type tracked? |
| `getConfiguration()` | The `menu_entity_index.configuration` ImmutableConfig. |
| `setConfiguration(array $form_values, bool $force_rebuild = FALSE)` | Apply new tracking config; deletes rows for removed items, batch-rescans added ones. |

Example — list menus referencing a node:

```php
$tracker = \Drupal::service('menu_entity_index.tracker');
foreach ($tracker->getHostData($node) as $row) {
  // $row['menu_name'], $row['level'], $row['label'], $row['language'], $row['link']
}
```

## The `menu_entity_index` table

One row per (menu link → target entity) relationship. Columns (see
`menu_entity_index.install`):

`menu_name`, `level`, `entity_type`, `entity_subtype`, `entity_id`, `entity_uuid`
(the *host* menu link), `parent_type`, `parent_id`, `parent_uuid` (its parent),
`langcode`, and `target_type`, `target_subtype`, `target_id`, `target_uuid`,
`target_langcode` (the referenced entity). Indexed on host and target tuples.

```sql
-- Which menus reference node 42?
SELECT menu_name, level FROM menu_entity_index
WHERE target_type = 'node' AND target_id = 42;
```

## Views integration

`hook_entity_type_alter()` sets a `views_data` handler on `menu_link_content` if none
exists (`ViewsData\MenuLinkContent`), and `menu_entity_index.views_data` adds data for the
index itself. Provided Views handlers (in `src/Plugin/views/`):

- **field**: `Menu` (menu label), `TargetType` (target entity type label).
- **filter**: `Menu` (filter links by menu), `TargetType` (filter by referenced entity type).
- **argument_default**: `Menu` (default the menu argument from context).

These are Views *handlers*, not a plugin type the module defines — there is no
`menu_entity_index` plugin manager to implement against.
