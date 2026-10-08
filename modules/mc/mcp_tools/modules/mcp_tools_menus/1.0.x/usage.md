MCP Tools - Menus adds five Tool API plugins that let an AI assistant create and delete menus and add, update, and delete menu links through the parent MCP Tools server.

---

This is one of MCP Tools' domain submodules. Enabling it registers five write `tool` plugins backed by `MenuManagementService` (service `mcp_tools_menus.menu`): `mcp_menus_create_menu`, `mcp_menus_delete_menu`, `mcp_menus_add_menu_link`, `mcp_menus_update_menu_link`, `mcp_menus_delete_menu_link`. (Read-only menu inspection lives in the parent's `MenuService`.) The service guards its operations: the system menus `admin`, `tools`, `account`, `main`, and `footer` cannot be deleted, and every menu-link URI is validated against an allowed-scheme allowlist and a blocked-pattern list before it is saved. It exposes no routes, config, or UI; the tools are reachable only through a connected MCP client or another Tool API consumer. All five need the `mcp_tools use menus` permission and `write` scope, are subject to the global read-only / config-only modes (category `menus` → content write-kind), run as the configured execution user, and are audit-logged.

Turn this on when an assistant should build or maintain site navigation from plain-English requests. See `agent/tools/menu-tools.md`.

---
- Create a new custom menu with a label and description.
- Delete a custom menu that is no longer needed.
- Add a link to a menu pointing at an internal path.
- Add a link with a weight, parent, and expanded setting.
- Update a menu link's title, URL, or ordering.
- Move a menu link under a different parent.
- Delete a single menu link.
- Build a footer navigation menu from a description.
- Reorder items in the main menu.
- Add links to a newly created content section.
- Keep the tools hidden entirely by leaving this submodule disabled.
- Restrict a connection to `read` scope so no menu changes are possible.
- Require `write` scope before an assistant may create or delete menus.
- Gate the whole domain behind the `mcp_tools use menus` permission.
- Block all menu changes site-wide with the server's global read-only mode.
- Rely on the built-in protection for the five core system menus.
- Rely on menu-link URI validation to reject unsafe link targets.
- Run the tools as a least-privilege execution account.
- Audit which menu tools are exposed on the MCP status page.
- Combine it with only the other domains an assistant needs.
