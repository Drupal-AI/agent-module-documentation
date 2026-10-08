<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Governance model, services, hooks, tools & agent endpoints

## When governance triggers
`McpOauthContext` (`mcp_sentinel.oauth_context`) is the single seam to `simple_oauth`. `isAgentChannel()` returns TRUE
only when the request's **validated** access token has a consumer `client_id` in `agent_oauth_clients` OR a scope in
`agent_scopes`. Everything is read from the server-validated token — never from a header; the `X-MCP-Client` header is
recorded for audit only. A verified **sealed token** supplies the same channel facts (client_id, scopes) through a
request attribute set by its auth provider, so sealed-token traffic resolves to the agent channel exactly as OAuth does.
`McpPolicyResolver` (`mcp_sentinel.policy_resolver`) `isGoverned()`/`resolve()` maps the account's role to an
`mcp_policy_profile`; when no profile resolves, all Sentinel hooks return neutral so cookie-session and ungoverned
traffic is unaffected — Sentinel only ever *adds* gates, never grants access core would deny.

## Sealed-token channel (`src/Authentication/`, `src/Service/McpSealedTokenManager.php`)
`McpSealedTokenAuthProvider` (service tag `authentication_provider`, `provider_id: mcp_sealed_token`, **not global**)
applies only to a `Bearer mcs1.`-prefixed header and only runs on routes that list `mcp_sealed_token` in their `_auth`
(the `/drupal-mcp/*` endpoints, and MCP/JSON:API/GraphQL routes that opt in). It calls `McpSealedTokenManager::verify()`
and, on success, authenticates the bound consumer's active owner account and stashes the client_id/scopes/jti claims for
`McpOauthContext`. `verify()` re-derives the site-local HMAC (`hash_salt` + private key, never config), compares with
`hash_equals`, then re-checks the stored row: not revoked, not expired, matching token hash, a still-designated client,
and a published consumer whose owner still matches. The DB holds a SHA-256 hash only. Minting is admin-only and bound to
a designated `agent_oauth_clients` consumer; the raw secret is returned once and never stored (see `configure/admin.md`).

## Enforcement seams (`mcp_sentinel.module` + `src/Hook/`)
- `hook_entity_access` / `hook_entity_create_access` — read/update/delete and create gates via
  `McpAccessChecker::checkEntityAccess()` / `checkCreateAccess()` (profile gates + allow/deny lists + IP allowlist).
  Create is covered separately because `hook_entity_access` does not fire for CREATE (closes the JSON:API POST plane).
- `hook_entity_field_access` — `view` field redaction (`redacted_fields` → forbidden) and classification egress
  ceilings; cached by `user.roles` + `oauth2_scopes` so agent and cookie results never share a cache.
- `hook_jsonapi_entity_filter_access` — mirrors the read gate so denied types cannot be probed via filters.
- `hook_entity_type_alter` — attaches validation constraints to every content entity type: `McpDenyPublish`
  (publish/moderation gate), `McpWriteConflict` (owner-aware content lock + stale-default-version refusal),
  `McpScheduledPublish` (governed scheduled publish/unpublish gate), and `McpDenyExternalRedirect` on the `redirect`
  entity (open-redirect guard).
- `hook_entity_presave` / `insert` / `update` / `predelete` / `delete` — write-precondition boundary, composite-child
  and unmoderated-in-place redirects, a status=0 publish backstop for unvalidated (custom-code/Drush) saves, the
  scheduled-publish enforce-on-save backstop (`McpScheduledPublishGate::enforceOnSave()`), the evidence-required veto
  (`McpEvidenceGuard`), the audit rows, and the internal `mcp.entity.*` events.
- `hook_cron` — audit + webhook + lock + sealed-token pruning, stale-claim reclaim, webhook requeue, anomaly
  evaluation, and evidence reconciliation.
- `hook_simple_oauth_private_claims_alter` — fills `client_id`/`azp` on site-issued tokens from the consumer id.

