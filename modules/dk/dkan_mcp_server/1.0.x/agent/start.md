<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN MCP Server (dkan_mcp_server) — agent index

**Exposes DKAN catalog/datastore/harvest/write operations as MCP tools on the `mcp_server` base, with per-tool Drupal-permission access control.**

- **Version:** 1.0.x
- **Core:** ^10.4 || ^11
- **Package:** DKAN
- **Dependencies:** mcp_server, dkan_metastore, dkan_datastore, dkan_harvest, dkan_query_tools (bundled submodule)
- **Own route:** `/admin/config/services/dkan-mcp-server` (`administer dkan mcp server`) — tool-group enable/disable. The MCP transport endpoint is owned by `mcp_server`.
- **Permissions:** reads use `mcp_server`'s `access mcp server`; writes use fine-grained `edit/publish/delete datasets via mcp`, `manage metastore items via mcp`, `import/drop datastore via mcp`, `manage harvests via mcp` (all restrict access: true).
- **Access enforcement:** `ToolAccessSubscriber` denies on `tools/call` and hides on `tools/list`; each `#[Tool]` also implements `checkAccess()` (`AccessResult::allowedIfHasPermission`). OAuth via `simple_oauth` scopes `dkan_mcp_read`/`dkan_mcp_write` (optional config).
- **Security:** No `_access: TRUE` mutation endpoint here. Write tools are individually permission-gated and hidden from discovery when unauthorized; harvest URIs pass a `HarvestUriValidator` SSRF guard. Read tools/resources are intentionally open under `access mcp server` (public open-data catalog) — status/read tier is reachable anonymously **only if the site grants `access mcp server` to anonymous**; operators controlling write must not also grant write scopes/perms to anon. Reviewed sound.

See [api/tools.md](api/tools.md) and [configure/access.md](configure/access.md).
