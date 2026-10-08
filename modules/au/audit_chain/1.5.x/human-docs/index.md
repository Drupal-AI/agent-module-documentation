# Audit Chain — manual setup guide

**Audit Chain** (`audit_chain`) provides **tamper‑evident, hash‑chained audit logging**
that any Drupal module can write to. Each entry's hash covers both its own content and
the previous entry's hash, so any later insertion, deletion, or edit breaks the chain and
becomes detectable by an independent verification pass. With an HMAC signing key
configured, forging a convincing repair also requires the key — so a database‑level edit
cannot be quietly papered over.

The distinction that matters is not "the application says it logged that", but a record
that can be *shown* not to have been altered since it was written. On top of the chain it
adds optional **at‑rest encryption** of entry metadata (via the Encrypt module), a
**prefix seal** for freezing historical segments that predate your keys, **scheduled
keyed verification** on cron, and **data‑minimized off‑system evidence export** (chain
rows delivered as NDJSON to an HTTPS endpoint or a file, carrying only identifiers and
hash‑chain columns — never metadata, IPs, user agents, or labels).

Audit Chain is a **primitive for developers**, not a turn‑key logger: it does its work
when other code writes to it (Drupal's own MCP Sentinel grew this trail for AI‑agent
traffic). It depends on core **User**, the **Key** module (for the HMAC signing key), and
the **Encrypt** module (for at‑rest encryption). It is enabled, then configured — you set
the signing key and, optionally, the encryption profile, scheduled verification, and
export.

Its guarantees rest on **protecting the keys**: a leaked signing key lets an attacker
forge a consistent chain, so store the HMAC and encryption keys with a File or
Environment key provider (outside the database), verify the chain periodically, and keep
off‑system copies of the evidence and backups of any seal points. Note too what it does
*not* do — it does not make deletion impossible (it makes it *evident*), it does not order
events across servers, and it is not a replacement for `dblog`/`syslog` (those are
operational logs; this is an evidentiary one).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   and its Key/Encrypt dependencies.
2. [Configuration](configuration/index.md) — the settings form field by field: signing
   key, retired keys, encryption profile, streaming, scheduled verification, and export.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Audit Chain**
(`/admin/config/system/audit-chain`, route `audit_chain.settings`), gated by the core
**Administer site configuration** permission. Audit Chain adds no permissions of its own.

## How to use it

Once configured, other code writes entries by injecting the logger service. For a single
event, `\Drupal::service('audit_chain.logger')->log($channel, $operation, $data)`; for
things that fire repeatedly during a request (like per‑field access checks) use the
request‑scoped **collector** (`audit_chain.collector`), which deduplicates and writes once
after the response is sent — keeping the chain lock off the request critical path. You
verify on demand with `drush audit-chain:verify`, whose **exit code is the contract**:
non‑zero means the chain does not verify. See the sibling agent docs for the full command
set (`verify`, `seal`, `reencrypt`, `export`).
