# MCP Sentinel — manual setup guide (2.3.x)

**MCP Sentinel** (`mcp_sentinel`) is a **governance layer** for Drupal sites that
expose content to AI agents over the **Model Context Protocol (MCP)**, **JSON:API**,
and **GraphQL**. It decides what an agent may touch, hides what it must not see,
records everything it does, and protects content people are editing — so you don't
have to build that control yourself. It is a **security‑positive** control plane: it
sits on top of MCP Server and the Tool API and adds only the governance those
projects leave to the site builder, without reimplementing the protocol, OAuth, or
the tool system.

> **This page documents the 2.3.x branch.** A newer **2.12.x** branch adds
> significant capabilities (per‑surface egress ceilings, finite read budgets, a
> fail‑closed source contract, sealed‑manifest human approval, and portable attested
> policy bundles) and ships several submodules. If you are on 2.12.x, read that
> version's guide instead. The differences are summarised at the bottom of this page.

**How governance triggers.** MCP Sentinel applies only to traffic on the **validated
OAuth agent channel** — a designated consumer, or an agent scope on the request's
token, checked server‑side and never from a header. Your public frontend and your own
cookie‑session admin work are untouched. Each agent's **role selects a policy
profile**, and every action is attributed to its account.

**What it does in 2.3.x:**

- **Policy profiles per role** — gates, redaction, limits, quotas, and IP rules live
  on a reusable config entity that a governed role selects.
- **Operation gates** — a master switch plus independent read, write, delete, and
  GraphQL‑mutation toggles.
- **Open‑redirect guard** — stops an agent pointing a redirect off‑domain (secure by
  default, with a per‑profile host allowlist).
- **Entity allow / deny lists** — restrict agents to specific entity types or block
  sensitive ones (users are blocked by default), enforced through Drupal's own access
  system so JSON:API and GraphQL honour it automatically.
- **Field redaction** — hide fields like `mail` or `pass` from agent requests;
  stripped from JSON:API/REST, returned as `[REDACTED]` in GraphQL, and cached
  separately so nothing leaks across the boundary.
- **PII redaction (opt‑in)** — scan field values for emails, phone numbers, SSNs, and
  card numbers and mask the matches.
- **Audit log** — every operation and GraphQL query recorded with user, IP, time, and
  payload metadata; filterable, exportable to CSV or JSON, with retention pruning.
- **Escape‑hatch permission assertions** — a profile declares permissions its governed
  roles must *not* hold (e.g. *bypass node access*, *administer users*), surfaced on
  the status report and via `drush mcp-sentinel:role-audit`.
- **Governed raw SQL (opt‑in, off by default)** — `drush mcp-sentinel:sql-query` runs
  SQL inside Drupal behind a fail‑closed check so deny lists, redaction, and the audit
  chain still apply; gated on a per‑profile `allow_raw_sql` flag that ships `FALSE`.
- **Tamper‑evident trail** — every audit entry is hash‑chained (HMAC‑SHA256 when keyed
  via a Key entity) by the **Audit Chain** module, so tampering is detectable;
  `drush audit-chain:verify` checks it.

**What it does not cover.** A policy profile governs requests that reach Drupal through
the MCP server's entity‑API path. It cannot govern channels that bypass that API — raw
SQL run directly, most Drush commands, direct file access, or programmatic entity loads
in custom code. `drush sql:query` is the clearest case: it bootstraps below the level
where module command files are discovered, so no policy check can fire for it. The
boundary for those paths is who can reach the host — shell and database credentials sit
outside this module's threat model and must be controlled separately.

As with any security control, **its protection is only as good as its policy
configuration**: define restrictive profiles, verify the redaction/DLP rules cover the
fields you care about, keep the OAuth clients and keys secured, and monitor the audit
log.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls Audit
   Chain, Key, Simple OAuth, Consumers, Encrypt and the Tool/JSON:API dependencies)
   and enable the module.
2. [Configuration](configuration/index.md) — define policy profiles, set gates and
   redaction, secure the keys, and monitor the audit log.

## Where it lives in the admin menu

MCP Sentinel's settings and policy profiles are managed from its admin UI under
**Configuration → Web services**, and the audit log is reviewed there too. (On the
newer 2.12.x branch the settings form has the explicit route
`/admin/config/services/mcp-sentinel`.)

## What changed in 2.12.x

If you later move to 2.12.x, expect: **per‑surface egress ceilings** on classified
data; **finite read budgets** by default (result count, response bytes, request/page
rate); a **fail‑closed source contract** that denies governed paths when required
wiring is missing; a **content‑lock / stale‑revision** precondition boundary shared
across write channels; **human approval** of destructive operations (approval
submodule); **portable, attested policy bundles**; a **governance dashboard**; a
declared settings route and Drush commands; and submodules for GraphQL governance and
MCP Server registration. It also raises the PHP requirement to **8.3**.
