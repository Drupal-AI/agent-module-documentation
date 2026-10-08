Audit Chain MCP is the optional submodule of Audit Chain that exposes governed Tool API plugins — chain status, window counts, export status, and an on-demand verify — so an AI agent can inspect the tamper-evident audit chain through MCP Sentinel without ever reading its contents.

---

The submodule ships four `drupal/tool` plugins, all extending `AuditChainToolBase` (which subclasses MCP Sentinel's `McpGovernedToolBase`): `audit_chain_status` reports chain health from stored state (last scheduled verification, last verdict, whether new entries are signed, seal reach, recovery successor); `audit_chain_window_counts` returns keyed vs unkeyed entry counts for the 24h/7d/30d windows; `audit_chain_export_status` reports the off-system evidence-export backlog with the destination reduced to its kind and host; and `audit_chain_verify_now` runs the scheduled verification on demand (Trigger operation), returning a recent run instead of re-walking the table when the last run is under 60 seconds old. Access is enforced through governance: every call re-checks the module's permissions, resolves an MCP Sentinel policy profile, applies rate limiting and a response-size cap, and on any problem returns one fixed refusal message. Results are rebuilt field by field, so rows, metadata, IP addresses, user agents, hashes, seal MACs, prefix digests, key identifiers and seal reasons never reach a caller. It requires `audit_chain`, `mcp_sentinel` (>=2.22.0) and `tool` (>=1.0.0-beta8).

---

- Let a governed AI agent check whether the audit chain currently verifies, via `audit_chain_status`.
- Surface the last scheduled-verification verdict and when it ran to an agent without exposing row content.
- Tell an agent whether new entries are being HMAC-signed (the `signing.keyed` flag) without revealing the key id.
- Report how far a prefix seal reaches (`sealed_through_id`, `row_count`, `sealed_at`) as bounded integers.
- Give an agent the recovery successor status when a recovery segment exists.
- Count keyed vs unkeyed entries per 24h/7d/30d window with `audit_chain_window_counts`.
- Detect unsigned-write incidents from an agent by watching for unkeyed counts on a keyed site.
- Report the evidence-export backlog (enabled, configured, checkpoint, waiting) with `audit_chain_export_status`.
- Show only the export destination's kind (https/http/file) and host to an agent — never path, port, credentials or query string.
- Run chain verification on demand from an agent with `audit_chain_verify_now`, recorded exactly as a cron run.
- Avoid redundant expensive verifications: a verify-now within 60s of the last run returns that run with `ran: false`.
- Gate the verify tool behind a second permission (`run audit chain verification via mcp`) separate from the read tools.
- Rate-limit and size-cap all audit-chain tool responses through the resolved MCP Sentinel profile.
- Keep audit-chain internals (hashes, MACs, key ids, metadata) out of agent transcripts by design.
- Wire audit-chain integrity checks into an MCP-driven monitoring or incident-response workflow.
