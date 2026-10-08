# Dropsolid Purge — manual setup guide

**Dropsolid Purge** (`dropsolid_purge`) clears cached pages out of one or more
**Varnish** load balancers whenever your Drupal content changes. It is a generic
rework of the well‑known Acquia Purge module, so you can use tag‑based Varnish
cache invalidation on *any* hosting, not just Acquia.

The module plugs into the contrib **Purge** framework and adds a **purger**
plugin. When Drupal serves a page it stamps two response headers on it —
`X-Dropsolid-Purge-Tags` (the page's hashed cache tags) and `X-Dropsolid-Site`
(a unique identifier for this site). When content changes, the purger sends BAN
requests to each Varnish load balancer you've listed, and Varnish (using the
bundled example VCL) bans only the objects belonging to *this* site. That
per‑site scoping is the key feature: several sites or subsites sitting behind a
shared Varnish never flush each other's caches.

Unlike most modules there is **no settings form**. Everything is configured in
your site's `settings.php` — the load‑balancer addresses, the site's
name/environment/group, and an optional auth token — which makes it clean to
deploy across environments. You then add and enable the purger through the Purge
module itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   Purge framework with Composer, then enable them.
2. [Configuration](configuration/index.md) — the `settings.php` config, the auth
   token, and enabling the purger inside Purge.

## Where it lives in the admin menu

Dropsolid Purge has no admin page of its own. You manage it through the **Purge**
framework at **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`), where you add the *Dropsolid
Varnish Purge* purger and pair it with a processor.

## How to use it

1. Install and enable the module and Purge (see
   [Installation](installation/index.md)).
2. Add the `dropsolid_purge.config` array and (optionally) the token to
   `settings.php` (see [Configuration](configuration/index.md)).
3. Add the purger through Purge — via the UI or
   `drush p:purger-add dropsolid_purge` — and add a Purge processor (the cron and
   lateruntime processors are recommended).
4. Deploy the example VCL to your Varnish servers so they understand the BAN
   requests. From then on, cache invalidation happens automatically through the
   Purge queue as content changes.
