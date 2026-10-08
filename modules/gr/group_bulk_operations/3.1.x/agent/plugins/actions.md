<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins: actions, views field, and batch forms

All paths are under `web/modules/contrib/group_bulk_operations/`.

## Views field handler
`src/Plugin/views/field/GroupBulkForm.php`
```php
@ViewsField("group_bulk_form")
class GroupBulkForm extends \Drupal\views\Plugin\views\field\BulkForm
```
Extends **core** `BulkForm` (this is a core Views bulk form, not the contrib Views Bulk Operations
module). Only override is `emptySelectedMessage()` → "No group selected." Registered on the
`groups` base table by `group_bulk_operations.views.inc`:
```php
$data['groups']['group_bulk_form'] = [
  'title' => t('Group operations bulk form'),
  'field' => ['id' => 'group_bulk_form'],
];
```
To use: add the "Group operations bulk form" field to a view of Group entities.

## Action plugins (`type = "group"`)
`src/Plugin/Action/{AssignGroupRole,RemoveGroupUser,UpdateGroupOwner}.php`, extend
`Drupal\Core\Action\ActionBase`. They are near-identical. Each:
- Injects `tempstore.private` and `current_user`.
- `executeMultiple($entities)` builds `$info[group_id][langcode] = langcode` for the selected groups
  and writes it to the current user's private tempstore, then relies on the action's
  `confirm_form_route_name` to redirect to the matching form. `execute()` just calls
  `executeMultiple([$object])`.
- `access($object, $account, ...)` returns `$object->access('update', $account, $return_as_object)`
  — i.e. group **update** access. A source `@todo` on every plugin notes it should instead use
  group permissions.

| Plugin id | Class | Label | Tempstore collection | Confirm route |
|---|---|---|---|---|
| `group_assign_role` | AssignGroupRole | Assign role | `group_bulk_operations_multiple_group_assign_role_configure` | `.multiple_group_assign_role_configure` |
| `remove_group_user` | RemoveGroupUser | Remove Group User | `group_bulk_operations_remove_user_multiple_group_configure` | `.multiple_group_remove_role_configure` |
| `update_group_owner` | UpdateGroupOwner | Update Group Owner | `group_bulk_operations_update_group_owner_configure` | `.update_group_owner` |

Default config entities registering these actions ship in `config/install/system.action.*.yml`
(`group_assign_role`, `remove_group_user`, `update_group_owner`). The `.install` hook
`group_bulk_operations_update_9501()` back-installs the `update_group_owner` action config on
existing sites.

## Configuration forms (`src/Form/`) — where the work happens
All three extend `FormBase`, all three routes in `group_bulk_operations.routing.yml` require
`_permission: 'administer group'`. Each `buildForm()` reads the group IDs from the current user's
tempstore; if empty it redirects to `entity.group.collection`. On submit each runs a `batch_set()`
and then deletes its tempstore entry and redirects to the group collection.

- **AssignGroupRoleMultiple** (`/admin/group/assign_group_role`): entity-autocomplete `user`
  (`#tags => TRUE`, multiple users) + required `group_roles` checkboxes built from the union of
  `getRoles(FALSE)` (non-internal roles) across the selected groups' group types. Batch callback
  `groupBulkOperationsBatchAddMember()`: if not a member, `addMember($user, ['group_roles' => $roles])`;
  **if already a member, `removeMember()` then `addMember()`** — so the role set is replaced, not
  merged. Roles are bucketed per group type, so only roles valid for a group's type are applied.
- **RemoveGroupUserMultiple** (`/admin/group/remove_group_role`): user autocomplete (multiple).
  Batch callback `groupBulkOperationsBatchRemoveMember()`: `if ($group->getMember($user)) $group->removeMember($user);`
- **UpdateGroupOwnerMultiple** (`/admin/group/update_group_owner`): user autocomplete declared
  `#tags => TRUE` but submit uses `reset()` — **only the first user** becomes owner. Batch callback
  `groupBulkOperationsBatchUpdateOwner()`: `$group->setOwnerId((int) target_id); $group->save();`

## Notes / gotchas
- Forms load target groups/users with `entityTypeManager->getStorage(...)->loadMultiple()/load()`
  (no explicit access filtering); the group IDs originate from the operator's own tempstore and the
  whole flow is behind `administer group`.
- Batch "finished" messages report a processed **count**, not which groups/users, and there is no
  audit log — reconstructing what changed after the fact is manual.
- Assign-role has no effect selector for "add role without disturbing existing roles"; it always
  replaces the full role set for members it touches.
