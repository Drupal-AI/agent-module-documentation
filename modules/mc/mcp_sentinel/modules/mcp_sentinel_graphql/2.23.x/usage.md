MCP Sentinel GraphQL extends MCP Sentinel's governance — mutation gating, field redaction, DLP masking, result caps, and audit — to a GraphQL Compose endpoint for governed AI-agent requests.

---

This optional submodule requires `mcp_sentinel`, `graphql`, and `graphql_compose`. It has no settings of its own; enabling it is all that is required to bring GraphQL responses under governance, reusing the base module's policy profiles and DLP settings. For a request on the governed OAuth agent channel it resolves the account's policy profile and applies, in `hook_graphql_compose_field_results_alter`: (1) field-name redaction — fields in the profile's `redacted_fields` are replaced with `[REDACTED]`, always keeping a non-empty value so GraphQL Compose's non-null guard is satisfied; then classification egress ceiling — an over-ceiling field takes the same placeholder; (2) classification-aware DLP value-pattern masking via `McpDlp` (a labelled hit can tighten but never raise the response ceiling); (3) an exfiltration result-count cap truncating multi-value lists to `result_count_cap`. Mutation gating and query audit live in `GraphqlGovernanceSubscriber`, and each distinct entity read emits one `entity_read` audit row (feeding the base module's bulk-read anomaly signal) when read logging is on. Entity allow/deny is already enforced by the base module's `hook_entity_access`, and responses carry `user.roles` + `oauth2_scopes` cache contexts so a redacted agent value is never served to a cookie-session request. Its `mcp_sentinel_graphql_schema` Tool exposes governed GraphQL schema discovery.

---

- Expose a Drupal site's GraphQL Compose API to an AI agent while keeping it inside the same policy boundary as MCP/JSON:API.
- Redact sensitive fields (e.g. `mail`, `pass`) from GraphQL responses for governed agents, returning `[REDACTED]`.
- Enforce per-surface classification egress ceilings on GraphQL field results.
- Mask PII (emails, phones, SSNs, cards) in GraphQL string values with the base module's DLP patterns.
- Cap the number of items an agent can pull from a multi-value GraphQL field (exfiltration result-count cap).
- Gate GraphQL mutations for governed agents through the resolved policy profile.
- Audit governed GraphQL queries and per-entity reads in the tamper-evident chain.
- Feed the bulk-read anomaly-detection signal from the GraphQL read channel.
- Keep governed and non-governed GraphQL responses in separate caches via role/scope cache contexts.
- Offer governed GraphQL schema discovery to an agent through the `mcp_sentinel_graphql_schema` Tool.
- Bring an existing GraphQL Compose deployment under governance with no additional configuration beyond enabling the submodule.
- Ensure entity-type allow/deny already configured in a policy profile also applies to GraphQL automatically.
