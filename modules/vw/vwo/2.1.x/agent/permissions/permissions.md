# Permissions

The module defines exactly one permission (`vwo.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer vwo` | Access to all three VWO admin forms — `/admin/config/system/vwo` (Settings), `/admin/config/system/vwo/visibility` (Visibility), and `/admin/config/system/vwo/vwoid` (Extract Account ID). Required by each route's `_permission`. |

This is a restricted, trusted permission (it controls a site-wide third-party tracking snippet) —
grant it only to administrators.

There is **no** per-user permission for opting in/out of experiments; that is handled by the
`filter.userconfig` setting, which adds a checkbox to the normal user edit form (any user who can
edit their own account) and stores the choice in `user.data` under the `vwo` module key.

Grant via drush:

```bash
drush role:perm:add administrator 'administer vwo'
```
