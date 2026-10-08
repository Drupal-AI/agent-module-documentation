# Pelias Field — manual setup guide

**Pelias Field** (`pelias_field`) provides a custom field with **geocoding
autocomplete** powered by the **Pelias** geocoder. An editor starts typing an
address into the field, sees real‑time search suggestions, and picks the match; the
field then stores the geocoded result — both the raw JSON from the API and parsed,
structured data such as coordinates. It works with the hosted **Geocode Earth**
service or a **self‑hosted Pelias** instance.

Beyond the autocomplete itself, the module stores rich data (raw JSON plus parsed
fields), lets you configure which fields to extract from the API response, and
includes performance safeguards — debouncing, caching, and rate limiting — so
as‑you‑type lookups don't hammer the geocoder. Display of the stored value is
handled by customisable formatters.

Two things are worth understanding about how it talks to Pelias. First, the
autocomplete requests are **proxied through Drupal server‑side**, so your API key
is used on the server and is **not exposed to the browser** — a good design. That
proxy endpoint is, however, **open** (it has to be, so it can answer as‑you‑type
queries from the edit form), so if you use a **paid** geocoder like Geocode Earth,
make sure you have rate limiting in place to control usage and cost. Second, using
the field means addresses editors type are **sent to the Pelias service** (Geocode
Earth or your own instance) — outbound requests to a third party if you use the
hosted service — so serve your site over HTTPS and consider whether a self‑hosted
Pelias is a better fit for sensitive data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module has an admin interface for the API connection (with an API‑testing
tool) plus per‑field settings. The setup and those API settings are described in
"Configuring the connection" and "How to use it" below.

## Where it lives in the admin menu

Pelias Field adds an **admin settings page** for the API connection (endpoint, key,
and performance options) under **Configuration**, and you add the actual field to a
content type from **Structure → Content types → *(your type)* → Manage fields**.

## Configuring the connection

On the module's API settings page, provide:

- **API Endpoint** — `https://api.geocode.earth/v1` for the hosted Geocode Earth
  service, or the URL of your own self‑hosted Pelias instance.
- **API Key** — required for Geocode Earth (its keys look like `ge-…`). This is a
  **credential**: keep it out of version control, and prefer supplying it via an
  environment variable / Key‑style secret rather than committing it in exported
  configuration. The key is used server‑side and is not sent to the browser.
- **Performance settings** — request timeout, rate limits, debounce delay, and
  caching. Set a sensible **rate limit** if you use a paid geocoder, because the
  autocomplete endpoint is open.
- **Data sources and layers** — choose which Pelias data sources (OSM,
  OpenAddresses, GeoNames, Who's On First) and place types / layers (venue,
  address, street, country, region, locality, and so on) are available to the
  autocomplete.

There is also a built‑in **API test** so you can confirm the endpoint and key are
working before you rely on the field.

## How to use it

1. Configure the API endpoint and key as above.
2. Go to **Structure → Content types → *(your type)* → Manage fields** and add a
   **Pelias** geocoding field.
3. On the field/form settings, adjust which response fields are extracted and stored
   if you need something other than the defaults.
4. Create or edit content — type an address into the field, choose a suggestion, and
   the geocoded result (including coordinates) is stored with the entity.
