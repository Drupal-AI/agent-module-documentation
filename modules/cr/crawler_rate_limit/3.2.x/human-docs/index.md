# Crawler Rate Limit — manual setup guide

**Crawler Rate Limit** (`crawler_rate_limit`) throttles requests from web
crawlers, bots and spiders — and, optionally, from regular visitors — before
Drupal does the expensive work of building a page. When a client sends more
requests than you allow within a time window, it gets a cheap **HTTP 429 (Too
many requests)** response with a `Retry-After` header instead of a full page,
which protects your server during a crawl spike or aggressive scraping.

It works through an **HTTP middleware** that runs very early in the request
lifecycle, so blocked or limited requests never reach routing. Bots are
identified from their User-Agent by the bundled `CrawlerDetect` library. You can
apply up to three independent limits: one for **bot traffic**, one for **regular
visitors** (keyed by IP + User-Agent), and one for a whole **ASN** (a network,
which needs an extra GeoIP database). You can also allowlist trusted IPs and
paths, and block abusive networks outright by ASN (a `403` response).

Two things make this module unusual to set up: **all configuration lives in
`settings.php`** — there is no admin UI, config form, permission or Drush command
— and it depends on a **counter backend** (APCu, Redis or Memcached) to keep
track of request counts. If the backend or settings are missing or invalid, the
limiter safely "fails open" (does nothing) rather than taking your site down, and
reports the problem on the Status report page.

This guide is written for a **human** editing configuration. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the PHP libraries and backend
   extensions it needs, and installing with Composer.
2. [Configuration](configuration/index.md) — every `settings.php` key: the
   master switch, the backend, the three limits, allow/block lists, and how to
   verify it.

## Where it lives

There is **no admin page**. Everything is configured in your site's
`settings.php` under the array `$settings['crawler_rate_limit.settings']`. The
only thing that appears in the admin UI is a health check on the **Status
report** (`/admin/reports/status`), which flags a misconfigured backend or
settings. Rate-limited requests show up as `429` responses in your web server's
access log — the module deliberately logs nothing to the database.
