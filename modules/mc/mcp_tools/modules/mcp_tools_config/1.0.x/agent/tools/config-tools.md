<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_config — tools reference

All plugins live in `src/Plugin/tool/Tool/` and extend `McpToolsToolBase` with
`MCP_CATEGORY = 'config'`. Access (base `checkAccess()`): permission `mcp_tools use config` +
scope for the operation + global read-only off. The tools delegate to
`mcp_tools_config.config_management` (`ConfigManagementService`), which fans out to the comparison,
preview, and change-tracker services.

## Tool table

| Tool id | Class | Operation → scope | Inputs | Returns |
|---------|-------|-------------------|--------|---------|
| `mcp_config_changes` | `GetConfigChanges` | Read → read | — | `has_changes`, `total_changes`, `summary` (new/modified/deleted/renamed counts), `changes` grouped by op |
| `mcp_config_diff` | `GetConfigDiff` | Read → read | `config_name` (req) | `status` (unchanged / modified / new_in_active / deleted_from_active), `diff` list, plus `sync_data` and `active_data` (full config values) |
| `mcp_config_mcp_changes` | `GetMcpChanges` | Read → read | — | `total`, `by_operation`, `changes` (config_name + timestamp, tracked in state) |
| `mcp_config_preview` | `PreviewOperation` | Read → read | `operation` (req), `params` (map) | dry-run description: `action`, `description`, `affected_configs`; never mutates |
| `mcp_config_export` | `ExportConfig` | Trigger → **admin** | `confirm` (bool, req) | `exported`, `deleted_from_sync`, `changes_resolved`, `message` |

## Behaviour notes (from source)

- **`mcp_config_changes` / `mcp_config_diff`** wrap `ConfigComparisonService`. `getConfigChanges()`
  builds a core `StorageComparer(active, sync)` changelist. `getConfigDiff($name)` reads the object
  from both storages, YAML-dumps each, and returns a recursive key diff **plus the raw values**.
- **`mcp_config_preview`** routes `operation` through `OperationPreviewService::previewOperation()`'s
  `match`: `export_config`, `import_config`, `delete_config`, `create_role`, `delete_role`,
  `grant_permissions`, `revoke_permissions`, `create_content_type`, `delete_content_type`,
  `add_field`, `delete_field`, `create_vocabulary`, `create_view`. Each branch only *reads* active
  storage to describe the change; results are stamped `dry_run: true`. An empty/unknown `operation`
  returns the supported-operation list.
- **`mcp_config_export`** first requires `confirm=true` (else returns `CONFIRMATION_REQUIRED`), then
  `ConfigManagementService::exportConfig()` re-checks `accessManager->canAdmin()` before writing
  every active object into sync storage and deleting sync objects absent from active. It audit-logs
  via `mcp_tools.audit_logger` and clears the MCP change tracker. It is the only mutating tool here.
- **Change tracking**: `McpChangeTracker` stores up to 500 entries under state key
  `mcp_tools.config_changes`; `McpConfigChangeSubscriber` feeds it when config is saved during a
  tool call (`mcp_tools.tool_call_context`).

## Operating it

1. `drush en mcp_tools_config -y` (parent `mcp_tools` must be enabled).
2. Grant `mcp_tools use config` to the execution user; grant/keep the admin scope on the connection
   only if export is needed.
3. Inspect drift with `mcp_config_changes`, drill into one object with `mcp_config_diff`, dry-run a
   planned change with `mcp_config_preview`, then export with `mcp_config_export` (`confirm=true`).
