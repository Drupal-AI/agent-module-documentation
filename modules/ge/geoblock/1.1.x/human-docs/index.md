# Geoblock — manual setup guide

**Geoblock** (`geoblock`) blocks incoming requests based on the origin country of
the visitor's IP address. You give it an allow-list or block-list of countries
(and, optionally, a "domestic use only" rule), and it returns a **403 Forbidden**
to anyone whose request violates the rules. It's aimed at access control and
security use cases: keeping a regional service inside its home country, complying
with export/embargo rules, or cutting down abusive form submissions from specific
regions.

There is one very important thing to understand before you rely on it:
**Geoblock ships no way to look up a country from an IP address on its own.**
Country lookup is delegated to a pluggable *data source*, and the module includes
none. Until you install or build a `geoblock_data_source` plugin (for example one
backed by MaxMind, Cloudflare headers, or another GeoIP provider) and select it in
the settings, Geoblock is effectively switched off — it will never block anything.
This is by design, so you can plug in whichever geolocation backend you already
have. See the [`agent/`](../agent/start.md) docs for how to implement one.

A second thing to note: by default Geoblock only checks *mutating* HTTP methods
(POST, PUT, PATCH, DELETE, CONNECT). **Ordinary page views (GET/HEAD) are not
blocked** unless you add those methods yourself. That keeps normal browsing,
caching, and search-engine crawlers working while you restrict, say, form
submissions. Country codes are ISO 3166-1 alpha-2 values (like `US`, `CN`, `RU`),
validated against the `league/iso3166` library. Geoblock requires Drupal 10.1+/11
and PHP 8.1+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the crucial note about needing a data source plugin.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   data source, applicable methods, allow/block lists, domestic-use, logging.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Geoblock** (`/admin/config/geoblock`),
gated by the **Administer geoblock** permission — the only permission the module
defines.

## How to use it

1. Install and enable Geoblock, plus a module that provides a
   `geoblock_data_source` plugin (Geoblock ships none — see
   [Installation](installation/index.md)).
2. Go to **Configuration → Geoblock** and pick your **Data source**. Without one
   selected, nothing is blocked.
3. Choose a restriction: an **allow** list (only the listed countries may reach
   the site) or a **block** list (the listed countries are denied), and enter the
   ISO country codes. Optionally require "domestic use" to catch IPs used outside
   their registered country.
4. Decide which HTTP methods the rules apply to. Remember GET/HEAD are excluded by
   default, so page views stay open unless you add them.
5. Save. Enforcement happens on every matching request; blocked visitors get a
   plain 403 with a short "geographical restrictions" message.
