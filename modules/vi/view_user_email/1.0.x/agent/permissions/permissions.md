# Permissions

Defined in `view_user_email.permissions.yml`.

| Machine name | Title | Description | restrict access |
|---|---|---|---|
| `access email field` | Access other users email field | View other users email field. | `TRUE` |

`restrict access: TRUE` flags the permission as restricted, so Drupal's permissions UI shows a
caution when it is assigned. It is the only gate the module adds — there is no per-user,
per-role-target, or per-group scoping; a holder can view every account's email.

## Grant it

UI: `/admin/people/permissions`, search "Access other users email field", check it for the
target role(s).

Drush:

```
drush role:perm:add editor 'access email field'
```

PHP:

```php
user_role_grant_permissions('editor', ['access email field']);
```
