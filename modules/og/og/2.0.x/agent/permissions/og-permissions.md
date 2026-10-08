<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and roles

## The one global permission

`og.permissions.yml` declares exactly one Drupal permission:

```yaml
administer organic groups:
  title: 'Administer Organic groups'
  description: 'Administer all groups and permissions.'
  restrict access: true
```

It grants every group permission in every group and guards the `og_ui` admin routes.

## Group-level permissions (per group, not global)

These are **not** in a `*.permissions.yml`. They are `Drupal\og\GroupPermission` objects
supplied through the `og.permission` event
(`OgEventSubscriber::provideDefaultOgPermissions()`), and stored on `OgRole` config entities.
Shipped set, with the roles they are granted to by default:

| Permission | Default roles |
|---|---|
| `administer group` | administrator |
| `update group` | administrator |
| `delete group` | administrator |
| `manage members` | administrator |
| `add user` | administrator |
| `approve and deny subscription` | administrator |
| `administer permissions` | administrator |
| `subscribe` | non-member |
| `subscribe without approval` | (none) |

## Group content entity-operation permissions

For every group-content bundle OG derives `GroupContentOperationPermission` objects
(`OgEventSubscriber::getDefaultEntityOperationPermissions()`, overridden for nodes by
`provideDefaultNodePermissions()`), e.g. for a `post` node bundle:

```
create post content
edit own post content        (operation: update, owner: TRUE)
edit any post content        (operation: update, owner: FALSE)
delete own post content      (operation: delete, owner: TRUE)
delete any post content      (operation: delete, owner: FALSE)
clone post content / clone own post content
```

Each carries `entity_type`, `bundle`, `operation`, `owner` and `default roles`, which is what
lets OG answer "may this user update this entity in this group" across entity types.

Enumerate them live:

```php
$pm = \Drupal::service('og.permission_manager');
$pm->getDefaultGroupPermissions('node', 'club');
$pm->getDefaultEntityOperationPermissions('node', 'club', ['node' => ['post']]);
```

## `OgRole` config entities

Id format **`<entity_type>-<bundle>-<role_name>`** (`og.og_role.node-club-member`). Keys:
`id`, `label`, `weight`, `group_type`, `group_bundle`, `group_id`, `is_admin`, `role_type`,
`permissions`.

- `role_type: required` → `member` and `non-member`; they cannot be deleted
  (`OgRoleInterface::ROLE_TYPE_REQUIRED`).
- `role_type: standard` → everything else, e.g. the default `administrator` with
  `is_admin: true` (which implies all permissions without listing them).
- Constants: `OgRoleInterface::ANONYMOUS` = `non-member`,
  `::AUTHENTICATED` = `member`, `::ADMINISTRATOR` = `administrator`.

```php
use Drupal\og\Entity\OgRole;
use Drupal\og\OgRoleInterface;

$role = OgRole::loadByGroupAndName($group, OgRoleInterface::AUTHENTICATED);   // 'member'
$role->grantPermission('create post content')->save();
$role->revokePermission('create post content')->save();
$role->hasPermission('manage members');
```

```bash
drush cget og.og_role.node-club-member permissions
drush php:eval 'print json_encode(array_keys(\Drupal::entityTypeManager()->getStorage("og_role")->loadMultiple()));'
```

## Assigning roles to a user

Roles live on the **membership**, not on the user account:

```php
$membership = \Drupal::service('og.membership_manager')->getMembership($group, $user->id());
$membership->addRole(OgRole::loadByGroupAndName($group, 'administrator'))->save();
```

The bundled `og_members_overview` view (base table `og_membership`) exposes bulk actions:
`og_membership_add_single_role_action`, `og_membership_remove_single_role_action`,
`og_membership_add_multiple_roles_action`, `og_membership_remove_multiple_roles_action`,
`og_membership_approve_pending_action`, `og_membership_pending_action`,
`og_membership_block_action`, `og_membership_unblock_action`, `og_membership_delete_action`.

## Checking a permission properly

Never call `$role->hasPermission()` alone — it ignores user 1, `administer organic groups`,
`group_manager_full_access`, `is_admin` roles and any alter hooks. Use the service:

```php
\Drupal::service('og.access')->userAccess($group, 'manage members', $user)->isAllowed();
```

The UI for all of this is in `og_ui`
(`/admin/config/group/permissions`, `/admin/config/group/roles`).
