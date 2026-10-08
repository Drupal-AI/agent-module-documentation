# Permissions

Defined in `password_policy.permissions.yml`.

| Permission | Gates |
|---|---|
| `manage password reset` | Access the **Force Password Reset** form (`/admin/config/security/password-policy/reset`) and manually override user password-reset dates. |

Creating and editing policies themselves is gated by core's
`administer site configuration` (see the policy routes and the config entity's
`admin_permission`), not by a module-specific permission.

Grant via drush:
```
drush role:perm:add site_admin 'manage password reset'
```

Which *policy* applies to a user is not a permission — it is driven by the roles
selected on each policy entity.
