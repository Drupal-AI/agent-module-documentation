# Configuration

MCP Sentinel is only as strong as the policy you configure. This page covers the
2.15.x settings form, the policy‑profile config entity, the classification and egress
model, redaction/DLP, webhooks, key storage, the permissions, and the Drush commands
you run at deploy time.

## Open the settings form

Log in as a user with **`administer mcp sentinel`** (a *restrict access* permission)
and go to **Configuration → Web services → MCP Sentinel**
(`/admin/config/services/mcp-sentinel`). The **governance dashboard** is at **Reports
→ MCP Sentinel** (`/admin/reports/mcp-sentinel`).

## 1. Global settings (`mcp_sentinel.settings`)

The main settings form controls the site‑wide switches:

- **`enabled`** — master governance switch (default on).
- **`governed_roles`** — the roles whose traffic is governed (default `mcp_api`).
  Governance triggers only for a Consumer→OAuth principal whose role is listed here;
  human traffic is never gated.
- **Audit logging** — `audit_enabled`, `audit_log_reads`, and
  `audit_retention_days` (default 90). The hash key and encryption profile for the
  chain live on `audit_chain.settings` and are edited from this form under *Audit
  Logging*.
- **Read budgets** — `require_finite_read_budgets` is **true** by default; **do not
  disable it in production** (doing so restores `0 = unlimited` and raises a permanent
  status warning). `read_budget_defaults` ships at results 500, bytes 8 MiB, 600
  requests/60 s, 120 pages/60 s.
- **Webhooks** — `webhook_enabled`, `webhook_endpoints`, `webhook_secret_key` (a Key
  id used for HMAC signing), `allow_internal_webhook_urls` (default false — leave off
  to keep the SSRF guard strict), and `webhook_delivery_retention_days` (30).
- **Agents** — `agent_oauth_clients`, `agent_scopes` (`mcp_read`, `mcp_write`,
  `mcp_config`, `mcp_config_read`), and `agent_provision_tiers`.
- **Anomaly detection** — enable and tune denied‑access‑storm, off‑hours, and
  bulk‑read signals.

## 2. Classification & egress ceilings

This is the heart of the 2.12.x data‑protection model:

- **`classification_labels`** — an ordered scale, `public < internal < restricted`.
- **`classification_map`** — rows that label entity types, bundles, and fields. Out of
  the box `user`, `oauth2_token`, `key`, `consumer`, and `encryption_profile` are
  **restricted**.
- Each policy profile then sets **`egress_ceilings`** — the highest label it may
  receive **per surface** (`tool`, `context`, `jsonapi`, `graphql`, `drush`). Data
  above the ceiling doesn't leave on that surface.

## 3. Policy profiles (config entity `mcp_policy_profile`)

A governed role points at a profile. The shipped `default` profile is a starting
point. Per‑profile keys include:

- **`roles`** — which governed roles use this profile.
- **Operation gates** — `allow_write`, `allow_delete`, `allow_config_read`,
  `allow_config_write`, and `deny_publish` (with a per‑type
  `entity_rules.<type>.allow_publish` override).
- **`denied_entity_types`** and **`redacted_fields`** — block entity types and hide
  named fields.
- **`egress_ceilings`** — as above.
- **`allow_raw_sql`** — ships **`FALSE`**; gates `drush mcp-sentinel:sql-query`.
- **`evidence_required_actions`** — opt‑in list where `entity_write` / `entity_delete`
  require a keyed audit commit.
- **`forbidden_role_permissions`** / **`acknowledged_role_permissions`** — the
  escape‑hatch guard: a governed role holding a forbidden permission fails
  `drush mcp-sentinel:role-audit`.

## 4. Field & PII/DLP redaction

Set **`dlp_enabled`** and **`dlp_mask_mode`**, and tune **`dlp_patterns`** (ships
email, US phone, SSN, and credit‑card detectors). A DLP pattern may declare a
classification label, in which case a hit becomes a **tighten‑only** detector — it can
lower the egress ceiling but never raise it. Field redaction (`redacted_fields`, set
per profile) hides whole named fields and caches redacted values separately.

## 5. Secure the keys

Tamper‑evidence and agent auth both rely on secrets:

