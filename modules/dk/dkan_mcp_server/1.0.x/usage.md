<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DKAN MCP Server exposes DKAN's catalog, datastore, harvest and metastore-write operations as Model Context Protocol (MCP) tools, built on the contrib `mcp_server` base with per-tool Drupal-permission access control.
---
The module is a thin adapter: it delegates MCP transport, tool discovery and session handling to the `mcp_server` module and contributes only the DKAN `#[Tool]` plugins (get/list/search catalog, datastore query/schema/stats, harvest status, and write tools like patch/publish/delete/import/drop/harvest) plus prompts and resources. Read tools and resources are gated by `mcp_server`'s own `access mcp server` permission (DKAN catalog data is public open-data by design), while every mutating tool declares its own fine-grained permission (`edit/publish/delete datasets via mcp`, `manage metastore items via mcp`, `import/drop datastore via mcp`, `manage harvests via mcp`, all `restrict access: true`). A `ToolAccessSubscriber` enforces these on both `tools/call` (deny) and `tools/list` (hide), so an unauthorized client neither sees nor can invoke a write tool. OAuth clients can authenticate via `simple_oauth` scopes (`dkan_mcp_read` / `dkan_mcp_write`, shipped as optional config).

Harvest registration passes source URIs through a `HarvestUriValidator` (SSRF guard) before use. The only module-owned route is the admin settings form (`/admin/config/services/dkan-mcp-server`, `administer dkan mcp server`) that toggles which tool groups are enabled; the MCP endpoint itself is owned by `mcp_server`. Set up by installing `mcp_server` + DKAN, enabling the desired tool groups, granting the per-tool permissions to a role, and (for remote clients) configuring OAuth.
---
- Expose DKAN datasets and datastore to an MCP-capable AI client
- Let an LLM search and list datasets in the DKAN catalog
- Let an LLM query datastore tables (filters, joins, distinct values, samples)
- Retrieve dataset, distribution and data-dictionary metadata via MCP
- Inspect datastore schema, stats and import status via MCP
- Publish or unpublish (archive) datasets through MCP (permission-gated)
- Create or patch dataset metadata through MCP (permission-gated)
- Create/patch arbitrary metastore items through MCP (permission-gated)
- Delete datasets, cascade-deleting distributions and datastore tables
- Trigger datastore imports for resources through MCP
- Drop datastore tables for resources through MCP
- Register, run and deregister harvest plans through MCP
- Gate every write tool behind a dedicated Drupal permission
- Hide write tools from tools/list for unauthorized clients
- Authenticate remote MCP clients with simple_oauth read/write scopes
- Enable or disable whole tool groups from the settings form
- Validate harvest source URIs to prevent SSRF
- Provide guided MCP prompts (find datasets, health check, diagnose harvest)
- Keep read tools open under the base access mcp server permission
- Run DKAN data-catalog operations from an agent workflow
