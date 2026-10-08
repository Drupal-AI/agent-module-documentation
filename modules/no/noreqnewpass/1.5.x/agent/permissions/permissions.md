<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# noreqnewpass — permissions

The module defines exactly one permission (`noreqnewpass.permissions.yml`):

| Machine name | Title | Gates | Notes |
|---|---|---|---|
| `administer noreqnewpass` | Administer No Request New Password | The settings form route `noreqnewpass.settings_form` (`/admin/config/people/noreqnewpass`) | `restrict access: true` — flagged as a security-sensitive permission in the UI. |

This permission **only** controls who may open the settings form and toggle
`noreqnewpass_disable`. It does not itself change login/reset behavior — that is driven by
the config value (see [../configure/settings.md](../configure/settings.md)). It has no
effect on the `/user/password` route, which is governed by the config flag, not by this
permission.

## Grant / check with drush

```bash
# grant to a role (e.g. content_editor)
drush role:perm:add content_editor 'administer noreqnewpass'

# revoke
drush role:perm:remove content_editor 'administer noreqnewpass'

# check whether a role holds it
drush php:eval '$r=\Drupal\user\Entity\Role::load("content_editor"); print $r && $r->hasPermission("administer noreqnewpass") ? "yes\n" : "no\n";'
```
