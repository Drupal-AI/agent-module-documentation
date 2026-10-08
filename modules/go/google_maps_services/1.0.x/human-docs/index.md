# Google Maps Services — manual setup guide

**Google Maps Services** (`google_maps_services`) is a base integration that gives
Drupal code access to Google Maps' **web service APIs** — the server‑side endpoints
for geocoding, directions, distance matrix, elevation, geolocation and time zone
lookups. Rather than doing anything user‑facing on its own, it provides a service you
call from your own modules or features when you need to turn an address into
coordinates, calculate a route, and so on.

It authenticates to Google with a single **API key** that you configure once. Because
that key controls billed API access, storing and restricting it correctly is the most
important part of setup.

The module supports the following Google Maps web services:

- **Directions API**
- **Distance Matrix API**
- **Elevation API**
- **Geocoding API**
- **Geolocation API**
- **Time Zone API**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — obtain, enter, and restrict your Google
   Maps API key.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Google Maps Services**
(`/admin/config/services/google-maps-services`), where you enter the API key.
