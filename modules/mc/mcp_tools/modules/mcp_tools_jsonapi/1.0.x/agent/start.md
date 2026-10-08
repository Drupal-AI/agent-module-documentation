<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools: JSON:API (mcp_tools_jsonapi) — agent index

Submodule of **mcp_tools**. Adds six generic entity-CRUD Tool API plugins (a fallback for entity
types without a dedicated MCP tool), addressing entities by UUID and enforcing Drupal entity access
on every call. Version **1.0.0-beta8** (dir `1.0.x`). Core `^10.3 || ^11 || ^12`.
Depends on: `mcp_tools:mcp_tools`, `drupal:jsonapi`.
Permission: **`mcp_tools use jsonapi`** (declared by the parent). Config route requires
`mcp_tools administer`.

- **The six tools, ids, inputs, and access checks** → [tools/entity-tools.md](tools/entity-tools.md)
- **Settings object, schema, defaults, allow/block lists** → [config/settings.md](config/settings.md)

## What it provides

- Six `#[Tool]` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase`
  (`MCP_CATEGORY = 'jsonapi'`): reads `DiscoverTypes` (`mcp_jsonapi_discover_types`), `GetEntity`
  (`mcp_jsonapi_get_entity`), `ListEntities` (`mcp_jsonapi_list_entities`); writes `CreateEntity`
  (`mcp_jsonapi_create_entity`), `UpdateEntity` (`mcp_jsonapi_update_entity`), `DeleteEntity`
  (`mcp_jsonapi_delete_entity`).
- Service `JsonApiService` (`mcp_tools_jsonapi.service`, `src/Service/JsonApiService.php`), wired to
  `entity_type.manager`, `jsonapi.resource_type.repository`, `entity.repository`, `config.factory`,
  `mcp_tools.access_manager`, `mcp_tools.audit_logger`, `current_user`.
- Config: object `mcp_tools_jsonapi.settings` (schema in `config/schema/`, defaults in
  `config/install/`), form `JsonApiSettingsForm` at route `mcp_tools_jsonapi.settings`
  (`/admin/config/services/mcp-tools/jsonapi`), menu link under MCP Tools settings.
- No permissions of its own, no Drush, no hooks.

## Access model

Two independent layers, both enforced: (1) the parent `McpToolsToolBase::checkAccess()` —
`mcp_tools use jsonapi` permission + connection scope (read for the read tools, `write` for the
mutating tools) + write-kind policy; and (2) **Drupal entity access** inside `JsonApiService`:
`getEntity` checks `$entity->access('view', $currentUser)`, `listEntities` uses `accessCheck(TRUE)`,
and create/update/delete each check `$entity->access('create'|'update'|'delete', $currentUser)` plus
`AccessManager::canWrite()`. Entity types are filtered by an always-blocked list and the configurable
allow/block lists (see settings). Every mutation is audit-logged. See [[mcp_tools]] for the shared
model.
