<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Blocks — Block-placement tools

Submodule `mcp_tools_blocks`. All plugins live in `src/Plugin/tool/Tool/` and extend `Drupal\mcp_tools\Tool\McpToolsToolBase`. Permission for every tool: `mcp_tools use blocks`. `operation` sets the required MCP scope (Read->read, Write->write, Trigger->admin); `destructive` tools require explicit client confirmation.

| Tool id | Class | Operation | Notes |
| --- | --- | --- | --- |
| `mcp_list_available_blocks` | ListAvailableBlocks | Read | List block plugins available to place. -> BlockService::listAvailableBlocks(). |
| `mcp_list_regions` | ListRegions | Read | List a theme's regions. -> BlockService::listRegions(). |
| `mcp_place_block` | PlaceBlock | Write | Place a block plugin into a theme region (creates a block config entity). -> BlockService::placeBlock(). |
| `mcp_configure_block` | ConfigureBlock | Write | Update settings/visibility of a placed block. -> BlockService::configureBlock(). |
| `mcp_remove_block` | RemoveBlock | Write (destructive) | Remove a placed block. -> BlockService::removeBlock(). |

Scope mapping: Read tools are usable by a read-scoped connection; Write tools need a write scope and fail closed under global read-only / config-only mode; Trigger tools need an admin scope. Services re-verify the scope and audit-log each mutation.

