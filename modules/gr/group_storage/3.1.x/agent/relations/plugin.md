<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The group_storage relation plugin

## Plugin and deriver

`src/Plugin/Group/Relation/GroupStorage.php` declares the relation with the Group 3.x attribute:

```php
#[GroupRelationType(
  id: 'group_storage',
  entity_type_id: 'storage',
  label: ...('Group storage'),
  entity_access: TRUE,
  deriver: 'Drupal\group_storage\Plugin\Group\Relation\GroupStorageDeriver'
)]
class GroupStorage extends GroupRelationBase { ... }
```

- `defaultConfiguration()` forces `entity_cardinality = 1` — one storage entity per relationship.
- `buildConfigurationForm()` disables (does not hide) the cardinality field, with a note that the
  module relies on cardinality 1.
- `calculateDependencies()` adds a config dependency on `storage.storage_type.<bundle>`.

`GroupStorageDeriver::getDerivativeDefinitions()` iterates `StorageType::loadMultiple()` and clones
the base definition once per Storage type, setting `entity_bundle` and a per-type label/description.
So the concrete relation ids are `group_storage:<storage_type>`. `hook_ENTITY_TYPE_insert`
(`group_storage_storage_type_insert`) clears the group relation type manager's cached definitions
when a new Storage type is created, so the new relation appears immediately.

**Consequence:** with zero Storage types on the site there are zero relations to enable — expected,
not a bug. Enable a relation per group type at
`/admin/group/types/manage/{group_type}/content`.

## Routes and UI

`src/Routing/RouteSubscriber.php` clones two Group core routes and re-paths them:

| New route | Path | Source route | base_plugin_id |
|---|---|---|---|
| `entity.group_relationship.group_storage_create_page` | `group/{group}/storage/create` | `entity.group_relationship.create_page` | `group_storage` |
| `entity.group_relationship.group_storage_add_page` | `group/{group}/storage/add` | `entity.group_relationship.add_page` | `group_storage` |

The clones inherit the source routes' access checks (Group's create/add-relationship access); the
subscriber only changes path and the `base_plugin_id` default. Action links in
`group_storage.links.action.yml` ("Add existing storage", "Add new storage") appear on the overview
view. `hook_entity_operation` adds a "Storages" operation to each group (only when the current user
has `access group_storage overview` on that group and the view route exists), linking to
`view.group_storages.page_1`.

## Handler

`src/Plugin/Group/RelationHandler/GroupStoragePermissionProvider` (service
`group_storage.relation_handler.permission_provider.group_storage`, decorating
`@group.relation_handler.permission_provider`) overrides `getPermission()` for exactly one case —
`operation='view unpublished'`, `target='entity'`, `scope='any'` — returning the un-scoped legacy
name `view unpublished <plugin_id> entity` for backwards compatibility. All other permission names
pass through to Group's default provider unchanged.
