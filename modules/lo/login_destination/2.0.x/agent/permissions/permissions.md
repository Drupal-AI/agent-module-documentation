# Permissions

Defined in `login_destination.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer login destination settings` | Everything the module exposes: the rule list, add/edit/delete of `login_destination` rules, and the advanced settings form. It is also the config entity's `admin_permission`. |

There is only one permission — it is the single gate for all Login Destination admin routes
(`/admin/config/people/login-destination/*`). Trusted/administrative.

```
drush role:perm:add site_manager 'administer login destination settings'
```
