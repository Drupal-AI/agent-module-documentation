<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Views (mcp_tools_views) — agent index

Submodule of **mcp_tools**. Adds six Tool API plugins for managing Drupal Views **configuration**,
callable by an AI assistant through the parent's MCP server. Version **1.0.0-beta8** (dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. Depends on: `mcp_tools:mcp_tools`, `drupal:views`.
Permission: **`mcp_tools use views`** (`restrict access: true`). No routes, config, or UI.

- **The six tools, ids, inputs, and guards** → [tools/view-tools.md](tools/view-tools.md)

## What it provides

- Six `#[Tool]` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase`
  (`MCP_CATEGORY = 'views'`), all `ToolOperation::Write`: `CreateView` (`mcp_create_view`),
  `CreateContentListView` (`mcp_create_content_list_view`), `AddViewDisplay`
  (`mcp_add_view_display`), `EnableView` (`mcp_enable_view`), `DisableView` (`mcp_disable_view`),
  `DeleteView` (`mcp_delete_view`).
- One service, `ViewsService` (`mcp_tools_views.views_service`,
  `src/Service/ViewsService.php`), holding the create/display/enable/disable/delete logic.
- No permissions beyond the one above, no Drush, no config schema, no hooks.

## Scope note

These tools operate on view **definitions** (config entities), not on the rendered results of a
view. There is no "run this view and return rows" tool here, so there is no path that executes a
view outside its own configured access — result-level access is Views' own concern when a view is
later rendered normally.

## Access model (from the parent)

`McpToolsToolBase::checkAccess()` = `mcp_tools use views` permission AND `write` scope AND the
config-only write-kind policy (category `views` → default write-kind **config**), plus the global
read-only mode. Each call runs as the configured execution user and is audit-logged. See
[[mcp_tools]] for the model. `DeleteView` protects core/system views.
