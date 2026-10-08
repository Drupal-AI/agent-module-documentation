<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_migration — tools reference

Plugins in `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (`MCP_CATEGORY = 'migration'`) and call
`MigrationService` (`mcp_tools_migration.migration`). Base `checkAccess()`: `mcp_tools use migration`
+ scope + read-only off. Write tools also call `accessManager->canWrite()` inside the service. All
imports/exports operate on **nodes** and are capped at **100 items** per call.

## Tool table

| Tool id | Class | Operation → scope | Inputs | Returns |
|---------|-------|-------------------|--------|---------|
| `mcp_migration_import_csv` | `ImportFromCsv` | Write → write | `content_type` (req), `csv_data` (req, header row first), `field_mapping` (map) | `import_id`, `total`, `created`, `failed`, created items (nid+title), failed items |
| `mcp_migration_import_json` | `ImportFromJson` | Write → write | `content_type` (req), `items` (req, list of `{title, ...fields}`) | `import_id`, `total`, `created`, `failed`, created/failed lists |
| `mcp_migration_export_csv` | `ExportToCsv` | Write → write | `content_type` (req), `limit` (≤100, default 100) | `count`, `fields`, `csv` string |
| `mcp_migration_export_json` | `ExportToJson` | Write → write | `content_type` (req), `limit` (≤100, default 100) | `count`, `items` array |
| `mcp_migration_field_mapping` | `GetFieldMapping` | Read → read | `content_type` (req) | required + optional fields (label/type/description, `allowed_values` for list fields) |
| `mcp_migration_validate` | `ValidateImport` | Read → read | `content_type` (req), `items` (req) | `valid`, `error_count`, `warning_count`, per-row `errors`/`warnings` |
| `mcp_migration_import_status` | `GetImportStatus` | Read → read | — | last import: `import_id`, `status`, `total`, `processed`, `failed`, timestamps |

## Behaviour notes (from `MigrationService`)

- **Imports** load the `node_type`, reject batches over `MAX_IMPORT_ITEMS` (100), then
  `entityTypeManager->getStorage('node')->create($nodeData)` + `save()` per row, accumulating
  created/failed lists and recording an import-status record in state.
- **Export** clamps `limit` to `MAX_EXPORT_ITEMS` (100) via `min()`, loads nodes of the type, slices
  to the limit, and serialises. CSV export quotes any value containing `,`, `"`, or newline
  (`escapeCsvValue`), so injected delimiters do not break rows.
- **Protected fields**: a regex pattern rejects attempts to set system/identity fields (nid, uuid,
  vid, etc.) from import data — import cannot overwrite entity identity or revision keys.
- **`mcp_migration_validate`** and **`mcp_migration_field_mapping`** are read-only helpers that never
  create content; use them to prepare and dry-run an import.

## Operating it

1. `drush en mcp_tools_migration -y` (parent `mcp_tools` enabled).
2. Grant `mcp_tools use migration` to the execution user; import/export need the **write** scope and
   read-only mode off.
3. Inspect the target bundle (`mcp_migration_field_mapping`), validate the batch
   (`mcp_migration_validate`), import (`mcp_migration_import_csv`/`_json`), and confirm with
   `mcp_migration_import_status`.
