<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission: `access css fields`

Defined in `field_css.permissions.yml`:

| Permission          | Title             | Flags                  |
|---------------------|-------------------|------------------------|
| `access css fields` | Access CSS fields | `restrict access: true` |

This is the module's only permission. It controls **who may edit the contents of a CSS field**.

## Enforcement

`field_css_entity_field_access()` (in `field_css.module`) implements
`hook_entity_field_access()`:

- For the `edit` operation on any field whose type is `css`, it returns
  `AccessResult::forbiddenIf(!$account->hasPermission('access css fields'))` and adds the
  `user.permissions` cache context.
- For all other operations/field types it returns `AccessResult::neutral()` (no opinion).

So a user without `access css fields` cannot edit a CSS field on any entity form, while viewing the
rendered CSS is not gated by this permission (the `<style>` output is part of normal entity display).

## Granting via Drush

```bash
drush role:perm:add editor 'access css fields'
```

Because the permission is flagged `restrict access: true`, Drupal surfaces it on the permissions
page as one to grant deliberately.
