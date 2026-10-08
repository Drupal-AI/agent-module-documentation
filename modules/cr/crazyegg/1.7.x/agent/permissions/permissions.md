<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crazy Egg — permissions

One permission (`crazyegg.permissions.yml` / `hook_permission`):

| Permission | Machine name | Gates |
|---|---|---|
| Administer Crazy Egg | `administer crazy egg` | Access to the settings form `/admin/config/system/crazyegg` (route `crazyegg.config`) — account number, script location, excluded roles and tracked paths. |

Grant it:
```bash
drush role:perm:add administrator 'administer crazy egg'
```

This permission only controls who can configure tracking; it does not affect whether a given
visitor is tracked (that is governed by `crazyegg_roles_excluded` and `crazyegg_paths`).
