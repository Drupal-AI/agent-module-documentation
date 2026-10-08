MCP Tools - Views adds six Tool API plugins that let an AI assistant create, configure, enable, disable, and delete Drupal Views through the parent MCP Tools server.

---

This is one of MCP Tools' domain submodules. Enabling it registers six `tool` plugins backed by `ViewsService` (service `mcp_tools_views.views_service`): `mcp_create_view`, `mcp_create_content_list_view`, `mcp_add_view_display`, `mcp_enable_view`, `mcp_disable_view`, and `mcp_delete_view`. All six are write operations on Views **configuration** — the submodule manages view definitions (displays, filters, defaults); it does not add a tool that executes an arbitrary view's results. It exposes no routes, config, or UI; the tools are reachable only through a connected MCP client or another Tool API consumer. Every call is governed by the parent's access model: the caller needs the `mcp_tools use views` permission, the connection must hold `write` scope, and the global read-only / config-only modes can block the change; each call runs as the configured execution user and is audit-logged. `DeleteView` additionally protects core/system views.

Turn this on when an assistant should build or maintain listings and other views from plain-English requests. See `agent/tools/view-tools.md` for the tool reference and the parent module for the shared access model.

---
- Ask the assistant to create a new view with a page display.
- Create a content-listing view with sensible defaults (`mcp_create_content_list_view`).
- Build a view that has both a page and a block display.
- Add a block display to an existing view.
- Add a feed or page display to a view with `mcp_add_view_display`.
- Enable a view that is currently disabled.
- Disable a view so its pages 404 and blocks hide, without deleting its config.
- Re-enable a previously disabled view.
- Delete a custom view that is no longer needed.
- Scaffold a listing of recent articles filtered by content type.
- Generate an admin content overview view from a description.
- Keep the tools hidden entirely by leaving this submodule disabled.
- Restrict a connection to `read` scope so no view config can be changed.
- Require `write` scope before an assistant may create or delete views.
- Gate the whole domain behind the `mcp_tools use views` permission.
- Block all view changes site-wide with the server's global read-only mode.
- Run the tools as a least-privilege execution account.
- Rely on the built-in core-view protection to avoid deleting system views.
- Audit which view tools are exposed on the MCP status page.
- Combine it with only the other domains an assistant needs.
