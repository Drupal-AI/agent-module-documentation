<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_entity_clone — tools reference

Plugins in `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (`MCP_CATEGORY = 'entity_clone'`) and
call `EntityCloneService` (`mcp_tools_entity_clone.entity_clone`). Base `checkAccess()`:
`mcp_tools use entity_clone` + scope + read-only off. Clone tools also call `canWrite()`.

## Tool table

| Tool id | Class | Operation → scope | Inputs | Returns |
|---------|-------|-------------------|--------|---------|
| `mcp_entity_clone_types` | `GetCloneableTypes` | Read → read | — | `types` (entity types + bundles), `count` |
| `mcp_entity_clone_settings` | `GetCloneSettings` | Read → read | `entity_type` (req), `bundle` (req) | `settings` (title_pattern / clone_references / exclude_fields / status), `reference_fields`, `paragraph_fields`, `has_paragraphs`, summary |
| `mcp_entity_clone_clone` | `CloneEntity` | Write → write | `entity_type` (req), `entity_id` (req), `title_prefix`, `title_suffix` (default " (Clone)"), `clone_children` (default true) | `original_id`, `new_id`, `new_uuid`, `new_title` |
| `mcp_entity_clone_with_refs` | `CloneWithReferences` | Write → write | `entity_type` (req), `entity_id` (req), `reference_fields` (list) | `new_id`, `new_uuid`, `new_title`, `cloned_references` (field → new ids) |

## Behaviour notes (from `EntityCloneService`)

- **`mcp_entity_clone_clone`**: `canWrite()` gate → load entity → `createDuplicate()` → set the label
  from `title_prefix`/`title_suffix` on the entity's label key → default the clone to `status = 0`
  (unpublished) when the type has a status key → `save()`. `clone_children` controls whether child
  paragraph references are deep-cloned (paragraph fields are duplicated so the clone owns its own
  paragraphs rather than sharing them).
- **`mcp_entity_clone_with_refs`**: `canWrite()` gate → duplicate the entity → for each requested
  `reference_fields` name, clone the referenced entities (`createDuplicate()` + `save()`) and rewrite
  the field on the clone to point at the new ids → `save()` the clone. Reports the mapping of each
  reference field to its newly created ids.
- **Read tools** enumerate cloneable types/bundles and read per-bundle clone settings from config; no
  mutation.
- Cloning goes through core entity storage (`createDuplicate`/`save`) — no raw SQL, no filesystem
  paths, no external HTTP.

## Operating it

1. `drush en mcp_tools_entity_clone -y` (needs `entity_clone`; parent `mcp_tools`).
2. Grant `mcp_tools use entity_clone` to the execution user; the clone tools need the **write** scope
   and read-only mode off.
3. Discover types (`mcp_entity_clone_types`), review clone behaviour
   (`mcp_entity_clone_settings`), then clone (`mcp_entity_clone_clone` /
   `mcp_entity_clone_with_refs`). Clones arrive unpublished for review.
