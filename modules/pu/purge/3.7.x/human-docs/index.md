# Purge — manual setup guide

**Purge** (`purge`) is a generic, pluggable framework for invalidating **external**
caches — reverse proxies and CDNs such as Varnish, Fastly, CloudFront, Akamai, or
Cloudflare — when your Drupal content changes. It lets those external caching layers
keep unchanged content cached for a long time while precisely clearing only what
actually changed, making content delivery faster, more resilient, and better
protected against traffic spikes.

It's important to understand that **Purge ships no cache backend integration
itself** — it's the coordination framework that cache-invalidation modules build
on. The pipeline works like this: when Drupal invalidates cache tags internally,
**queuers** capture those invalidations and add them to a **queue**; **processors**
later drain the queue and hand invalidations to configured **purgers**, which are
the plugins that actually talk to your Varnish, CDN, or other external cache. A
**capacity tracker** rate-limits the work so the origin is never overwhelmed, and
**diagnostic checks** surface misconfiguration on the status report.

Because Purge is a middleware layer, you must also **install a purger module for
your specific proxy or CDN** (for example `varnish_purge`, `fastlypurger`,
`cloudflare`, `acquia_purge`, or the generic `purge_purger_http` for any
HTTP-based cache). Purge has no runtime dependencies of its own, but its optional
submodules provide the pieces most sites need: the admin UI, cron and late-runtime
processors, a core cache-tags queuer, token support, and Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and the submodules a typical setup needs, and add a purger.

There is **no single settings page** in the base module — the admin dashboard is
provided by the optional **Purge UI** submodule, described in "How to use it" below.

## Where it lives in the admin menu

With the **Purge UI** submodule enabled, the dashboard is at **Configuration →
Development → Performance → Purge**
(`/admin/config/development/performance/purge`). The base module defines no
permissions of its own — the UI uses the *Administer site configuration*
permission.

## How to use it

A common starting configuration is:

1. Enable the base module plus the UI, Drush commands, a queuer, and a processor:
   ```bash
   drush en purge purge_ui purge_drush purge_queuer_coretags purge_processor_cron -y
   ```
2. Open **Configuration → Development → Performance → Purge**.
3. **Install a purger** — add a third-party module that provides a purger for your
   cache layer (e.g. Varnish or a CDN). If nothing supports your cache and it can
   be invalidated over HTTP, use the generic `purge_purger_http` module.
4. Configure the purger (endpoints, credentials, which invalidation types it
   handles), and if you have several purgers, order them.
5. Watch the **status report** and the Purge dashboard for diagnostic warnings
   (e.g. "no purger installed" or "capacity too low") and resolve them.

Invalidations come in typed flavours — cache **tag**, **path**, **URL**, wildcard
path/URL, regular expression, **domain**, and **everything** — and you can trigger
them from the CLI with the `drush p:*` commands (for example `drush p:invalidate`
and `drush p:queue-work`).
