<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Templates (mcp_tools_templates) — agent index

Submodule of **mcp_tools**. MCP tools for site configuration templates - apply pre-built site configurations for common use cases. Core `^10.3 || ^11 || ^12`. Package `MCP`.
Depends on: `mcp_tools:mcp_tools`. Permission: `mcp_tools use templates`.

It registers **5 Tool API plugins** in `src/Plugin/tool/Tool/` (all `MCP_CATEGORY` matching this domain), delegating to service(s) `mcp_tools_templates.template + .component_factory`.

## Access model (inherited from mcp_tools)

Each tool extends `McpToolsToolBase`; dispatch calls `checkAccess()`, which requires the `mcp_tools use templates` permission **and** an MCP scope matching the tool's `ToolOperation` (Read->read, Write->write, Trigger->admin) **and** passes the config-only / global read-only policy. Mutating services additionally re-check `AccessManager::canWrite()` (or `canAdmin()`) and audit-log via `mcp_tools.audit_logger`. See [[mcp_tools]] for the full model.

## Tools (5)

`ListTemplates`, `GetTemplate`, `PreviewTemplate`, `ApplyTemplate`, `ExportAsTemplate`. Full list with ids, operations and target services -> [agent/tools/templates.md](tools/templates.md).

