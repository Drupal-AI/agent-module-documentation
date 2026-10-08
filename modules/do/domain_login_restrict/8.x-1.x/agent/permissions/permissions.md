# Permissions

The module defines exactly **one** permission (`domain_login_restrict.permissions.yml`).

| Permission | Machine name | Flags | Gates |
|---|---|---|---|
| Login to any domain | `login to any domain` | `restrict access: true` | Full bypass of the login restriction. |

`restrict access: true` means Drupal shows the "grant with care" warning on the permissions form —
it can be escalation-sensitive because it defeats the entire module.

## Effect

`_domain_login_restrict_check()` (`domain_login_restrict.module:343`) and the password-reset validator
(`:247`) both call `$user->hasPermission('login to any domain')` and **return before any domain/role
comparison** when it is held. So an account with this permission (via any of its roles) can log in on,
and request a password reset from, **any** domain regardless of its `field_domain_access` or the
per-domain role allow-list. The permission is evaluated against the account **being logged in**, not
the current viewer.

Grant it to administrator / support roles that must reach every domain:

```bash
drush role:perm:add administrator 'login to any domain'
```
```php
\Drupal\user\Entity\Role::load('administrator')
  ->grantPermission('login to any domain')
  ->save();
```

Note: the site super-user (user 1) bypasses all permission checks, so `hasPermission()` is always
true for uid 1 — user 1 is never restricted, whether or not any role is granted this permission.

No other permissions, and no dynamic/`permission_callbacks` permissions, are defined. The module's
`domain_login_block` block is gated only by the core `access content` permission (`LoginBlock::blockAccess`).
