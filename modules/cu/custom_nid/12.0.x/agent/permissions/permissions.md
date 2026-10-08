<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `custom_nid.permissions.yml`. The module defines exactly one permission and no
others.

| Permission string | Title | Flags |
|---|---|---|
| `custom_nid access` | Adminster Custom Nid | `restrict access: true` |

- `restrict access: true` marks it as a sensitive permission: Drupal shows the "with great
  power comes great responsibility" warning next to it on `/admin/people/permissions` and it
  is not offered on the simplified permission UI for untrusted roles.
- It is **not** assigned to any role out of the box (the module ships no `config/install`).
- This permission is the only gate for the feature: `custom_nid_form_alter()` adds the "Nid"
  field only when `\Drupal::currentUser()->hasPermission('custom_nid access')` is true, so a
  user without it never sees the field. Users with it may set the ID of nodes they can create.

Grant / check examples:

```php
// Grant to a role (e.g. via an update hook or a script).
user_role_grant_permissions('content_migrator', ['custom_nid access']);

// Programmatic check.
$may_set_nid = \Drupal::currentUser()->hasPermission('custom_nid access');
```

```bash
# Drush: grant / revoke the permission on a role.
drush role:perm:add content_migrator 'custom_nid access'
drush role:perm:remove content_migrator 'custom_nid access'
```
