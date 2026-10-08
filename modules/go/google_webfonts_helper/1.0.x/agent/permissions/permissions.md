<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

| Permission | Grants |
|---|---|
| `administer google_webfonts_helper` | Full access: list/add/edit/delete `google_webfont` entities and edit `fonts_path` settings |

- Defined in `google_webfonts_helper.permissions.yml` (title "Administer Google Webfonts").
- It is the only permission, and also the entity's `admin_permission`, so it gates every
  route in `google_webfonts_helper.routing.yml` (all requirements use
  `_permission: 'administer google_webfonts_helper'`).
- Not marked `restrict access: true`, but it lets a user trigger server-side downloads and
  file writes, so treat it as an administrative/trusted permission.

Grant via drush:

```bash
drush role:perm:add administrator 'administer google_webfonts_helper'
```
