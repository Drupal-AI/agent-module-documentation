<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_views — tool reference

All tools extend `McpToolsToolBase` (`MCP_CATEGORY = 'views'`), are `ToolOperation::Write`, require
the `mcp_tools use views` permission plus `write` scope, and delegate to `ViewsService`
(`mcp_tools_views.views_service`). All operate on view config entities.

| Tool id | Class | Purpose |
|---|---|---|
| `mcp_create_view` | `CreateView` | Create a new view, optionally with page and/or block displays. |
| `mcp_create_content_list_view` | `CreateContentListView` | Create a content-listing view with sensible defaults (a common shortcut over `CreateView`). |
| `mcp_add_view_display` | `AddViewDisplay` | Add a display (page, block, feed, …) to an existing view. |
| `mcp_enable_view` | `EnableView` | Enable a disabled view. |
| `mcp_disable_view` | `DisableView` | Disable an enabled view (its pages 404, blocks hide); config is preserved for re-enable. |
| `mcp_delete_view` | `DeleteView` | Delete a view. Core/system views are protected and cannot be deleted. |

## Behavior notes

- All six are configuration mutations; they change the stored view definition, not runtime output.
- `DisableView` is non-destructive — it flips the view's status; `EnableView` reverses it.
- `DeleteView` refuses to remove protected core views, guarding against accidental removal of
  system listings.
- Because category `views` maps to the **config** write-kind, these tools are also blocked when the
  server is in config-only mode and the config write-kind is disallowed, and always when the global
  read-only mode is on. See the parent module for how scopes and write-kinds combine.
