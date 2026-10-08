# Acquia Purge — manual setup guide

**Acquia Purge** (`acquia_purge`) provides turnkey, accurate cache invalidation
for sites hosted on **Acquia Cloud**. It plugs into the **Purge** module as a
*purger*, so that when content changes in Drupal, the stale copies are cleared from
Acquia's Varnish load balancers — and, optionally, from the Acquia Platform CDN.
The result is that editorial changes appear immediately on high‑traffic sites,
without resorting to full cache flushes.

It ships two purger plugins: **Acquia Cloud** (`acquia_purge`), which handles URL,
wildcard‑URL, cache‑tag, and "everything" invalidations, and **Acquia Platform
CDN** (`acquia_platform_cdn`) for URL, tag, and "everything". On every cacheable
response it adds an `X-Acquia-Purge-Tags` header so Varnish knows which cache tags
a page carries; when those tags are invalidated it fires concurrent `BAN`/`PURGE`
requests directly to the load‑balancer IPs. Because balancers on Acquia Cloud host
many sites, an "everything" purge only clears the current site instance, never its
neighbors.

A defining feature is that Acquia Purge is **zero‑config by design**: it
auto‑detects the Acquia environment, so it deliberately has **no admin UI and no
settings forms**. You set it up entirely with Drush against the Purge module, and
you tune the few advanced options in `settings.php`. A small submodule,
`acquia_purge_geoip`, adds `X-Geo-Country` to the `Vary` header for
geo‑varied caching.

This guide is written for a **human** working through the setup. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   modules, register the purgers, and verify.

## Where it lives in the admin menu

There is **no configuration page** for Acquia Purge itself — this is intentional,
so that behavior only changes through traceable `settings.php` and Drush commands.
The related **Purge** module does provide a UI (via its `purge_ui` submodule) at
**Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`), where you can see the registered
purgers and processors.

## How to use it

Acquia Purge is set up on the command line, not through a form. After installing
and enabling it (see [Installation](installation/index.md)), the essentials are:

1. **Register the Acquia Cloud purger** with Purge:

   ```bash
   drush p:purger-add --if-not-exists acquia_purge
   ```

2. **Optionally add the Platform CDN purger** as well:

   ```bash
   drush p:purger-add --if-not-exists acquia_platform_cdn
   drush p:purger-ls          # list registered purgers
   drush p:purger-mvu <id>    # reorder execution
   ```

3. **Verify the setup** with Purge's diagnostics:

   ```bash
   drush p:diagnostics --fields=title,severity
   ```

   Acquia Purge contributes its own self‑test checks for Acquia Cloud, Platform
   CDN, and recommendations.

Once registered, cache‑tag invalidations are queued the moment content is saved
(via Purge's core‑tags queuer) and processed in the background by Purge's
late‑runtime or cron processors.

### Advanced tuning in `settings.php`

The module reads a few optional keys from Drupal settings — it stores no config of
its own:

- **`$settings['acquia_purge_token']`** — overrides the `X-Acquia-Purge` header
  value used to authenticate purge requests (defaults to the Acquia site name).
  Helps offset DDOS‑style attacks, but needs matching balancer config from Acquia
  Support.
- **`$settings['reverse_proxies']`** — the array of public load‑balancer IPs that
  Acquia Purge sends its BAN/PURGE requests to. (Note: distinct from
  `reverse_proxy_addresses`.)
- **`$settings['acquia_service_credentials']['platform_cdn']`** — vendor and
  configuration for the Platform CDN purger.

Environment facts (site name, group, environment, and the unique site identifier)
are auto‑detected on Acquia Cloud, so you normally do not set them yourself.
