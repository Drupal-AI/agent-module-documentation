<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Role permission

`registration_role.permissions.yml` defines one permission:

| Permission | Title | Description |
|---|---|---|
| `administer registration roles` | Administer registration roles | Set roles assigned on registration and manage whether they apply to administrator-created users. |

It is the `_permission` requirement of the only route,
`registration_role.setting.form` (`/admin/people/registration-role`).

```bash
drush role:perm:add site_manager 'administer registration roles'
drush php:eval 'var_dump(\Drupal\user\Entity\Role::load("site_manager")->hasPermission("administer registration roles"));'
```

## Upgrade note

`registration_role_update_8007()` granted this permission to **every role that already had
`administer users`**, so on sites upgraded from 8.x-1.x it may already be assigned more
widely than you expect:

```bash
drush php:eval '
  foreach (\Drupal\user\Entity\Role::loadMultiple() as $r) {
    if ($r->hasPermission("administer registration roles")) { print $r->id() . "\n"; }
  }
'
```

## Security consideration

Anyone with this permission decides which roles every new registrant receives. Because the
form lists **all** roles except `authenticated` — including administrator-like roles — it is
effectively a privilege-escalation vector. The module's own form description says: *"Be sure
this role does not have any privileges you fear giving out without reviewing who receives
it."* Treat `administer registration roles` as an administrative permission.
