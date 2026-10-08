# Override Cache Control Headers — manual setup guide

**Override Cache Control Headers** (`override_cache_control_headers`) lets you set
the **`Cache-Control` HTTP header on a per‑URL basis**, overriding whatever Drupal
would normally compute. This is useful for bypassing or tuning reverse‑proxy and
CDN caches for specific pages — for example telling a shared cache not to store
`/sitemap.xml`, or giving `/blog` a one‑hour `max-age`.

You configure it with simple text rules: one URL per line, the path and the
desired header separated by a `|`. You can also set a rule that lasts only for a
**limited time** (a third `|`‑separated value in minutes), after which the original
headers are automatically restored — handy for a temporary change during an
incident or a campaign. There's a Drush command for the timed overrides too.

> **The `Cache-Control` header controls whether — and for how long — a browser,
> proxy or CDN may store a response.** Pick the directives for each rule to match
> how that page is meant to be cached: `public, max-age=…` to let shared caches
> keep a page, `no-store` or `no-cache, private` to keep a page out of shared
> caches. Drupal core still decides the cacheability of dynamic pages, so choose
> rules with the specific path in mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — write the per‑URL header rules,
   including timed overrides.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Override Cache Control
Headers** (`/admin/config/development/override-cache-control-headers`), behind the
restricted **Administer override cache control headers** permission.
