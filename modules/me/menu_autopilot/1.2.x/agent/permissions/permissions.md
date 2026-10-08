<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — permissions

One permission (`menu_autopilot.permissions.yml`):

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Administer Menu Autopilot | `administer menu autopilot` | The settings page (`menu_autopilot.settings_form`, `/admin/structure/menu/autopilot`) — choosing which menus have automatic children and the default sort/limit. | `restrict access: true` (marked as a security-sensitive permission). |

The per-link "Menu Autopilot: children of …" section rides on the standard menu-link edit form, so it is available to users who can administer that menu (core's own menu permissions), not gated by a separate Menu Autopilot permission.
