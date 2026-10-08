<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel GraphQL (mcp_sentinel_graphql) — agent index

Optional submodule of **MCP Sentinel**. Extends base governance to a GraphQL Compose endpoint for governed agent
requests: mutation gating, field-name redaction, classification egress ceilings, DLP value masking, exfiltration
result-count caps, and per-entity read audit. Depends on `mcp_sentinel`, `graphql`, `graphql_compose`. Version
**2.23.1**. Core `^10.6 || ^11.3`.

**No settings of its own** — it reuses the base module's policy profiles and DLP config. `configure` is null; no
permissions, no config schema, no Drush.

## What it provides
- **Service**: `mcp_sentinel_graphql.governance_subscriber` (`GraphqlGovernanceSubscriber`) — mutation gating and
  query audit; stamps the request operation type.
- **Hook**: `hook_graphql_compose_field_results_alter` (in `.module`) — three ordered passes: field-name redaction +
  ceiling, DLP masking, result-count cap; plus `entity_read` audit per distinct entity.
- **Tool plugin**: `mcp_sentinel_graphql_schema` (`ToolOperation::Explain` → scope `mcp_read`) — governed GraphQL
  schema discovery.

Entity allow/deny is handled upstream by the base module's `hook_entity_access`; this submodule adds the response-shaping
and mutation/audit layer.

## Solution docs
- **How GraphQL governance works** → `api/governance.md`.
