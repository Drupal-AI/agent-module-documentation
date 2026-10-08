<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Migration (mcp_tools_migration) — agent index

Submodule of **mcp_tools**. Adds seven Tool API plugins for CSV/JSON node import, export, and
validation. Installed release **1.0.0-beta8** (version dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Package *MCP Tools*.
Depends only on `mcp_tools:mcp_tools`. No config objects, routes, or forms of its own.

- **The seven tools, limits, and MigrationService** → [tools/migration-tools.md](tools/migration-tools.md)

## What it is

Tools under `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (const `MCP_CATEGORY = 'migration'`,
so the write kind resolves to `content`) and delegate to `MigrationService`
(`mcp_tools_migration.migration`). Base `checkAccess()` requires `mcp_tools use migration` + the
operation's scope (Read→read, Write→write) + read-only off; the Write tools also call
`accessManager->canWrite()`. Imports/exports are capped at 100 items (`MAX_IMPORT_ITEMS` /
`MAX_EXPORT_ITEMS`). Only `node` entities are handled.

## Tools (7)

| id | class | op |
|----|-------|----|
| `mcp_migration_import_csv` | `ImportFromCsv` | Write |
| `mcp_migration_import_json` | `ImportFromJson` | Write |
| `mcp_migration_export_csv` | `ExportToCsv` | Write |
| `mcp_migration_export_json` | `ExportToJson` | Write |
| `mcp_migration_field_mapping` | `GetFieldMapping` | Read |
| `mcp_migration_validate` | `ValidateImport` | Read |
| `mcp_migration_import_status` | `GetImportStatus` | Read |

## Service

- `mcp_tools_migration.migration` — `MigrationService` (entity type/field managers, current_user,
  state, `mcp_tools.access_manager`, `mcp_tools.audit_logger`). Last-import status kept in state;
  a protected-field pattern blocks system fields (nid/uuid/etc.) from being set via import.

Permission (`mcp_tools_migration.permissions.yml`, `restrict access: true`): `mcp_tools use migration`.
