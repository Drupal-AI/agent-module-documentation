# Anonymous Timezone — manual setup guide

**Anonymous Timezone** (`anonymous_timezone`) makes dates and times display in an
anonymous visitor's *own* timezone instead of the site default. Normally a
logged‑out visitor sees dates in whatever timezone the site is configured for; this
module looks up the visitor's location from their IP address (using a MaxMind
GeoIP2 database) and uses the resulting timezone when Drupal formats dates for that
request.

It works by overriding Drupal's `current_user` service for anonymous requests, so
any code that reads the current user's timezone benefits automatically. Only
anonymous users are affected — authenticated users keep the timezone set on their
account. If a visitor's IP cannot be resolved, it falls back to the site default
timezone.

One trade‑off to understand: because the response now depends on each visitor's IP,
the module uses Drupal's page‑cache "kill switch" so per‑visitor timezones do not
get baked into the shared anonymous page cache. That reduces cacheability for the
affected responses, so weigh the benefit against the caching cost.

This module needs a MaxMind GeoIP2/GeoLite2 database file and the `geoip2/geoip2`
PHP library — see [Installation](installation/index.md) — and you point it at the
database file on its settings form (see [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the `geoip2/geoip2` library and
   the module.
2. [Configuration](configuration/index.md) — point the module at your GeoIP
   database file.

## Where it lives in the admin menu

The settings form is at **Configuration → Anonymous Timezone**
(`/admin/config/anonymous_timezone`), gated by the **Administer site
configuration** permission.
