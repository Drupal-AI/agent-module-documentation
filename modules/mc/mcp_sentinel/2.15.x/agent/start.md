<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel — agent index

**Enterprise governance for AI-agent access to Drupal** (policy profiles, per-surface egress ceilings, field
redaction, DLP, finite read budgets, tamper-evident audit logging, sealed-manifest human approval, portable attested
policy bundles, governed node draft continuation, reliable webhooks) over MCP / JSON:API / GraphQL. Depends on
`audit_chain`, `key`, `simple_oauth`, `consumers`, `encrypt`, `tool`, `jsonapi`, `user`, `node`. Provides permissions
and Drush commands. Version **2.15.0**. Core `^10.6 || ^11.3`. PHP `>=8.3`.

**Security-positive** control plane — authenticates agents (Simple OAuth/Consumers), protects data (Key/Encrypt),
logs immutably (Audit Chain), redacts/DLP-filters fields. Traffic is governed only when a Consumer→OAuth principal
resolves to a role-bound profile; human cookie-session traffic is untouched. Since 2.4 governed paths **fail closed**
when the source contract (server/bridge/OAuth/audit/Tool wiring) is incomplete; since 2.7 read budgets are **finite by
default**; since 2.11–2.12 an **attested policy-bundle floor** is consulted on the live access path and can arm an
emergency deny. Protection still depends on **policy configuration** — define restrictive profiles, label data and
set egress ceilings, verify redaction coverage, secure keys, monitor the log.

- **Configure** (settings, policy profiles, classification, egress ceilings, DLP, webhooks, break-glass): `/admin/config/services/mcp-sentinel` (`mcp_sentinel.settings`); dashboard at `/admin/reports/mcp-sentinel`. See `configure/settings.md`.
- **Drush** (status, verify, audit-verify, role-audit, governed sql-query, webhook replay/prune, agent provisioning): see `drush/commands.md`.
- **Permissions** (`administer mcp sentinel`, `view mcp sentinel audit log`, `access mcp sentinel context`, `approve mcp sentinel operations`): see `permissions/permissions.md`.
- **Submodules**: `mcp_sentinel_approval` (human approval gate), `mcp_sentinel_graphql` (GraphQL governance), `mcp_sentinel_server` (mcp_server registration + OAuth scopes). See `configure/submodules.md`.

## Diff 2.12.x → 2.15.x

A multi-minor jump. Behaviour and wiring are otherwise unchanged from 2.12.x; the additions are surface-specific.

- **Governed node draft continuation (2.15.0, d.o #3621022).** JSON:API gains a PATCH endpoint at each mutable node
  resource's URL plus `/mcp-draft` (added by `McpDraftRoutes`, cloning `jsonapi.node--*.individual.patch` with its
  canonical access + CSRF requirements). It continues an existing **unpublished forward revision** without touching
  the live one. Requires `If-Match: "<live-rev>:<working-rev>"`; both must still match the stored pointers (409 on
  mismatch, 400 on malformed IDs). `X-MCP-Draft-Preflight: 1` runs access/field/validation/revision checks with no
  save and returns `meta.draft_preflight: true`. It **cannot** publish, change the public alias, change
  non-revisionable fields, or continue translated nodes — those are refused, not silently converted. Only a governed
  principal may use it; full entity access, field access, validation, and the shared write-precondition boundary
  (content locks / stale-revision) still apply, and the save rolls back if the live revision moved.
- **Site-issued access tokens carry `client_id` and `azp` (2.14.0, d.o #3619398).** `hook_simple_oauth_private_claims_alter`
  fills `client_id` and `azp` from the consumer identifier, so a resource server keying grants on `azp ?? client_id`
  can identify the client. `aud` stays the consumer id (registered claim set upstream). Not by itself
  site-as-issuer entitlement at an audience-validating resource server.
- **Invalid bearer on `/drupal-mcp/*` returns JSON 401, not the HTML 401 page (2.14.0, d.o #3619396).** A malformed or
  unknown bearer now yields the same refusal body (`MCP access is denied.`, reason `unauthenticated`) with
  `WWW-Authenticate` preserved, except the public health probe. No security change — the deny was already
  fail-closed.
- **Readiness anonymous deny is 403 JSON, not a login bounce (2.13.1 / 2.13.2, DEV-435).** `GET /drupal-mcp/readiness`
  fail-closes uid 0 in the controller with 403 JSON; an anonymous `AccessDenied` on the route is rewritten to that
  JSON so a 403→`/user/login` converter cannot bounce a connector's verify fetch. Granting `access mcp sentinel
  context` to anonymous cannot open the governed path. `/drupal-mcp/health` stays the public uptime probe.
- **Adversarial manifest sweep + postcondition receipt (2.13.0, d.o #3616538 slice 6).** Proving tests cover
  `manifest_expired`, `target_stale`, and `idempotency_replay`; the evidence receipt records postconditions (target
  id/uuid/revision, outcome) and refuses a sealed-vs-observed discrepancy (`postcondition_discrepancy`). Who is gated
  is unchanged.
- **Anomaly alert evidence + live bulk-read channels (2.13.0, d.o #3616612).** A fired rule writes a bounded
  `anomaly_alert` audit row (and the same fields travel on the webhook payload). Governed JSON:API GET/HEAD documents
  and GraphQL field resolutions emit one `entity_read` per distinct entity when *Log reads* is on, so `bulk_read` can
  see those channels. No credentials or payload values.
- **DLP path-behaviour tests (2.13.0, d.o #3617061).** Prove Tool success context masking/refusal in both directions;
  JSON:API and REST bodies remain named DLP residuals (no stable per-value rewrite hook).
