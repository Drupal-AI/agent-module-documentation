<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Blocks (mcp_tools_blocks) — agent index

Submodule of **mcp_tools**. Block placement operations: place, remove, configure blocks in theme regions. Core `^10.3 || ^11 || ^12`. Package `MCP Tools`.
Depends on: `mcp_tools:mcp_tools`, `drupal:block`. Permission: `mcp_tools use blocks`.

It registers **5 Tool API plugins** in `src/Plugin/tool/Tool/` (all `MCP_CATEGORY` matching this domain), delegating to service(s) `mcp_tools_blocks.block (Drupal\mcp_tools_blocks\Service\BlockService)`.

## Access model (inherited from mcp_tools)

Each tool extends `McpToolsToolBase`; dispatch calls `checkAccess()`, which requires the `mcp_tools use blocks` permission **and** an MCP scope matching the tool's `ToolOperation` (Read->read, Write->write, Trigger->admin) **and** passes the config-only / global read-only policy. Mutating services additionally re-check `AccessManager::canWrite()` (or `canAdmin()`) and audit-log via `mcp_tools.audit_logger`. See [[mcp_tools]] for the full model.

## Tools (5)

`ListAvailableBlocks`, `ListRegions`, `PlaceBlock`, `ConfigureBlock`, `RemoveBlock`. Full list with ids, operations and target services -> [agent/tools/blocks.md](tools/blocks.md).