## Key services (`mcp_sentinel.services.yml`)
`audit_logger` (fail-closed hash-chained logging via `@?audit_chain.logger`; `logSurvivingRollback()` keeps the refused
caller's identity for a deferred/rolled-back write), `access_checker`, `policy_resolver`, `classification` (labels +
per-surface ceilings), `read_budgets` + `rate_limiter` + `exfiltration_guard` (finite budgets, request/result/byte
caps), `dlp` (PII masking, tighten-only), `content_lock`, `moderation_gate` + `scheduled_publish_gate`, `evidence_guard`,
`action_manifest_sealer` (HMAC-sealed action manifests), `governance_readiness` (source-contract evaluator),
`config_secret_redactor` + `config_write_validator`, `raw_sql_guard` + `governed_sql`, `webhook_queue_manager` +
`event_dispatcher`, `anomaly_detector` + `anomaly_alert_dispatcher`, `metrics` + `chart_renderer` + `urgent_conditions`,
`role_assertions` (escape-hatch permission audit), `admin_status`, `deny_explainer`, `whoami_recorder`,
`sealed_token_manager` + `sealed_token_auth`, `oauth_context`. Optional refs (audit_chain, key, policy bundle registry,
content_moderation, jsonapi repo, charts) are wired with `@?` so the container still compiles mid-upgrade.

## Governed Tool plugins (`tool` API, in `src/Plugin/tool/Tool/`)
All extend `McpGovernedToolBase`, whose `final checkAccess()`/`discoveryAccess()` apply the same non-bypassable gate:
`access mcp sentinel context` permission → readiness contract → IP allowlist → exact OAuth scope, then DLP scan of the
result. The required scope is **derived** from each plugin's own declaration by `McpToolScopeResolver`: a modifying
operation needs `mcp_write` (or `mcp_config` if the tool implements `ConfigScopeToolInterface`), a read operation
`mcp_read` (or `mcp_config_read`). Tools: `site_context`/`security_policy` (Explain→read), `content_lock`,
`node_operations`, `media_create`, `workflow_transition` (Trigger→write), `bulk_operations` (write),
`config_get`/`config_list` (config read; `config_get` masks secret-bearing values at any depth via
`config_secret_redactor`), `config_set` (config write; refuses secret-bearing config names outright),
`sql_query` (read), plus status tools `governance_status`, `effective_limits`, `audit_metrics`, `role_audit`,
`urgent_conditions`. `mcp_sentinel_server` registers these with an MCP server.

## Public-looking agent endpoints (`/drupal-mcp/*`, `McpContextController`)
- `context` — `GET /drupal-mcp/context` (`_auth: oauth2 | mcp_sealed_token`, perm `access mcp sentinel context`).
  Returns site name/langcode (Drupal version deliberately omitted), content-type field schemas, vocabularies, and
  media types. Before emitting anything it runs, in order: readiness contract (requires the `mcp_read` scope),
  IP allowlist, attested-bundle/emergency-deny floor, the finite request budget (429 on exceed), and classification
  egress ceiling (over-ceiling bundles are omitted, or the whole document refused). No-store, nosniff. Grant the
  permission to the MCP API user only.
- `readiness` — `GET /drupal-mcp/readiness` (`_auth: oauth2 | mcp_sealed_token`, perm `access mcp sentinel context`).
  Reports source-governance contract readiness. **Fail-closes uid 0 to 403 JSON even if the permission is granted to the
  anonymous role**, and `McpReadinessAccessDeniedSubscriber` rewrites an anonymous route AccessDenied to the same JSON
  so a 403→`/user/login` bounce cannot form. Explicitly claims `policy_effectiveness`/`evidence_chain_verified`/
  `overall_posture` = FALSE — it is a wiring signal, not a security guarantee.
- `health` — `GET /drupal-mcp/health` (`_access: TRUE`, public). Uptime probe returning only `{status, module}`
  (200 ok / 503 disabled). No site data; intentionally unauthenticated.

Denials from these paths and the Tool base are annotated by `McpDenyExplainer`: a stable rule name and a
`widen_appropriate` verdict, never a secret or a submitted value.

## Governed draft continuation (JSON:API)
`McpDraftRoutes` (route subscriber) clones each `node`/`media`/`paragraph` JSON:API individual PATCH/GET route to add
`/mcp-draft`, `/mcp-draft/translations`, `/mcp-translations`, and `/mcp-draft` GET, served by `McpDraftResource`
(`jsonapi.entity_resource.mcp_draft`). It continues an existing unpublished forward revision without touching the live
one, keeping the canonical JSON:API access + CSRF requirements; it cannot publish or change the public alias. A node
draft PATCH may carry `meta.mcp_components` to change the node's directly-referenced paragraphs in the same save (each
becomes a new revision only the draft points at); component changes are refused for nested/unrelated paragraphs,
reference fields, translation drafts, and when the request also changes the reference field itself.
