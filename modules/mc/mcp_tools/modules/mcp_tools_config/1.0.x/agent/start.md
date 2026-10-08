<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Config Management (mcp_tools_config) — agent index

Submodule of **mcp_tools**. Adds five Tool API plugins for configuration drift inspection, dry-run
operation previews, and config export. Installed release **1.0.0-beta8** (version dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Package *MCP Tools*.
Depends only on `mcp_tools:mcp_tools`. No config objects, routes, forms, or Drush of its own.

- **The five tools, their scopes, and the services behind them** → [tools/config-tools.md](tools/config-tools.md)

## What it is

Each tool extends `Drupal\mcp_tools\Tool\McpToolsToolBase` (const `MCP_CATEGORY = 'config'`) and is
discovered as a `tool` plugin under `src/Plugin/tool/Tool/`. The base `checkAccess()` requires the
`mcp_tools use config` permission, the connection scope matching the tool's `ToolOperation`
(Read→read, Trigger→admin), the config write-kind policy, and that global read-only mode is off.

## Tools (5)

| id | class | op | reads/writes |
|----|-------|----|--------------|
| `mcp_config_changes` | `GetConfigChanges` | Read | active-vs-sync changelist |
| `mcp_config_diff` | `GetConfigDiff` | Read | field-level diff of one config object |
| `mcp_config_mcp_changes` | `GetMcpChanges` | Read | config entities tracked as MCP-touched |
| `mcp_config_preview` | `PreviewOperation` | Read | dry-run of a site-building operation |
| `mcp_config_export` | `ExportConfig` | Trigger | writes active config to the sync dir (admin scope + `confirm=true`) |

## Services (`mcp_tools_config.services.yml`)

- `mcp_tools_config.config_management` — facade (`ConfigManagementService`) the tools call.
- `mcp_tools_config.config_comparison` — `ConfigComparisonService` (StorageComparer + YAML diff).
- `mcp_tools_config.operation_preview` — `OperationPreviewService` (the `previewOperation()` match).
- `mcp_tools_config.mcp_change_tracker` — `McpChangeTracker` (state key `mcp_tools.config_changes`).
- `mcp_tools_config.config_change_subscriber` — `McpConfigChangeSubscriber` records config saves made
  inside an MCP tool call (via `mcp_tools.tool_call_context`).

Permissions (`mcp_tools_config.permissions.yml`, both `restrict access: true`): `mcp_tools use config`,
`mcp_tools export config`.
