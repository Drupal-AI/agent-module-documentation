<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Content (mcp_tools_content) — agent index

Submodule of **mcp_tools**. Content CRUD operations: create, update, delete, and publish nodes. Core `^10.3 || ^11 || ^12`. Package `MCP Tools`.
Depends on: `mcp_tools:mcp_tools`, `drupal:node`. Permission: `mcp_tools use content`.

It registers **4 Tool API plugins** in `src/Plugin/tool/Tool/` (all `MCP_CATEGORY` matching this domain), delegating to service(s) `mcp_tools_content.content (Drupal\mcp_tools_content\Service\ContentService)`.

## Access model (inherited from mcp_tools)

Each tool extends `McpToolsToolBase`; dispatch calls `checkAccess()`, which requires the `mcp_tools use content` permission **and** an MCP scope matching the tool's `ToolOperation` (Read->read, Write->write, Trigger->admin) **and** passes the config-only / global read-only policy. Mutating services additionally re-check `AccessManager::canWrite()` (or `canAdmin()`) and audit-log via `mcp_tools.audit_logger`. See [[mcp_tools]] for the full model.

## Tools (4)

`CreateContent`, `UpdateContent`, `PublishContent`, `DeleteContent`. Full list with ids, operations and target services -> [agent/tools/content.md](tools/content.md).

