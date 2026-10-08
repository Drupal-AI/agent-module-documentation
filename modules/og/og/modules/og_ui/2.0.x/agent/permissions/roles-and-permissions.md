<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OG roles and permissions screens

`og_ui` defines **no permissions**. Every route it adds requires `og`'s global
`administer organic groups`.

## Overview pages

`/admin/config/group/roles` and `/admin/config/group/permissions`
(`og_ui.roles_permissions_overview`, `type` constrained to `^(roles|permissions)$`) list every
group entity type + bundle and link to that bundle's roles collection or permission matrix.

## Permission matrix — `OgPermissionsForm`

`/admin/config/group/permissions/{entity_type_id}/{bundle_id}`, e.g.
`/admin/config/group/permissions/node/club`. Rows are the permissions supplied by the
`og.permission` event for that group bundle (group-level permissions plus the derived
group-content CRUD permissions); columns are the `OgRole`s of that bundle.

Saving writes the `permissions` sequence of each `og.og_role.<entity_type>-<bundle>-<name>`
config entity. The `administrator` role is normally flagged `is_admin: true`, which implies
every permission without listing any.

## Single-role form — `OgRolePermissionsForm`

`/admin/config/group/permissions/{entity_type_id}/{bundle_id}/{role_name}` — the same matrix
narrowed to one role.

## Role CRUD — `OgRoleForm` / `OgRoleDeleteForm`

Reached through `og`'s routes:

```
/admin/config/group/roles/{entity_type_id}/{bundle_id}          list
/admin/config/group/roles/{entity_type_id}/{bundle_id}/add      add
/admin/config/group/role/{og_role}/edit                         edit
/admin/config/group/role/{og_role}/delete                       delete
```

New roles get `role_type: standard`; the required `member` and `non-member` roles
(`role_type: required`) cannot be deleted.

## Scripted equivalents

Everything the UI does is plain `OgRole` config-entity manipulation:

```php
use Drupal\og\Entity\OgRole;

// Grant a permission to the member role of the node/club group type.
$role = OgRole::load('node-club-member');
$role->grantPermission('create post content')->save();

// Add a custom role for that group type.
OgRole::create([
  'name' => 'editor',
  'label' => 'Editor',
  'group_type' => 'node',
  'group_bundle' => 'club',
])->save();     // id becomes node-club-editor
```

```bash
drush cget og.og_role.node-club-member permissions
drush php:eval 'print json_encode(array_keys(\Drupal::entityTypeManager()->getStorage("og_role")->loadMultiple()));'
```

Remember that a role's stored `permissions` list is not the whole story at runtime — check
effective access with `\Drupal::service('og.access')->userAccess($group, $permission, $user)`.
