# Akamai — manual setup guide

**Akamai** (`akamai`) connects Drupal's cache invalidation to the Akamai CDN's
Content Control Utility (CCU / Fast Purge) API, so that pages and cache tags are
purged from Akamai's edge servers when your content changes. Without it, a page you
edit in Drupal can stay stale on the CDN until its cache lifetime expires; with it,
the edit triggers a purge and visitors see the update.

Under the hood it wraps the `akamai-open/edgegrid-client` PHP library to talk to
Akamai's CCUv3 (Fast Purge) REST API. Most sites drive it through the **Purge**
module: Akamai ships two Purge purger plugins — one that purges by URL and one that
purges by cache tag — plus diagnostic checks for credentials and queue length. If you
don't use Purge, editors can clear URLs manually from a form or from an "Akamai Cache
Clear" block on the page they're viewing.

It can also emit an `Edge-Cache-Tag` response header so Akamai indexes Drupal's cache
tags for surrogate-key (tag-based) purging, target either the **production** or
**staging** Akamai network, and choose between `delete` (evict from the edge) and
`invalidate` (mark stale, revalidate on next request) purge actions. A global
killswitch lets you disable all outgoing Akamai calls instantly.

> **Note (trademark):** Akamai is a registered trademark of Akamai Technologies, Inc.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and grant the permissions.
2. [Configuration](configuration/index.md) — the settings form, credential storage
   (`.edgerc` file vs Key module), network and action choices, and the
   `Edge-Cache-Tag` header.

## Where it lives in the admin menu

The configuration form is at **Configuration → Akamai → Configure**
(`/admin/config/akamai/config`), and the manual cache-clear form is at
**Configuration → Akamai → Cache clear** (`/admin/config/akamai/cache-clear`).

## How to use it

1. In your Akamai Control Center, create Fast Purge (CCU) API credentials.
2. Store those credentials securely (see the [Configuration](configuration/index.md)
   page — prefer the Key module, and keep secrets in environment variables, never in
   plain config).
3. Enter the settings and choose your network (production/staging) and purge action.
4. For automatic purging, enable the **Purge** module and turn on the Akamai purgers.
   For occasional manual purges, use the cache-clear form or the block.
