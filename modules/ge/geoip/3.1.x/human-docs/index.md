# GeoIP — manual setup guide

**GeoIP** (`geoip`) is a small utility module that answers one question: *which
country is this IP address in?* It geolocates a visitor's IP to an ISO country
code through pluggable **GeoLocator** plugins, and exposes that as a simple API for
other code and modules to use. It does nothing visible on its own — it doesn't
block, redirect, or personalize anything by itself. Instead it gives you a
reliable country lookup that you (or other modules) wire into your own access,
redirect, tax, consent, or personalization logic.

It ships three geolocation sources, and you pick one as active:

- **CDN** — reads a country header that your CDN or reverse proxy already sets:
  Cloudflare's `CF-IPCountry`, Amazon CloudFront's viewer-country header, or a
  custom header you name (for Fastly, Varnish, and others). This is the default
  and needs no database.
- **Local** — queries a self-hosted MaxMind **GeoLite2** `.mmdb` database file
  using the `geoip2/geoip2` library. Fully offline, but you must supply the
  database file (the optional update submodule can fetch it for you).
- **Webservice** — queries MaxMind's hosted GeoIP2 web service using your account
  ID and license key.

An optional **GeoLite2 Database Update** submodule downloads and refreshes the
Local database automatically (on cron or via Drush). Results are cached per IP, and
a `geoip_country` cache context lets render arrays and Views vary output by the
visitor's country.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the database-update submodule.
2. [Configuration](configuration/index.md) — pick the active geolocation source
   and enter its settings.

## Where it lives in the admin menu

The settings form is at **Configuration → System → GeoIP**
(`/admin/config/system/geoip`), gated by the core **Administer site
configuration** permission. It's where you choose the active plugin, set the CDN
header name or the web-service credentials, toggle a debug log, and run a manual
IP lookup to test.

## How to use it

Set the active source on the settings form, then let other code consume the
lookup. Programmatically, calling
`\Drupal::service('geoip.geolocation')->geolocate($ip)` returns an ISO country
code (or `NULL`). For example, a custom module or event subscriber can read the
visitor's country and decide whether to show a region-specific block, preselect a
currency, or apply a country restriction. To vary cached render output by country,
add the `geoip_country` cache context.

> **A note on access control:** GeoIP only *reports* the country — any allow/deny
> or "block this country" behavior is logic you build on top of the returned code.
> IP-based geolocation is approximate and can be spoofed, so don't rely on it as a
> hard security boundary.
