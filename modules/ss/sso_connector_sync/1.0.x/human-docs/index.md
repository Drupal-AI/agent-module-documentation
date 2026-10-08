# SSO Connector – Cross-site Sync — manual setup guide

**SSO Connector – Cross-site Sync** (`sso_connector_sync`) replicates content
entities and allow-listed configuration across the sites in an SSO Connector
network, using HMAC-signed webhooks. When something is saved on one site, it can
be pushed to its peers so a federation of sites stays in sync.

The model is push-based. Running on any site, it pushes saved content entities and
allow-listed Drupal configuration to peer sites, and receives signed inbound
payloads from them. There is no scheduled pull client and no automatic conflict
resolution — data replicates when a peer pushes it. You control the direction per
site: push only, receive only, or both.

Security is central to how it works. The inbound endpoint enforces an IP
allowlist, fail-closed HMAC verification, a replay window, and a nonce cache;
outbound calls are SSRF-guarded (HTTPS only, with private, loopback, and reserved
IPs blocked, and redirects not followed). User synchronisation is off by default
and, when enabled, protects a blocklist of sensitive fields (password, roles,
status, mail, and so on) and applies a privilege-escalation guard to inbound user
data. Configuration sync is also opt-in, restricted by a prefix allowlist, and
applied all-or-nothing in a transaction. Delivery is queue-based with bounded
per-target retries. The per-site HMAC keys live in State, never in exportable
configuration, and both user and configuration sync must be explicitly turned on.

This is a submodule of the SSO Connector suite. It provides its own permissions,
depends on **SSO Connector** (`sso_connector`), core **Serialization**, **REST**,
**System**, and **Help**, requires PHP 8.1 or newer, and runs on Drupal 11.2 (or
12).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside SSO Connector.

## How to set it up

For each site, decide its **direction** — push only, receive only, or both — and
register the peer sites it exchanges data with. The receiving side enforces an **IP
allowlist** and HMAC verification, so provision the shared **HMAC signing key** in
State and keep it consistent between paired sites. **User synchronisation** and
**configuration synchronisation** are both off by default: turn them on
deliberately, and when you enable config sync, set the **prefix allowlist** that
limits which configuration is allowed to replicate. Start conservatively (content
only) and confirm that saving an entity on one site propagates to its peer before
widening the scope.
