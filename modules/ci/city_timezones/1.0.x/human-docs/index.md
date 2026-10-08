# City Timezones — manual setup guide

**City Timezones** (`city_timezones`) makes picking a timezone friendlier. Drupal's
account form normally offers a long list of IANA timezone names (like
`America/Argentina/Buenos_Aires`) that many users find unfamiliar. This module adds
a **city search** to the top of that timezone section: the user searches for a
nearby city, and the module automatically selects the matching IANA timezone for
them.

The city list comes from the [GeoNames](https://www.geonames.org) `cities500`
dataset bundled with the module. The selector is enhanced with the
[Chosen](https://www.drupal.org/project/chosen) library so users can type to filter
the options, and a small amount of JavaScript looks up the chosen city's timezone
and fills in the standard field. Two lightweight JSON endpoints serve the city
list and the city→timezone lookup to that JavaScript.

The module works as soon as it is enabled — the city selector appears on the user
account form immediately. An optional settings form lets you trim and tune the list:
restrict it to particular countries, set a minimum city population so the dropdown
isn't overwhelming, and toggle the Chosen enhancement. The JSON endpoints expose
only public geographic reference data (city names and timezones), never user data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pull in the Chosen dependency.
2. [Configuration](configuration/index.md) — trim the city list by country and
   population, and toggle the Chosen dropdown.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → City
Timezones** (`/admin/config/regional/city-timezones`) and is gated by the
**Administer site configuration** permission. The city selector itself appears on
the standard user account form (registration and profile edit).
