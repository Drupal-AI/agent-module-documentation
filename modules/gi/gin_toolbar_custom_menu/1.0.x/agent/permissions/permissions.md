<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Toolbar Custom Menu permissions

The module defines one permission (`gin_toolbar_custom_menu.permissions.yml`):

- **`configure gin toolbar custom menu`** — "Configure Gin Toolbar custom menu". Gates the
  settings form route `gin_toolbar_custom_menu.settings`
  (`/admin/config/system/gin-toolbar-custom-menu`).

Grant with drush:

```bash
drush role:perm:add administrator 'configure gin toolbar custom menu'
```

## Required core permission for end users

This is not defined by the module but is essential: any role you assign a custom toolbar menu to
in a rule must ALSO have the core **`access toolbar`** ("Use toolbar") permission — otherwise the
Gin toolbar (and therefore the custom menu) will not appear for that role.
