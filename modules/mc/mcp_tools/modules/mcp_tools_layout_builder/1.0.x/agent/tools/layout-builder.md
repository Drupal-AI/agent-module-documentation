<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Layout Builder — Layout Builder tools

Submodule `mcp_tools_layout_builder`. All plugins live in `src/Plugin/tool/Tool/` and extend `Drupal\mcp_tools\Tool\McpToolsToolBase`. Permission for every tool: `mcp_tools use layout_builder`. `operation` sets the required MCP scope (Read->read, Write->write, Trigger->admin); `destructive` tools require explicit client confirmation.

| Tool id | Class | Operation | Notes |
| --- | --- | --- | --- |
| `mcp_layout_enable` | EnableLayoutBuilder | Write | Enable Layout Builder on a bundle's view display. -> LayoutBuilderService (enable). |
| `mcp_layout_disable` | DisableLayoutBuilder | Write (destructive) | Disable Layout Builder for a bundle (discards its layout). |
| `mcp_layout_allow_custom` | AllowCustomLayouts | Read | Toggle per-entity layout overrides for a bundle. Note: mutates the view display; the service still enforces `AccessManager::canWrite()`. |
| `mcp_layout_get` | GetLayout | Read | Read the current sections/blocks of a layout. -> LayoutBuilderService (get). |
| `mcp_layout_list_plugins` | ListLayoutPlugins | Read | List available layout plugins (e.g. one/two/three column). -> core.layout manager. |
| `mcp_layout_add_section` | AddSection | Write | Add a layout section using a layout plugin. |
| `mcp_layout_remove_section` | RemoveSection | Write (destructive) | Remove a layout section. |
| `mcp_layout_add_block` | AddBlock | Write | Add a block component into a section region. |
| `mcp_layout_remove_block` | RemoveBlock | Write (destructive) | Remove a block component from a layout. |

Scope mapping: Read tools are usable by a read-scoped connection; Write tools need a write scope and fail closed under global read-only / config-only mode; Trigger tools need an admin scope. Services re-verify the scope and audit-log each mutation.

