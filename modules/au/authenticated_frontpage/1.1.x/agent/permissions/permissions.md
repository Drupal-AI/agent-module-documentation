<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `authenticated_frontpage.permissions.yml`.

| Permission | Machine name | Notes |
|---|---|---|
| Administer authenticated_frontpage configuration | `administer authenticated_frontpage configuration` | `restrict access: true` — controls the settings form (route `authenticated_frontpage.settings_form`, `/admin/config/system/authenticated-frontpage`). Grant only to trusted admins: it decides the front page a whole class of logged-in users is sent to. |

Grant via drush:

```sh
drush role:perm:add administrator 'administer authenticated_frontpage configuration'
```
