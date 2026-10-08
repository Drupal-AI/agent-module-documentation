# Sucuri Cache — manual setup guide

**Sucuri Cache** (`sucuri_cache`, also known as Sucuri Cache Clear) connects Drupal
to the **Sucuri Website Firewall** so you can purge Sucuri's cached content
directly from your site. When you publish or update content, you no longer have to
leave Drupal, make manual API calls, or wait for a time-based purge — you clear the
cache from the admin interface and the content refreshes on Sucuri's caching layer.

Sucuri sits in front of your site as a cloud CDN and WAF, caching pages to serve
them quickly. The catch is that after a content change, the cached copy on Sucuri
can be stale until it expires. Sucuri Cache closes that gap: it can automatically
purge a node's cache when the node changes, clear an individual node's cache with a
simple action, clear several nodes at once, or purge the entire site cache from an
admin button — for example after a big deployment. Every purge action is logged for
traceability, and who may purge is governed by Drupal permissions, so you can let
content managers clear caches without handing them full API access.

The module needs a little configuration before it can talk to Sucuri: you enter
your Sucuri API endpoint, API key, and API secret. It has **no module
dependencies**. It is focused specifically on Sucuri WAF integration — it is not a
general Drupal caching layer and does not replace modules like Purge, Cloudflare
Purge, or Acquia Purge.

**A note on credentials.** The API key and secret are sensitive. Follow the
project's guidance to store them securely — an environment-backed approach keeps the
secret out of exported configuration and out of version control.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Sucuri API credentials and
   start purging.

## Where it lives in the admin menu

After enabling, configure the module at **Configuration → Web services → Sucuri
Cache** (`/admin/config/services/sucuri_cache`). From there — and from the node-level
actions — you can clear individual, multiple, or the entire site's Sucuri cache.
