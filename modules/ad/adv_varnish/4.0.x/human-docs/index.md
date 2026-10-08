# Advanced Varnish cache — manual setup guide

**Advanced Varnish cache** (`adv_varnish`) connects Drupal to a **Varnish**
reverse-proxy cache. It does the three things a Drupal-aware Varnish integration needs:
it sends the cache-control and cache-tag headers Varnish relies on, it invalidates
cached content precisely by cache tag (using Varnish **BAN** requests) when content
changes, and it supports **ESI** (Edge Side Includes) so per-user fragments of a page
stay dynamic while the rest of the page is served from cache.

Almost everything is driven by one settings screen, organised into three areas: the
Varnish server connection (host, shared secret, page TTL, grace period, a per-site
"noise" key, debug/logging, and the built-in purger toggles), what caching applies to
(the master on/off switch, whether to cache authenticated users, ESI support and its
user-block purging, and URL include/exclude rules), and the actual `Cache-Control`
header strings sent to anonymous versus logged-in visitors. A cache-manager service
translates Drupal's cache-tag invalidations into Varnish BAN requests and also offers
full-flush, purge-by-URL and progressive "deflate" operations. When the built-in purger
is enabled, extra admin forms let you clear or deflate the cache by hand.

For advanced personalisation, the module defines a **user blocks** plugin type: you can
write a plugin that supplies per-user content (a greeting, a cart count) delivered
through ESI, so the surrounding page can still be cached anonymously. Two permissions
govern the module — one for configuring it, and one that lets chosen roles bypass
Varnish entirely (handy for editors and admins). Running this module also requires an
actual Varnish server in front of your site, configured with compatible VCL.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form section by section,
   the manual purge/deflate forms, and permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Advanced Varnish**
(`/admin/config/development/adv_varnish`). When the built-in purger is enabled, the
**Clear Varnish cache** and **Deflate Varnish cache** forms appear as tabs there.
