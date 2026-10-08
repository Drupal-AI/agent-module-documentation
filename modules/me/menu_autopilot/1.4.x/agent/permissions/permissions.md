<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — permissions

One permission (`menu_autopilot.permissions.yml`):

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Administer Menu Autopilot | `administer menu autopilot` | The settings page (`menu_autopilot.settings_form`, `/admin/structure/menu/autopilot`) — choosing which menus have automatic children and the default sort/limit. | `restrict access: true` (marked security-sensitive). |

The per-link "Menu Autopilot: children of …" section rides on the standard menu-link edit form, so it is available to users who can administer that menu (core's own menu permissions), not gated by a separate Menu Autopilot permission.

The two internal base fields (`menu_autopilot`, `menu_autopilot_dynamic`) are not exposed through field access at all: `menu_autopilot_entity_field_access()` forbids `view` and `edit` on them for every account (including user 1), so no JSON:API/REST/GraphQL client can read or write them regardless of permission.

The optional `menu_autopilot_mcp` submodule adds its own permissions (`use menu autopilot mcp tools`, `normalize menu link uris via mcp`) — see [its permissions doc](../../../modules/menu_autopilot_mcp/1.4.x/agent/permissions/permissions.md).
