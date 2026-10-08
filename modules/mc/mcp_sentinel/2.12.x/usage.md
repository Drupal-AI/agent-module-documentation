<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP Sentinel provides enterprise governance for AI-agent access to Drupal.

---

MCP Sentinel **provides a governance layer for AI-agent access to Drupal** — enforcing policy profiles, per-surface
egress ceilings, field redaction, data-loss-prevention (DLP), finite read budgets, tamper-evident audit logging and
reliable webhooks for agents that reach the site over MCP (Model Context Protocol), JSON:API or GraphQL. It depends on
Audit Chain, Tool, JSON:API, Key, Simple OAuth, Consumers and Encrypt, and provides its own permissions. Agent traffic
is identified by a Consumer→OAuth principal resolving to a role-bound policy profile; ordinary human Drupal traffic is
never gated. Since 2.4 a **fail-closed source contract** denies every governed path when required wiring
(server/bridge/OAuth/audit/Tool registration) is missing, and since 2.7 read budgets (result count, response bytes,
request/page rate) are **finite by default** so mass reads hit a floor. Writes run one shared precondition boundary —
content locks and stale-revision checks apply to JSON:API, GraphQL and direct saves, not just Tool plugins — and
publish-class edits of moderated content are redirected into unpublished forward revisions rather than mutating the
live one. The optional **approval** submodule holds destructive operations for a human decision bound to an
HMAC-sealed action manifest; **portable policy bundles** (2.11) carry an attested SHA-256 digest whose floor is
consulted live (2.12) and can arm an emergency deny. As with any security control, its protection is only as good as
its **policy configuration**: define restrictive profiles, label data and set egress ceilings, verify the
redaction/DLP rules cover the fields you care about, keep the OAuth clients/keys secured, and monitor the audit log.

---

- Govern AI-agent access to Drupal over MCP / JSON:API / GraphQL.
- Enforce role-bound policy profiles (read/write/delete/config, deny-publish).
- Set per-surface egress ceilings on classified data (public < internal < restricted).
- Redact sensitive fields and DLP-mask emails, phones, SSNs, card numbers.
- Cap reads with finite budgets (result count, response bytes, request/page rate).
- Fail closed when the governed source contract is not wired (2.4+).
- Keep a tamper-evident, hash-chained audit log via Audit Chain.
- Verify the audit chain (`drush mcp-sentinel:audit-verify`, non-zero exit on tamper).
- Queue destructive operations for human approval bound to a sealed action manifest.
- Distribute portable, attested policy bundles with an emergency-deny kill switch.
- Deliver reliable, HMAC-signed, SSRF-guarded, non-redirecting webhooks with a replayable log.
- Hold and check content locks and stale-revision preconditions across every write channel.
- Redirect publish-class edits of moderated content into unpublished forward revisions.
- Govern raw SQL through `drush mcp-sentinel:sql-query` (opt-in, entity-table only).
- Detect anomalies: denied-access storms, off-hours activity, complete bulk reads.
- Run a secure-install verifier (`drush mcp-sentinel:verify`, posture + hostile-input probes).
- Provision and reconcile declared OAuth agent principals.
- Gate GraphQL mutations and redact GraphQL field results (graphql submodule).
- Register Tool plugins with mcp_server and wire OAuth scopes (server submodule).
- Audit break-glass elevation and force-revoke unsafe `mcp_admin` grants.
- View a governance dashboard with denial rollups and chain-integrity posture.
- Provide its own permissions and monitor them for escape-hatch grants.
- Configure the policies, OAuth clients, keys, and egress ceilings.
