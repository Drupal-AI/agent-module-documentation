<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL governance internals

## Enable
`drush en mcp_sentinel_graphql`. Requires `mcp_sentinel`, `graphql`, `graphql_compose`. No configuration — it reads the
same `mcp_policy_profile` entities and `mcp_sentinel.settings` DLP config as the base module.

## Response shaping — `mcp_sentinel_graphql_graphql_compose_field_results_alter()`
Runs on every GraphQL Compose field resolution. It resolves the active profile via `mcp_sentinel.policy_resolver`;
if the request is not governed (no profile) it only adds cache contexts and returns. For a governed request, in order:

1. **Field-name redaction + classification ceiling.** If the field name is in `redacted_fields`, or
   `_mcp_sentinel_graphql_field_over_ceiling()` finds the field's classification label exceeds the profile's GraphQL
   egress ceiling, every delta becomes `[REDACTED]` (a non-empty placeholder is kept so a required single-value field
   does not trip the non-null guard). Labels only ever deny *more*.
2. **DLP value masking.** String deltas that survive pass 1 go through `McpDlp` — `scan()` when no classification
   resolver, else `applyForEgress()` which can tighten the ceiling on a labelled hit and fully redact an over-ceiling
   value (never raise a ceiling). A denial writes classification `evidence()`.
3. **Exfiltration result-count cap.** `McpExfiltrationGuard::capResults()` truncates multi-value lists to
   `result_count_cap` (when > 0), after redaction/DLP so those passes see the full set.

`user.roles` + `oauth2_scopes` (and classification) cache contexts are added so a redacted/masked agent-channel value
is never served to a cookie-session request for the same user.

## Read audit
For a non-mutation operation on an entity, the hook calls `McpAuditLogger::logEntityRead()` with surface
`graphql` (deduped per distinct entity), feeding the base module's `bulk_read` anomaly signal when *Log reads* is on.
The operation type (query vs mutation) is read from a request attribute set by `GraphqlGovernanceSubscriber`.

## Mutation gating & audit — `GraphqlGovernanceSubscriber` (`mcp_sentinel_graphql.governance_subscriber`)
An event subscriber wired with `@mcp_sentinel.audit_logger`, `@mcp_sentinel.governance_readiness`, the access checker,
the GraphQL results cache, and the request stack. It gates GraphQL mutations against the resolved profile's
`allow_graphql_mutations` gate and records query audit. Entity-type allow/deny is *not* re-implemented here — it is
enforced by the base module's `hook_entity_access`, which GraphQL honours automatically.

## Tool
`McpGraphqlSchemaTool` (`mcp_sentinel_graphql_schema`, `ToolOperation::Explain` → derived scope `mcp_read`) exposes
governed GraphQL schema discovery through the base `McpGovernedToolBase` gate (permission + readiness + IP + scope).
