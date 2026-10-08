<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Menus (mcp_tools_menus) — agent index

Submodule of **mcp_tools**. Adds five Tool API plugins for managing menus and menu links, callable
by an AI assistant through the parent's MCP server. Version **1.0.0-beta8** (dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. Depends on: `mcp_tools:mcp_tools`, `drupal:menu_link_content`.
Permission: **`mcp_tools use menus`** (`restrict access: true`). No routes, config, or UI.

- **The five tools, ids, and inputs** → [tools/menu-tools.md](tools/menu-tools.md)

## What it provides

- Five `#[Tool]` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase`
  (`MCP_CATEGORY = 'menus'`), all `ToolOperation::Write`: `CreateMenu` (`mcp_menus_create_menu`),
  `DeleteMenu` (`mcp_menus_delete_menu`), `AddMenuLink` (`mcp_menus_add_menu_link`),
  `UpdateMenuLink` (`mcp_menus_update_menu_link`), `DeleteMenuLink` (`mcp_menus_delete_menu_link`).
- Service `MenuManagementService` (`mcp_tools_menus.menu`,
  `src/Service/MenuManagementService.php`) for the write operations; read-only menu inspection is in
  the parent's `MenuService`.
- No permissions beyond the one above, no Drush, no config schema, no hooks.

## Built-in guards (MenuManagementService)

- `PROTECTED_MENUS = ['admin', 'tools', 'account', 'main', 'footer']` cannot be deleted.
- `validateMenuUri()` restricts menu-link URIs to an allowed-scheme allowlist
  (`ALLOWED_URI_SCHEMES`) and rejects a blocked-pattern list (`BLOCKED_URI_PATTERNS`) before saving.
- Every mutating method begins with `AccessManager::canWrite()`, so `write` scope and the global
  read-only mode are enforced at the service layer.

## Access model

`McpToolsToolBase::checkAccess()` = `mcp_tools use menus` permission + `write` scope + write-kind
policy (category `menus` → **content**, because menu links are content entities). Every call runs as
the configured execution user and is audit-logged. See [[mcp_tools]] for the model.
