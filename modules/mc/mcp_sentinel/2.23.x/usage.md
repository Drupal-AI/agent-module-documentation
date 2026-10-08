MCP Sentinel is a security-positive governance layer that controls, redacts, rate-limits, and audits what AI agents may read, write, or delete on a Drupal site over MCP, JSON:API, and GraphQL.

---

MCP Sentinel sits in front of the Drupal request stack and governs only the validated OAuth agent channel — a request whose access token carries a designated consumer client_id or a configured agent scope, decided server-side and never from a client header. Cookie-session administrators and the public frontend are untouched. Each agent's role resolves to a reusable policy profile (the `mcp_policy_profile` config entity) that decides the read/write/delete/GraphQL-mutation gates, allowed and denied entity types, redacted fields, DLP masking, rate limits, exfiltration caps, IP allowlists, publish/moderation gates, an open-redirect guard, and per-surface classification egress ceilings. Enforcement rides on Drupal's own access system (`hook_entity_access`, `hook_entity_create_access`, `hook_entity_field_access`, JSON:API filter access) plus validation constraints, so JSON:API and GraphQL honour it automatically. Every governed change is written to the `audit_chain` tamper-evident, hash-chained log with an optional HMAC key and at-rest metadata encryption. Read budgets are finite by default, content locks prevent concurrent agent edits, reliable HMAC-signed webhooks with a two-layer SSRF guard notify external systems, and anomaly-detection rules raise log/email/webhook alerts. Governed product paths fail closed when the source-governance contract (server/bridge/OAuth/audit/Tool registration and a designated consumer) is incomplete. Three submodules extend it: `mcp_sentinel_approval` (human-in-the-loop approval for destructive operations and break-glass elevation), `mcp_sentinel_graphql` (GraphQL Compose governance), and `mcp_sentinel_server` (registers the Sentinel Tool plugins with mcp_server and wires OAuth scopes).

---

- Expose a Drupal site to an AI agent (Claude, an MCP client, a custom LLM tool) while keeping the agent inside a defined policy boundary.
- Restrict an agent to reading content only, with all write and delete operations denied by a policy profile.
- Block an agent from ever touching users, OAuth tokens, keys, consumers, encryption profiles, and the governance config itself (all denied by default).
- Redact sensitive fields such as `mail` and `pass` from every agent read across JSON:API, REST, and GraphQL.
- Mask PII (emails, phone numbers, SSNs, credit-card numbers) in agent responses and audit diffs with opt-in DLP patterns.
- Classify data (public / internal / restricted) and set per-surface egress ceilings so an agent never receives content above its clearance.
- Rate-limit an agent's requests and cap the number of result items or response bytes it can pull in a single call (exfiltration guard).
- Keep a tamper-evident, hash-chained audit log of every governed create, update, delete, and read, attributed to the agent's account and IP.
- Export the audit log to CSV or JSON for a SIEM or compliance review, with automatic retention pruning.
- Verify the audit chain on demand or on cron to detect an inserted, deleted, or edited row.
- Restrict an agent's requests to a CIDR IP allowlist per policy profile.
- Prevent an agent from publishing content — force every agent-authored change to stay a draft / unpublished forward revision.
- Cap the maximum moderation state an agent may set on a moderated workflow.
- Stop an agent from pointing a redirect entity at an off-domain host (open-redirect / phishing guard), with an optional per-profile host allowlist.
- Detect a governed role that quietly holds an escape-hatch permission (`bypass node access`, `administer users`, …) that would let it act outside the policy, and surface it on the status report and via `drush mcp-sentinel:role-audit`.
- Let an agent read with raw SQL where necessary, run through a fail-closed governed Drush command that still applies deny lists, redaction, and the audit chain (off by default).
- Require durable keyed evidence before an evidence-required destructive mutation may execute.
- Deliver signed, retrying webhooks to external systems on governed entity events, with SSRF protection and a replayable delivery log.
- Continue an existing unpublished node/media/paragraph draft revision over JSON:API without touching the live one (governed draft continuation).
- Queue destructive operations (bulk delete, config import, module disable, break-glass grant) for a human to approve or deny before they run (approval submodule).
- Grant a human operator a time-boxed, non-standing `mcp_admin` break-glass role for incident response with separation of duties (approval submodule).
- Bring GraphQL Compose responses under the same governance — mutation gating, field redaction, DLP, result caps, and audit (graphql submodule).
- Register the Sentinel governed tools with an MCP server and provision per-environment agent tiers (role + service account + OAuth consumer) via Drush (server submodule).
- Monitor governance posture from a read-only dashboard with status tiles, chain-integrity card, top-agents and denied-by-policy panels, charts, and quick actions.
