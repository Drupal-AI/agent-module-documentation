# Geocoder Autocomplete — manual setup guide

**Geocoder Autocomplete** (`geocoder_autocomplete`) adds a text‑field widget whose
autocomplete suggestions are real addresses returned by the Google Geocoding API.
Editors start typing a place — "Eiffel Tower", a street, a city — and pick a fully
formatted address from the drop‑down, so free‑text address entry gets standardized
to Google's canonical `formatted_address` form and typos drop away.

The widget attaches to any plain **string** field from that field's *Manage form
display* tab. When it renders for a user who is allowed to use it, it wires up
Drupal's autocomplete behavior to an internal lookup route. That route calls
Google's Geocoding endpoint server‑side using the API key you configure, optionally
biased toward a country and localized to the site's current language, and returns
matching addresses. The chosen address string is saved into the plain string
field; the module keeps your Google API key on the server and out of page markup.

A single global settings form holds the Google API key and an optional region
bias. Access to the lookup endpoint is gated by a dedicated permission, so
anonymous or low‑trust users cannot quietly consume your Google API quota. To use
the module you will need a Google Cloud API key with the **Geocoding API** enabled
and billing configured.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the Google API key and region
   bias, place the widget on a field, and grant the permissions.

## Where it lives in the admin menu

The global settings form sits at **Configuration → System → Geocoder
Autocomplete** (`/admin/config/system/geocoder_autocomplete`), reachable by users
with the **Administer geocoder autocomplete** permission. The widget itself is
chosen per field on each bundle's **Manage form display** tab.
