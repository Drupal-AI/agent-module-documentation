# MCP Sentinel — manual setup guide (2.15.x)

**MCP Sentinel** (`mcp_sentinel`) is a **governance layer** for Drupal sites that
expose content to AI agents over the **Model Context Protocol (MCP)**, **JSON:API**,
and **GraphQL**. It decides what an agent may touch, hides what it must not see,
records everything it does, and protects content people are editing. It is a
**security‑positive** control plane: it sits on top of MCP Server and the Tool API
and adds only the governance those projects leave to the site builder — it does not
reimplement the protocol, OAuth, or the tool system.

> **This page documents the 2.15.x branch**, which is substantially more capable than
> the earlier 2.3.x line. If you're on 2.3.x, read that version's guide instead —
> the 2.x additions are called out throughout this page.

**How governance triggers.** MCP Sentinel applies only to traffic on the **validated
OAuth agent channel** — a Consumer→OAuth principal that resolves to a **role‑bound
policy profile**, checked server‑side and never from a header. Ordinary human,
cookie‑session traffic is never gated, and every agent action is attributed to its
account.

## What it does

- **Policy profiles per role** — gates (read/write/delete/config, deny‑publish),
  redaction, limits, quotas, and IP rules live on a reusable config entity that a
  governed role selects.
- **Per‑surface egress ceilings** *(2.x)* — set the highest data‑classification label
  (public < internal < restricted) a profile may receive per surface (`tool`,
  `context`, `jsonapi`, `graphql`, `drush`). Classify entity types, bundles, and
  fields; a DLP hit can only *lower* the ceiling, never raise it.
- **Finite read budgets** *(default since 2.7)* — cap result count, response bytes,
  and request/page rate so mass reads hit a floor. These are **finite by default**;
  don't disable them in production.
- **Fail‑closed source contract** *(since 2.4)* — every governed path is **denied**
  when required wiring (server/bridge/OAuth/audit/Tool registration) is missing,
  rather than failing open.
- **Field & PII redaction** — hide named fields (e.g. `mail`, `pass`) and DLP‑mask
  emails, phones, SSNs, and card numbers; redacted values are cached separately so
  nothing leaks across the boundary.
- **Shared write‑precondition boundary** — content locks and stale‑revision checks
  apply across JSON:API, GraphQL, and direct saves (not just Tool plugins), and
  publish‑class edits of moderated content are redirected into **unpublished forward
  revisions** rather than mutating the live one.
- **Governed draft continuation** *(new in 2.15)* — a PATCH endpoint at each mutable
  node's URL plus `/mcp-draft` lets a governed agent continue an existing
  **unpublished forward revision** without disturbing the live one, under an
  `If-Match: "<live>:<working>"` precondition, with a no‑save preflight mode. It
  refuses to publish, change the public alias, edit non‑revisionable fields, or
  continue translated nodes.
- **Human approval of destructive operations** *(approval submodule)* — holds an
  operation for a person's decision, bound to an **HMAC‑sealed action manifest** that
  is re‑checked at approval time; the requester can't approve their own request.
- **Portable, attested policy bundles** *(2.11–2.12)* — carry a signed SHA‑256 digest
  whose floor is consulted live on the access path and can arm an **emergency deny**.
- **Tamper‑evident audit log** — every operation and GraphQL query is hash‑chained
  (via **Audit Chain**), filterable, exportable to CSV/JSON, with retention pruning;
  a **governance dashboard** shows denial rollups and chain‑integrity posture.
- **Governed raw SQL (opt‑in)** — `drush mcp-sentinel:sql-query` is the only SQL path
  that stays under governance; gated per profile by `allow_raw_sql` (ships `FALSE`).
- **Reliable webhooks** — HMAC‑signed, SSRF‑guarded, non‑redirecting delivery with a
  replayable log.
- **Anomaly detection** — denied‑access storms, off‑hours activity, and complete bulk
  reads, each writing a bounded evidence row.

## What it does not cover

A policy profile governs requests that reach Drupal through the MCP server's
entity‑API path. It **cannot** govern channels that bypass that API — raw
`drush sql:query`, most Drush commands, direct file access, or programmatic entity
loads in custom code. `drush sql:query` bootstraps below the level where module
command files are discovered, so no policy check can fire for it. The boundary for
those paths is who can reach the host: **shell and database credentials sit outside
this module's threat model** and must be controlled separately.

As with any security control, **its protection is only as good as its policy
configuration**: define restrictive profiles, label data and set egress ceilings,
verify redaction/DLP coverage, keep OAuth clients and keys secured, and monitor the
audit log.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls Audit
   Chain, Key, Simple OAuth, Consumers, Encrypt, Tool, and JSON:API), enable the
   module, and choose submodules.
2. [Configuration](configuration/index.md) — define policy profiles, classification
   and egress ceilings, read budgets, redaction/DLP, webhooks, and secure the keys;
   plus the Drush commands you run at deploy time.

## Where it lives in the admin menu

- **Settings:** **Configuration → Web services → MCP Sentinel**
  (`/admin/config/services/mcp-sentinel`, route `mcp_sentinel.settings`, permission
  `administer mcp sentinel`).
- **Governance dashboard:** **Reports → MCP Sentinel** (`/admin/reports/mcp-sentinel`).
- **Audit log:** `/admin/reports/mcp-sentinel/audit` (with `/export`).
- **Webhook delivery log:** `/admin/reports/mcp-sentinel/webhooks`.

## What changed since 2.12.x

2.15.x adds the **governed node draft‑continuation endpoint** (`PATCH …/mcp-draft`,
2.15.0) with `If-Match` live/working preconditions and a no‑save preflight. Along the
way, 2.14.0 stamps site‑issued access tokens with `client_id` / `azp` claims and makes
an invalid bearer on `/drupal-mcp/*` return JSON rather than the HTML 401 page; 2.13.x
hardens the readiness endpoint (anonymous deny is 403 JSON, never a login bounce),
adds the adversarial‑manifest postcondition receipt, and lets anomaly rules see live
JSON:API/GraphQL bulk‑read channels with bounded `anomaly_alert` evidence rows. The
2.12.x feature set — per‑surface egress ceilings, classification, finite read budgets,
the fail‑closed source contract, the shared write‑precondition boundary, human
approval with sealed manifests, portable attested policy bundles, the governance
dashboard, the Drush command set, and the three submodules — is unchanged.
