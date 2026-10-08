<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission, in `libraries_ui.permissions.yml`:

| Permission | Restricted | Gates |
|---|---|---|
| `access libraries_ui` | yes (`restrict access: TRUE`) | Viewing the `/admin/reports/libraries` report (route `libraries_ui.overview`). |

Grant it only to trusted administrators/developers (it exposes the site's full library/asset
inventory). Example:

```bash
drush role:perm:add administrator 'access libraries_ui'
```

The module defines no other permissions and no config-level access controls.
