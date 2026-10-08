MCP Tools: JSON:API adds six generic entity-CRUD Tool API plugins so an AI assistant can discover, read, list, create, update, and delete Drupal content entities of any exposed type through the parent MCP Tools server.

---

This is one of MCP Tools' domain submodules and a generic fallback for entity types that have no dedicated MCP tool. Enabling it registers six `tool` plugins backed by `JsonApiService` (service `mcp_tools_jsonapi.service`): `mcp_jsonapi_discover_types`, `mcp_jsonapi_get_entity`, `mcp_jsonapi_list_entities` (read), and `mcp_jsonapi_create_entity`, `mcp_jsonapi_update_entity`, `mcp_jsonapi_delete_entity` (write). Entities are addressed by UUID and every operation checks Drupal entity access (`view`/`create`/`update`/`delete`) as the configured execution user. Which entity types are reachable is controlled by the config object `mcp_tools_jsonapi.settings` (allow/block lists, page size, relationship inclusion), configurable at `/admin/config/services/mcp-tools/jsonapi` (route requires `mcp_tools administer`). A built-in always-blocked list plus a default block list keep sensitive types (users, webform submissions, redirects, menu links, path aliases, shortcuts) off by default. The tools require the `mcp_tools use jsonapi` permission (declared by the parent) and the connection scope for the operation; writes are also subject to global read-only / config-only modes and are audit-logged.

Turn this on when an assistant needs generic CRUD over content entities that lack a purpose-built tool. See `agent/tools/entity-tools.md` and `agent/config/settings.md`.

---
- Discover which entity types and bundles are exposed (`mcp_jsonapi_discover_types`).
- Fetch a single entity by type and UUID.
- List entities of a type with filters and pagination.
- Create a new entity of an exposed content type.
- Update selected fields on an existing entity by UUID.
- Delete an entity by UUID (permanent).
- Reach a content entity type that has no dedicated MCP submodule.
- Restrict exposure to an explicit allowlist of entity types via settings.
- Block additional entity types beyond the secure defaults.
- Cap list responses with `max_items_per_page`.
- Include or exclude entity-reference fields in responses (`include_relationships`).
- Disable write operations for JSON:API tools independently (`allow_write_operations`).
- Keep the tools hidden entirely by leaving this submodule disabled.
- Restrict a connection to `read` scope so create/update/delete are blocked.
- Require `write` scope before an assistant may mutate entities.
- Rely on per-entity access checks so the execution user only touches what it may.
- Block all writes site-wide with the server's global read-only mode.
- Run the tools as a least-privilege execution account.
- Keep users and webform submissions off-limits with the default block list.
- Audit which entity tools are exposed on the MCP status page.
