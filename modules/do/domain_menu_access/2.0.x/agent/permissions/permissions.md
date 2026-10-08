<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `domain_menu_access.permissions.yml`.

| Permission | Title | Effect |
|---|---|---|
| `administer menu items across domains` | Administer Menu items across Domains | Lets the user work with menu links belonging to any domain, not only the active domain. In the menu overview (`domain_menu_access_preprocess_table__menu_overview`), users **without** it have rows whose link is not assigned to the active domain marked `visually-hidden`; users **with** it see all rows. |

The settings form route (`domain_menu_access.settings`) is gated by core Domain's
`administer domains` permission, not by a permission this module defines.

`hook_update_9001` (in `domain_menu_access.install`) grants
`administer menu items across domains` to every role that already has `administer domains`, so
existing domain admins keep full menu-management reach after updating.

```bash
drush role:perm:add site_admin 'administer menu items across domains'
```
