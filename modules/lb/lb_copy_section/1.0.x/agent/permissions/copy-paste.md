<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission: `copy paste sections`

The module defines exactly one permission (`lb_copy_section.permissions.yml`):

```yaml
'copy paste sections':
  title: 'Copy/paste sections'
```

It gates everything the module does:
- The **Copy** and **Paste** links are only rendered for users who have it
  (`CopySectionRender::preRender` checks `hasPermission('copy paste sections')`).
- Both routes (`lb_copy_section.copy`, `lb_copy_section.paste`) require it
  (`_permission: 'copy paste sections'`) in addition to core's
  `_layout_builder_access: 'view'`.

It is **not** marked `restrict access: true`, but it lets an editor duplicate arbitrary
section content, so grant it only to trusted content roles.

## Grant it

UI: *People → Permissions* (`/admin/people/permissions`), find "Copy/paste sections" and tick
the roles.

Drush:

```bash
drush role:perm:add content_editor 'copy paste sections'
```

Config (a role's `user.role.<id>` config lists it under `permissions:`):

```php
$role = \Drupal\user\Entity\Role::load('content_editor');
$role->grantPermission('copy paste sections')->save();
```

There is no other configuration — once a role has the permission and Layout Builder is enabled
for a layout, its members see the Copy/Paste links while editing.
