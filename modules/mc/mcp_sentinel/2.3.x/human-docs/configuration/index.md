# Configuration

MCP Sentinel is only as strong as the policy you configure. This page walks through
the pieces you set up in 2.3.x: which roles are governed, the policy profile that
decides what those agents may do, the redaction and DLP rules, and the audit trail.

Manage everything from MCP Sentinel's admin UI under **Configuration → Web
services**. (On the 2.12.x branch the settings form is at
`/admin/config/services/mcp-sentinel`; on 2.3.x it lives in the same area of the
admin menu.)

## 1. Decide which traffic is governed

Governance applies only to the **validated OAuth agent channel** — a designated
Consumer, or an agent scope on the request's token, checked server‑side and never
from a request header. Ordinary human, cookie‑session traffic is never gated. Set up
your agent's OAuth client (Simple OAuth / Consumers) and make sure its **role** is one
of the governed roles, because the role is what selects a policy profile.

## 2. Build a policy profile

A policy profile is a reusable config entity; a governed role points at one. In a
profile you control:

- **Operation gates** — a master switch plus independent **read**, **write**,
  **delete**, and **GraphQL‑mutation** toggles. Turn off anything the agent shouldn't
  do.
- **Entity allow / deny lists** — restrict agents to specific entity types, or block
  sensitive ones. **Users are blocked by default.** Enforcement runs through Drupal's
  own access system, so JSON:API and GraphQL honour it automatically.
- **Field redaction** — list fields (such as `mail` or `pass`) to hide from agent
  requests. They are stripped from JSON:API/REST responses, returned as `[REDACTED]`
  in GraphQL, and cached separately so a redacted value can't leak across the
  boundary.
- **Open‑redirect guard** — on by default; keep an off‑domain redirect from being
  driven by an agent, with a per‑profile **host allowlist** for the destinations you
  do trust.
- **Escape‑hatch permission assertions** — declare permissions the governed role must
  *not* hold (for example *bypass node access* or *administer users*), so the role
  can't quietly step around the policy it appears to be under. Violations show on the
  status report and fail `drush mcp-sentinel:role-audit`.
- **Governed raw SQL** — the per‑profile **`allow_raw_sql`** flag (ships **`FALSE`**)
  gates `drush mcp-sentinel:sql-query`, the only SQL path where deny lists, redaction,
  and the audit chain still apply. Leave it off unless an agent genuinely needs it.

## 3. Turn on PII / DLP redaction (optional)

Enable DLP scanning to mask emails, phone numbers, SSNs, and card numbers found in
field values. This complements field redaction: field redaction hides whole named
fields, while DLP catches sensitive patterns wherever they appear.

## 4. Secure the keys

The audit chain's tamper‑evidence relies on a signing key, and agent access relies on
OAuth clients — both are only as safe as their secrets:

- Store the HMAC signing key and any OAuth secrets via the **Key** module, backed by
  an environment variable rather than plain, git‑committed configuration. With DDEV,
  store a value with `ddev dotenv set .ddev/.env --mcp-sentinel-key=<value>` (keep
  `.ddev/.env` out of version control), `ddev restart`, and create a Key with the env
  provider.
- Keep the OAuth clients and consumers restricted to your agents.

## 5. Monitor the audit log

Every operation and GraphQL query is recorded with user, IP, time, and payload
metadata. Review it regularly, export to CSV or JSON when you need to, and set a
retention period so old rows are pruned automatically. Verify the trail hasn't been
tampered with using `drush audit-chain:verify`.

## Remember the boundary

A policy profile governs requests that reach Drupal through the MCP server's
entity‑API path. It **cannot** govern channels that bypass that API — raw
`drush sql:query`, most Drush commands, direct file access, or programmatic entity
loads in custom code. Control those by controlling who can reach the host.
