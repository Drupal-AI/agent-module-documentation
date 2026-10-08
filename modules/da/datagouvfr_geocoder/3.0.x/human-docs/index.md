# AdressDataGouvFr Geocoder Provider — manual setup guide

**AdressDataGouvFr Geocoder Provider** (`datagouvfr_geocoder`) adds a
France-only geocoding provider to the
[Geocoder](https://www.drupal.org/project/geocoder) module. It is backed by the
free, official `adresse.data.gouv.fr` web service (the *Base Adresse
Nationale*, or BAN), so you can turn French postal addresses into
latitude/longitude coordinates — and coordinates back into addresses — without
a paid provider, an API key, or a US cloud service.

It supports both directions: **forward** geocoding (an address string becomes
coordinates) and **reverse** geocoding (a latitude/longitude becomes a French
street address). Each lookup returns the single best match, mapped into house
number, street, city, postcode, and coordinates, with the country fixed to `FR`
and the timezone to `Europe/Paris`. Because the service only covers French
addresses, lookups for anywhere else come back empty.

This is a thin provider plug-in with **nothing to configure in the module
itself** — the endpoint URL is fixed in code and the service needs no key. You
enable it, then select it inside Geocoder's own provider settings (or from a
Geocoder-based field widget/formatter). It depends only on the **Geocoder**
module (`^4.0`); it adds no admin page, permissions, or Drush commands of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Geocoder.

## Where it lives in the admin menu

The module has no page of its own. You manage the provider it adds from
**Configuration → System → Geocoder → Providers**
(`/admin/config/system/geocoder/providers`), which belongs to the Geocoder
module.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — Geocoder is a
   hard dependency and comes along for the ride.
2. Go to the Geocoder providers admin at
   `/admin/config/system/geocoder/providers` and **add a provider** of type
   **adresse.data.gouv.fr**. There are no per-provider options to fill in — no
   API key, no base-URL override.
3. Reference that provider wherever Geocoder consumes one: a Geocoder field
   widget or formatter (for example, to fill a Geofield from a plain-text
   address field on save), or a provider chain used by another module.

Behind the scenes the provider calls
`https://api-adresse.data.gouv.fr/search/` for forward lookups and
`https://api-adresse.data.gouv.fr/reverse/` for reverse lookups, and takes only
the first result each time. A few constraints to plan around:

- **France only.** Non-French addresses resolve to nothing.
- **No rate limiting is built in.** The upstream API allows roughly 50
  requests/second and 2 concurrent requests per IP — if you run a bulk import or
  migration, throttle it yourself so you stay within those limits.
- **The endpoint is hardcoded.** To point at a mirror or proxy you would have to
  patch the module.
