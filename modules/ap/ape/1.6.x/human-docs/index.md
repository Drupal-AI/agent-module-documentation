# Advanced Page Expiration — manual setup guide

**Advanced Page Expiration** (`ape`) gives you finer control over the
`Cache-Control: max-age` header that external caches — Varnish, CDNs, reverse
proxies — use to decide how long to keep a page. Drupal core only lets you set one
global "page cache maximum age" for the whole site. APE lets you vary that
lifetime **by path** and **by HTTP response code** instead.

The idea is to keep core's global default and then layer overrides on top. You can
give a list of paths an **alternative** lifetime (for example, expire the homepage
every 5 minutes while the rest of the site is cached for an hour). You can set
separate lifetimes for **301** and **302** redirects and for **404** Not Found
responses — handy for letting a CDN cache permanent redirects for a long time while
caching error pages only briefly. A **403** Access Denied response is always forced
to `max-age=0` so it's never cached. And you can list paths to **exclude** from
page caching entirely (for example `/cart` or `/user/*`), which are then never
stored.

All of this is driven by Drupal configuration on a single admin form, so you can
tune your Varnish/CDN TTLs per URL without touching VCL, and export the policy to
deploy it across environments. Under the hood an event subscriber computes the
right max-age for each response and writes the header; a page-cache response policy
enforces the exclusions.

For advanced cases, custom code (or Rules) can force a specific max-age for a
request with `ape_cache_set()`, and `hook_ape_cache_alter()` lets you adjust the
final number for logic that configuration can't express. A bundled `ape_test`
submodule adds test-only endpoints and isn't meant for production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field.

## Where it lives in the admin menu

APE's settings are at **Configuration → Development → Performance → APE**
(`/admin/config/development/performance/ape`), gated by the **Administer APE**
permission. APE also hides the now-redundant "page cache maximum age" selector on
the core Performance form and points you to its own form instead.

## How to use it

Open the APE settings form, set your global default and per-scenario lifetimes,
list any alternative paths and excluded paths, and save. See
[Configuration](configuration/index.md) for what each field does.
