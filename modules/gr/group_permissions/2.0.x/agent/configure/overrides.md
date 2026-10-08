# Enabling and editing per-group permission overrides

There is no central settings form. Configuration happens in two places: (1) a **per-group-type**
switch that must be enabled before any group of that type can override, and (2) a
**per-group** permissions form that stores the actual override set.

## 1. Enable overriding for a group type

`hook_form_group_type_form_alter()` (in `group_permissions.module`) adds an **"Enable group
permissions"** checkbox to the group type add/edit form. Saving writes a third-party setting:

- Config path: `group.type.<TYPE>.third_party.group_permissions.enabled` (boolean).
- Schema: `config/schema/group_permissions.schema.yml`
  (`group.type.*.third_party.group_permissions` → mapping with `enabled: boolean`).

Until this is set, the `_group_permissions_enabled` access check
(`GroupPermissionEnabledAccessCheck`) returns forbidden for every group of that type and the
per-group form (and its local task tabs) is hidden.

Set it programmatically:

```php
$type = \Drupal::entityTypeManager()->getStorage('group_type')->load('my_type');
$type->setThirdPartySetting('group_permissions', 'enabled', 1)->save();
// Disable again by unsetting (the module unsets rather than storing 0):
$type->unsetThirdPartySetting('group_permissions', 'enabled')->save();
```

## 2. Edit a single group's overrides

Route `entity.group_permission.canonical` → **`/group/{group}/permissions`**, served by
`Drupal\group_permissions\Form\GroupPermissionsForm` (extends Group's own
`GroupPermissionsForm`). Requirements: `_group_permission: 'override group permissions'` +
`_group_permissions_enabled: 'TRUE'`.

The form renders a permission-matrix table: one row per group permission (grouped by provider
and section, like Group's global permission form), one checkbox column per **non-admin** group
role (`getNonAdminRoles()` — admin roles are skipped and always keep every permission).
Roles are clustered by scope (Outsider / Insider / Individual). A red `✖` marker means the
permission is not applicable to that role's scope. There is also a **Log message** textarea and
a **Published** checkbox.

On submit (`GroupPermissionsForm::submitForm()`):
- Values are collected as `[$role_id => [checked permission machine names]]`.
- Stored via `GroupPermission::setPermissions()`; entity is validated, a **new revision** is
  created (revision user/time/log set), then saved.
- Publish state toggles `setPublished()` / `setUnpublished()`. Only a **published**
  `group_permission` is applied at runtime (see [../api/manager.md](../api/manager.md)).

### The stored entity

One `group_permission` entity per group (enforced by the `UniqueReferenceField` constraint on
`gid`). Fields:

| Field | Type | Notes |
|---|---|---|
| `gid` | entity_reference → `group` | Read-only, required, unique per group. |
| `permissions` | `map` | `['role_id' => ['perm_a', 'perm_b', …]]`. Revisionable. |
| `status` | published flag | Unpublished ⇒ overrides ignored, defaults apply. |
| `uid` | owner | Creator. |
| `revision_log_message`, `revision_user`, `revision_created` | revision metadata | |

Create/update the override set directly in PHP:

```php
$group = \Drupal::routeMatch()->getParameter('group'); // any GroupInterface
$manager = \Drupal::service('group_permissions.group_permissions_manager');
$gp = $manager->getGroupPermission($group)
  ?? \Drupal\group_permissions\Entity\GroupPermission::create(['gid' => $group->id()]);
$gp->setPermissions([
  'my_type-member' => ['view group', 'edit group'],
]);
$gp->setPublished();
$gp->setNewRevision();
$gp->save();
```

## Related routes / local tasks

Tabs under the group (`group_permissions.links.task.yml`): **Group permissions** (parent) →
*View*, *Revisions* (`entity.group_permission.version-history`, `/…/revisions`), *Delete*.
Revision routes: `entity.group_permission.revision`, `.revision-revert`, `.revision-delete`
(revision compare/revert/delete, gated by `_group_permission_entity_access`). The Revisions and
Delete tabs are removed by `hook_menu_local_tasks_alter()` when no override entity exists yet.

Deleting the `group_permission` entity (or unpublishing it) restores the group type's default
permissions for that group. The entity is auto-deleted when its group is deleted
(`hook_group_delete` → `GroupPermissionsManager::getGroupPermission()->delete()`).
