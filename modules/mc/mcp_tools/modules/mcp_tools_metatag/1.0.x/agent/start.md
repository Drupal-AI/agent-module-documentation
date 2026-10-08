<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Metatag (mcp_tools_metatag) — agent index

Submodule of **mcp_tools**. Adds five Tool API plugins wrapping the Metatag module.
Installed release **1.0.0-beta8** (version dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Package *MCP Tools*.
Depends on `mcp_tools:mcp_tools`, `metatag:metatag`.
No config objects, routes, or forms of its own.

- **The five tools and MetatagService** → [tools/metatag-tools.md](tools/metatag-tools.md)

## What it is

Tools under `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (const `MCP_CATEGORY = 'metatag'`) and
delegate to `MetatagService` (`mcp_tools_metatag.metatag`). Base `checkAccess()` requires
`mcp_tools use metatag` + the operation's scope + read-only off; the Write tool also calls
`accessManager->canWrite()`. Note the `metatag` category is not in the base's content/ops write-kind
map, so its write kind resolves to `config` (relevant only under config-only mode).

## Tools (5)

| id | class | op |
|----|-------|----|
| `mcp_metatag_list_groups` | `ListMetatagGroups` | Read |
| `mcp_metatag_list_tags` | `ListAvailableTags` | Read |
| `mcp_metatag_get_defaults` | `GetMetatagDefaults` | Read |
| `mcp_metatag_get_entity` | `GetEntityMetatags` | Read |
| `mcp_metatag_set_entity` | `SetEntityMetatags` | Write |

## Service

- `mcp_tools_metatag.metatag` — `MetatagService` (entity type manager,
  `plugin.manager.metatag.tag`, `plugin.manager.metatag.group`, `metatag.manager`,
  `mcp_tools.access_manager`, `mcp_tools.audit_logger`).

Permission (`mcp_tools_metatag.permissions.yml`, `restrict access: true`): `mcp_tools use metatag`.