- Store the **audit HMAC signing key**, the **webhook secret** (`webhook_secret_key`),
  and OAuth secrets via the **Key** module, backed by an environment variable rather
  than plain, git‑committed config. With DDEV, store a value with
  `ddev dotenv set .ddev/.env --mcp-sentinel-key=<value>` (keep `.ddev/.env` out of
  version control), `ddev restart`, and create a Key with the env provider.
- Note the `mcp_sentinel.environment` used to scope acknowledged permissions comes
  from `$settings['mcp_sentinel.environment']` in `settings.php` — **never** from
  exported config, and it **fails closed when unset**.

## 6. Permissions

- **`administer mcp sentinel`** (*restrict access*) — configure MCP access, audit
  logs, and webhooks; gates the settings form and webhook admin.
- **`view mcp sentinel audit log`** — view the audit log, dashboard, and exports.
- **`access mcp sentinel context`** (*restrict access*) — access the
  OAuth‑authenticated `/drupal-mcp/context` and `/drupal-mcp/readiness` endpoints.
  **Grant this to the MCP API (agent) user only.**
- **`approve mcp sentinel operations`** (*restrict access*, approval submodule) —
  approve/deny queued destructive operations. Hold it with a *second* person: it is
  deliberately excluded from the break‑glass `mcp_admin` role (separation of duties),
  and a requester can never approve their own request.

The `/drupal-mcp/health` endpoint is intentionally public and returns only an
ok/disabled status plus the module name — no data. The OAuth‑authenticated
`/drupal-mcp/readiness` endpoint refuses anonymous callers with a 403 JSON body
(never a login bounce), and an invalid bearer on `/drupal-mcp/*` returns JSON rather
than the HTML 401 page.

## 6a. Governed draft continuation (2.15)

With JSON:API enabled, a governed agent can continue an existing **unpublished
forward revision** of a node with a PATCH to the node's URL plus `/mcp-draft`. The
request must carry `If-Match: "<live revision ID>:<working revision ID>"`; both must
still match the stored pointers (a mismatch is a 409, a malformed header a 400).
Sending `X-MCP-Draft-Preflight: 1` runs the access, field, validation, and revision
checks **without saving**. The endpoint cannot publish, change the public alias, edit
non‑revisionable fields, or continue translated nodes — those are refused, not
silently converted. It carries the canonical JSON:API entity‑access and CSRF
requirements plus the full write‑precondition boundary (content locks and
stale‑revision checks), and rolls the save back if the live revision moved underneath
it.

## 7. Deploy‑time and maintenance Drush commands

Inspection commands use their **exit code** for health (non‑zero = attention):

- `mcp-sentinel:status` — readiness contract, active policy, audit, and lock state.
- `mcp-sentinel:verify` — secure‑install evidence document; `--live` adds
  hostile‑input probes (still no writes).
- `mcp-sentinel:audit-verify` — walk the tamper‑evident hash chain; non‑zero exit and
  the first broken row id on tamper.
- `mcp-sentinel:role-audit` — **deploy gate**: non‑zero exit if any governed role holds
  a permission its profile forbids. Run it after `config:import`.
- `mcp-sentinel:sql-query` — the only governed raw‑SQL path (a single `SELECT` over
  entity tables, behind fail‑closed gates); every run, refused ones included, is
  written to the chain.
- `mcp-sentinel:audit-purge`, `:lock-clear`, `:webhook-prune`,
  `:webhook-replay <deliveryId>` — maintenance that mirrors cron work.

With the submodules:

- Approval: `mcp-sentinel:break-glass` — grant a time‑boxed, HMAC‑sealed, single‑use
  `mcp_admin` role (refused for uid 1, existing admin accounts, a missing signing key,
  or an over‑permissioned role).
- Server: `mcp-sentinel:setup` (production setup; requires OAuth by default),
  `:agent-provision`, `:agent-reconcile`, `:teardown`.

## Remember the boundary

A policy profile governs requests that reach Drupal through the MCP server's
entity‑API path. It **cannot** govern channels that bypass that API — raw
`drush sql:query`, most Drush commands, direct file access, or programmatic entity
loads in custom code. Control those by controlling who can reach the host.
