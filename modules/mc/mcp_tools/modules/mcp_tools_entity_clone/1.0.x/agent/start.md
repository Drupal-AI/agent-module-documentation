<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Entity Clone (mcp_tools_entity_clone) — agent index

Submodule of **mcp_tools**. Adds four Tool API plugins wrapping the Entity Clone module.
Installed release **1.0.0-beta8** (version dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Package *MCP Tools*.
Depends on `mcp_tools:mcp_tools`, `entity_clone:entity_clone`.
No config objects, routes, or forms of its own.

- **The four tools and EntityCloneService** → [tools/entity-clone-tools.md](tools/entity-clone-tools.md)

## What it is

Tools under `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (const `MCP_CATEGORY = 'entity_clone'`,
write kind `content`) and delegate to `EntityCloneService` (`mcp_tools_entity_clone.entity_clone`).
Base `checkAccess()` requires `mcp_tools use entity_clone` + the operation's scope + read-only off;
the two clone tools also call `accessManager->canWrite()`.

## Tools (4)

| id | class | op |
|----|-------|----|
| `mcp_entity_clone_types` | `GetCloneableTypes` | Read |
| `mcp_entity_clone_settings` | `GetCloneSettings` | Read |
| `mcp_entity_clone_clone` | `CloneEntity` | Write |
| `mcp_entity_clone_with_refs` | `CloneWithReferences` | Write |

## Service

- `mcp_tools_entity_clone.entity_clone` — `EntityCloneService` (entity type/field managers,
  config.factory, `mcp_tools.access_manager`, `mcp_tools.audit_logger`). Uses core
  `createDuplicate()`/`save()`; clones default to unpublished (`status = 0`) where the entity type
  supports a status key.

Permission (`mcp_tools_entity_clone.permissions.yml`, `restrict access: true`):
`mcp_tools use entity_clone`.
