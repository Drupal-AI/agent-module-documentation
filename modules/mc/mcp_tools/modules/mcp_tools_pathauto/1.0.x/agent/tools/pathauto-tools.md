<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pathauto tools

Plugins in `src/Plugin/tool/Tool/`, all `MCP_CATEGORY = 'pathauto'` → permission
**`mcp_tools use pathauto`**. Read ops need read scope; Write ops need write scope, a
non-read-only connection, and a write-kind the connection's policy allows. Each delegates to
`mcp_tools_pathauto.pathauto` (`PathautoService`).

| Tool id | Class | Op | Write-kind | Destructive | Inputs | Does |
|---|---|---|---|---|---|---|
| `mcp_pathauto_list_patterns` | `ListPatterns` | Read | - | - | entity_type? | Lists pathauto patterns, optionally filtered by entity type. |
| `mcp_pathauto_get_pattern` | `GetPattern` | Read | - | - | id | Returns one pattern's config. |
| `mcp_pathauto_create` | `CreatePattern` | Write | config | - | id, label, pattern, entity_type, bundle? | Creates a pathauto pattern (e.g. `[node:title]`) for an entity type/bundle. |
| `mcp_pathauto_update` | `UpdatePattern` | Write | config | - | id, label?, pattern?, weight?, status?, bundle? | Updates fields of an existing pattern. |
| `mcp_pathauto_delete` | `DeletePattern` | Write | config | yes | id | Deletes a pattern. |
| `mcp_pathauto_generate` | `GenerateAliases` | Write | content | - | entity_type, bundle?, update? | Bulk-generates aliases for existing entities; update=true also refreshes existing aliases. |

## Notes

- Pattern CRUD is config write-kind; `GenerateAliases` overrides to content write-kind (it writes path_alias entities).
- All mutating methods re-check `AccessManager::canWrite()`; read methods re-check `canRead()`.
