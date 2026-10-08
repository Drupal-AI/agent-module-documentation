<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN MCP Server — access & enforcement

## Two layers
1. **`ToolAccessSubscriber`** (`src/EventSubscriber/`): on `tools/call` denies when the user lacks the tool's permission; on `tools/list` hides tools the user cannot use. Also honours enabled tool groups.
2. **Per-tool `checkAccess()`**: e.g. `RunHarvestTool` → `allowedIfHasPermission($account, 'manage harvests via mcp')`; `DropDatastoreTool` → `'drop datastore via mcp'`; resource providers → open under `access mcp server`.

## OAuth
Optional config ships `simple_oauth.oauth2_scope.dkan_mcp_read` / `dkan_mcp_write` and role `dkan_mcp_write`. Install `simple_oauth:^6` + `simple_oauth_21` (in Composer suggest) for the OAuth path. `UnauthorizedChallengeSubscriber` adds the Bearer/resource_metadata challenge on anonymous 401/403s.

## SSRF guard
`HarvestUriValidator` (`src/Security/`) validates harvest source URIs before registration/run.

## Settings form
`/admin/config/services/dkan-mcp-server` (`administer dkan mcp server`) enables/disables tool groups only — it is not a per-tool grant.

## Operator guidance
Reads are open under `access mcp server` (public catalog data). Do **not** grant `access mcp server` — or any `* via mcp` write permission / write OAuth scope — to the anonymous role unless intentional.
