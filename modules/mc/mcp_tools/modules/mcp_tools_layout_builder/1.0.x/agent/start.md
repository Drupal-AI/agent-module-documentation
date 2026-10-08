<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Layout Builder (mcp_tools_layout_builder) — agent index

Submodule of **mcp_tools**. MCP tools for Layout Builder management. Core `^10.3 || ^11 || ^12`. Package `MCP`.
Depends on: `mcp_tools:mcp_tools`, `drupal:layout_builder`. Permission: `mcp_tools use layout_builder`.

It registers **9 Tool API plugins** in `src/Plugin/tool/Tool/` (all `MCP_CATEGORY` matching this domain), delegating to service(s) `mcp_tools_layout_builder.layout_builder (Drupal\mcp_tools_layout_builder\Service\LayoutBuilderService)`.

## Access model (inherited from mcp_tools)

Each tool extends `McpToolsToolBase`; dispatch calls `checkAccess()`, which requires the `mcp_tools use layout_builder` permission **and** an MCP scope matching the tool's `ToolOperation` (Read->read, Write->write, Trigger->admin) **and** passes the config-only / global read-only policy. Mutating services additionally re-check `AccessManager::canWrite()` (or `canAdmin()`) and audit-log via `mcp_tools.audit_logger`. See [[mcp_tools]] for the full model.

## Tools (9)

`EnableLayoutBuilder`, `DisableLayoutBuilder`, `AllowCustomLayouts`, `GetLayout`, `ListLayoutPlugins`, `AddSection`, `RemoveSection`, `AddBlock`, `RemoveBlock`. Full list with ids, operations and target services -> [agent/tools/layout-builder.md](tools/layout-builder.md).

