<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_menus — tool reference

All tools extend `McpToolsToolBase` (`MCP_CATEGORY = 'menus'`), are `ToolOperation::Write`, require
the `mcp_tools use menus` permission plus `write` scope, and delegate to `MenuManagementService`
(`mcp_tools_menus.menu`). Category maps to the **content** write-kind; each method re-checks
`AccessManager::canWrite()`.

| Tool id | Class | Purpose | Key inputs |
|---|---|---|---|
| `mcp_menus_create_menu` | `CreateMenu` | Create a new custom menu. | `id`*, `label`*, `description` |
| `mcp_menus_delete_menu` | `DeleteMenu` | Delete a custom menu (system menus blocked). | `id`* |
| `mcp_menus_add_menu_link` | `AddMenuLink` | Add a link to a menu. | `menu_name`*, `title`*, `uri`*, `weight`, `parent`, `expanded` |
| `mcp_menus_update_menu_link` | `UpdateMenuLink` | Update a menu link's fields. | `link_id`*, `updates`* |
| `mcp_menus_delete_menu_link` | `DeleteMenuLink` | Delete a menu link by id. | `link_id`* |

`*` = required. All five are blocked under global read-only mode and need `write` scope.

## Guards

- `DeleteMenu` refuses `admin`, `tools`, `account`, `main`, `footer` (`PROTECTED_MENUS`).
- `AddMenuLink`/`UpdateMenuLink` route the link `uri` through `validateMenuUri()`, which enforces an
  allowed-scheme allowlist (`ALLOWED_URI_SCHEMES`) and rejects the blocked patterns
  (`BLOCKED_URI_PATTERNS`) — unsafe link targets are refused before save.
- `CreateMenu` returns the new menu's admin path (`/admin/structure/menu/manage/{id}`).
- All operations are audit-logged via `mcp_tools.audit_logger`.
