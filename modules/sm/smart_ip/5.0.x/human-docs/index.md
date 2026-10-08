# Smart IP — manual setup guide

**Smart IP** (`smart_ip`) works out a visitor's geographical location — country,
region, city, postal code, latitude/longitude and time zone — from their IP
address. It caches that result in the session (and optionally on the user's
profile), and exposes it to your code, to blocks, and to other modules, so you
can geo-target content, pre-fill location fields, show or hide blocks by country,
and more.

Smart IP itself is a **framework**: it ships no lookup database. The actual
address-to-location lookup is delegated to a pluggable **data source**, and each
data source is a small submodule you enable and select. The choices are MaxMind
GeoIP2 (as a downloadable binary database or as a web service), IP2Location (a
binary database), IPInfoDB or Abstract (keyed web-service APIs), and a device /
W3C source that uses the browser's own Geolocation API. You enable one, pick it
as the active data source, and Smart IP does the rest.

On each request Smart IP geolocates the roles you configure and stores the
result; from then on your code can just read the current visitor's location. It
also provides a **"User country" condition** so you can control block visibility
by country, and an event-based extension model so other modules can adjust
results or add whole new providers. Configuration lives on one settings page, and
the module defines a single permission, `administer smart_ip`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, understand the
   geolocation libraries, and enable a data source submodule.
2. [Configuration](configuration/index.md) — the settings form, choosing and
   feeding a data source (including API keys and secrets), which roles to
   geolocate, and privacy options.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Smart IP**
(`/admin/config/people/smart_ip`), gated by the **Administer Smart IP**
permission. Each data source submodule adds its own section to that same page for
its database path or API credentials.

## How to use it

Enable Smart IP plus one data source submodule (for example MaxMind GeoIP2
binary database). On the settings page, select that source as the **data
source**, provide whatever it needs (a downloaded database or an API key), and
choose which roles should be geolocated. Once a source is active, visitor
location is available to blocks (via the "User country" condition) and to code.
See [Configuration](configuration/index.md) for the full walkthrough, including
the trade-offs between the different data sources.
