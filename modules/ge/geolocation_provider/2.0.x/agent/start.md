<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geolocation Provider (geolocation_provider) — agent index

**Address geocoding behind a Drupal plugin type.** Turns an address string into coordinates
(forward geocoding) and coordinates back into an address (reverse geocoding) through a swappable
`GeolocationProvider` plugin. This is **address geocoding, not IP geolocation** — no MaxMind, no IP
lookup, no API keys. Version **2.0.0**, core `^8 || ^9 || ^10 || ^11`, depends only on core
`serialization`.

## What it actually is
- A plugin type `GeolocationProvider` (annotation `@GeolocationProvider`, manager service
  `plugin.manager.geolocation_provider_plugin`, plugins live in `Plugin/GeolocationProvider/`).
- Base class `GeolocationProviderPluginBase` injects Guzzle `http_client` + `serializer`; its
  `get($url, $to_array)` fetches a provider endpoint and decodes it through a custom `geojson`
  serializer format into a `FeatureCollection` of `Feature` value objects (or a raw array when
  `$to_array` is TRUE).
- Two shipped providers, **both keyless** (no API key anywhere in the module):
  - **Bano** (`bano_geolocation_provider`) → French IGN API `https://data.geopf.fr/geocodage/search/`
    and `/reverse/`.
  - **Nominatim** (`nominatim_geolocation_provider`) → `https://nominatim.openstreetmap.org/search`
    and `/reverse`, plus a `geolocationStructured($street, $postcode, $city)` method.
- Four demo/JSON callback routes, all gated only by `_permission: 'access content'` (see api/).
- No config form, no config schema, no permissions, no Drush commands, no submodules.

## Mechanism at a glance
1. A consumer (or a callback route) asks the manager for a provider instance by plugin id.
2. The provider builds the request URL with `Url::fromUri(...)` (query params URL-encoded) and calls
   `get()`.
3. `get()` runs a Guzzle GET (default TLS verification on) and the `GeoJsonEncoder` turns a GeoJSON
   `FeatureCollection` reply into `FeatureCollection`/`Feature` objects; a non-FeatureCollection
   reply decodes to `NULL`.

## Read next
- `agent/plugins/provider-plugin-type.md` — the plugin type, base class, manager, the
  `FeatureCollection`/`Feature` model, and how to write a custom provider.
- `agent/api/routes-and-callbacks.md` — the four JSON callback routes, their parameters, and the
  access model.
