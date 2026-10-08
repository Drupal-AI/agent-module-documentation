<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_jsonapi — tool reference

All tools extend `McpToolsToolBase` (`MCP_CATEGORY = 'jsonapi'`), require the `mcp_tools use jsonapi`
permission, and delegate to `JsonApiService` (`mcp_tools_jsonapi.service`). Entities are addressed by
**UUID**. Every call also passes Drupal entity access for the execution user.

| Tool id | Class | Op | Purpose | Key inputs |
|---|---|---|---|---|
| `mcp_jsonapi_discover_types` | `DiscoverTypes` | Read | List exposed entity types + bundles (skips blocked/internal types, applies allowlist). | — |
| `mcp_jsonapi_get_entity` | `GetEntity` | Read | Fetch one entity, serialized. | `entity_type`*, `uuid`*, `bundle` |
| `mcp_jsonapi_list_entities` | `ListEntities` | Read | List entities with filters + pagination. | `entity_type`*, `bundle`, `filters`, `limit`, `offset` |
| `mcp_jsonapi_create_entity` | `CreateEntity` | Write | Create an entity of an exposed type/bundle. | `entity_type`*, `bundle`*, `fields`* |
| `mcp_jsonapi_update_entity` | `UpdateEntity` | Write | Update only the given fields of an entity. | `entity_type`*, `uuid`*, `fields`* |
| `mcp_jsonapi_delete_entity` | `DeleteEntity` | Write | Permanently delete an entity. | `entity_type`*, `uuid`* |

`*` = required. **Op** is the declared `ToolOperation` (Read tools need read scope; Write tools need
`write` scope + not-read-only).

## Access enforcement (JsonApiService)

- `getEntity()` → `$entity->access('view', $currentUser)` before returning data.
- `listEntities()` / count queries → entity query `->accessCheck(TRUE)`.
- `createEntity()` → `canWrite()` then `$entity->access('create', $currentUser)`.
- `updateEntity()` → `canWrite()` then `$entity->access('update', $currentUser)`.
- `deleteEntity()` → `canWrite()` then `$entity->access('delete', $currentUser)`.
- All entity types run through `isEntityTypeBlocked()` (always-blocked internal list + the config
  `blocked_entity_types`), and, when `allowed_entity_types` is non-empty, an allowlist.

## Serialization

`serializeEntity()` returns `entity_type`, `bundle`, `id`, `uuid`, `label`, common base fields
(`status`, `created`, `changed`), and each remaining field's value. Entity-reference fields are
omitted unless `include_relationships` is enabled in settings. Because view access is checked first,
a caller only ever serializes entities the execution user may see.
