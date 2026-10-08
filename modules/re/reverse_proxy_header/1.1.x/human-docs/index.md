# Reverse Proxy Header — manual setup guide

**Reverse Proxy Header** (`reverse_proxy_header`) tells Drupal which custom HTTP
header carries the real visitor IP address when your site sits behind a CDN, load
balancer or proxy chain that forwards the origin IP in a non‑standard header.
When a request arrives, the module reads that header, picks out the real client
IP, and writes it back into `REMOTE_ADDR` very early in the request — before
routing, authentication and flood control run — so the rest of Drupal sees the
true visitor address instead of the proxy's.

It is the supported replacement for the `reverse_proxy_header` setting that Drupal
core deprecated in 8.7 and later removed. If your proxy forwards the client IP in
the standard `X-Forwarded-For` header, core already handles that and you do not
need this module. Reach for Reverse Proxy Header specifically when the real IP
arrives in a header you cannot rename to the core‑supported one — for example a
Fastly, Cloudflare or Akamai setup that uses a bespoke header name.

Getting the real client IP right matters for anything that acts on visitor
addresses: login throttling and flood control, IP bans and rate limits, accurate
dblog/syslog entries, analytics and geolocation, and IP‑based access rules. All
of them read `REMOTE_ADDR`, so all of them benefit once this module restores the
correct value.

This guide is written for a **human** setting the site up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the two `settings.php` keys that
   drive it, and how the trusted‑proxy logic works.

## Where it lives in the admin menu

Nowhere — Reverse Proxy Header has **no admin UI, no config form and no
permissions**. It is configured entirely through `$settings` in your
`settings.php` file. See [Configuration](configuration/index.md).

## How to use it

1. Enable the module.
2. Add one line to `settings.php` naming the header to read, for example:
   ```php
   $settings['reverse_proxy_header'] = 'HTTP_X_FORWARDED_FOR_CUSTOM_HEADER';
   ```
3. The change takes effect on the next request — no cache rebuild needed.

A single event subscriber then runs on every request at priority 350 (ahead of
core's router and authentication subscribers), reads the named header, takes the
first value that is a valid IP address, and sets it as `REMOTE_ADDR`. If the
setting is unset, the module does nothing at all.
