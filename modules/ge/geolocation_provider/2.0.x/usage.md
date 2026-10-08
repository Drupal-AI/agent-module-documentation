<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Geolocation Provider defines a `GeolocationProvider` plugin type that turns an address string into geographic coordinates (and coordinates back into an address) through a provider you can swap, shipping a French Bano/IGN provider and an OpenStreetMap Nominatim provider out of the box.

---

This is address geocoding, not IP geolocation: give it a postal address or place name and a provider returns a GeoJSON `FeatureCollection` of candidate points with latitude/longitude and normalised address parts, or take a lat/lon pair and get the nearest address back (reverse geocoding). The abstraction is a Drupal plugin type — each provider is a `@GeolocationProvider` annotated class extending `GeolocationProviderPluginBase`, which hands the plugin a Guzzle `http_client` and the serializer; the base `get($url, $to_array)` fetches the provider's endpoint and decodes the reply through a custom `geojson` serializer format into `FeatureCollection`/`Feature` objects (or a raw array when `$to_array` is TRUE). Two providers ship: **Bano** (`bano_geolocation_provider`) calls the French IGN geocoding API at `data.geopf.fr/geocodage/search` and `/reverse`; **Nominatim** (`nominatim_geolocation_provider`) calls `nominatim.openstreetmap.org/search` and `/reverse` and adds a `geolocationStructured($street, $postcode, $city)` method. Neither provider uses an API key — both target keyless public endpoints. The module also registers four routes that expose the providers directly as JSON callbacks (`/geolocation_provider/geolocation/{plugin}/{search}`, `/reverse/{plugin}/{lat}/{lon}`, `/geolocation_structured/...`, and a `/dep/{depCode}` French-department lookup); all four are gated only by the `access content` permission, so on a standard site they answer to anonymous visitors and each request triggers a server-side call to the fixed external geocoding host — mind the provider's usage policy (Nominatim caps at ~1 request/second and blocks abusive IPs). Version **2.0.0**, core `^8` through `^11`, depending only on core `serialization`; it does no work on its own beyond the demo callbacks — it is infrastructure a mapping or address module consumes by calling the plugin manager `plugin.manager.geolocation_provider_plugin`.

---

- Geocode a postal address to latitude/longitude.
- Reverse geocode coordinates to the nearest address.
- Geocode a French address via the IGN/Bano provider.
- Geocode any worldwide address via Nominatim/OpenStreetMap.
- Run a structured street/postcode/city query through Nominatim.
- Get a GeoJSON `FeatureCollection` of candidate matches.
- Read normalised address parts (housenumber, street, postcode, city, label) off a `Feature`.
- Define a custom geocoding provider as a `@GeolocationProvider` plugin.
- Swap the geocoding backend without touching consuming code.
- Call the geocoder from a custom module through the plugin manager.
- Populate a map field from a typed address.
- Add address autocomplete backed by a real geocoder.
- Decode a third-party GeoJSON response into value objects.
- Register a new external geocoding API behind the shared interface.
- Fetch a French department name from its code.
- Expose geocoding to the front end as a JSON callback route.
- Return raw JSON instead of objects with the `$to_array` flag.
- Iterate candidate results (`FeatureCollection` is `Iterator`/`Countable`).
- Provide a stub/test provider for geocoding in tests.
- Standardise geocoding across several consumers on one site.
