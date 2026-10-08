Geocoder is a services-based API that converts addresses into geographic coordinates (geocoding) and coordinates back into addresses (reverse geocoding), wrapping the popular willdurand/Geocoder PHP library and exposing 30+ providers (Google Maps, Nominatim, ArcGIS, Mapbox, TomTom, and more) to Drupal.

---

At its core Geocoder provides a `geocoder` service with `geocode()` and `reverse()` methods that run a query through an ordered list of provider plugins and return address collections. Providers are configured as `geocoder_provider` config entities (each backed by a Provider plugin such as Google Maps or Nominatim, with its API key/options), managed at Admin → Configuration → System → Geocoder. Results can be transformed by **Dumper** plugins into GIS formats (GeoJSON, WKT, WKB, GPX, KML, plain address text) and by **Formatter** plugins into formatted strings — Provider, Dumper and Formatter are the three annotation-based plugin types the module defines, so the ecosystem is extensible. It adds a dedicated cache bin and a throttle service (via davedevelopment/stiphle) to respect provider rate limits, plus optional queueing and pre-save toggles. Two GET REST endpoints (`/geocoder/api/geocode` and `/geocoder/api/reverse_geocode`, permission-gated) let JavaScript and external clients geocode on demand. A set of alter hooks let you adjust the address string, the geocode query, the coordinates, and the resolved country code. The base module is an engine; the shipped submodules connect it to Drupal fields: **Geocoder Field** geocodes one field into another on entity save, **Geocoder Geofield** targets Geofield storage, and **Geocoder Address** integrates the Address module. Individual willdurand provider packages are pulled in via Composer as needed. It targets Drupal 9.5, 10 and 11.

---

- Convert a postal address into latitude/longitude on node save.
- Reverse-geocode stored coordinates back into a readable address.
- Geocode using Google Maps with an API key.
- Geocode with the free Nominatim/OpenStreetMap provider.
- Fall back across multiple providers if the first fails.
- Store geocoded points in a Geofield (via geocoder_geofield).
- Populate an Address field from coordinates (via geocoder_address).
- Output geocoding results as GeoJSON for a map front-end.
- Dump a location to WKT or WKB for spatial storage.
- Export a point as GPX or KML.
- Geocode addresses in bulk from a custom batch/queue.
- Respect provider rate limits with the built-in throttle.
- Cache geocoding responses to cut API calls and cost.
- Geolocate a visitor by IP with an IP-based provider (FreeGeoIp, MaxMind…).
- Offer a JavaScript autocomplete that hits the geocode REST endpoint.
- Let an external app reverse-geocode via the API endpoint.
- Configure per-provider options and keys as exportable config entities.
- Add a brand-new geocoding provider via a Provider plugin.
- Add a custom output format via a Dumper plugin.
- Normalize inconsistent user-entered addresses into structured data.
- Alter the address string before geocoding with a hook.
- Adjust the geocode query (locale, bounds) via a hook.
- Correct the resolved country code when writing an Address field.
- Geocode a "Store locator" content type for proximity search.
- Pre-compute coordinates for imported/migrated address data.
- Chain a field's plain-text address into a map-ready coordinate field.
- Build a distance/proximity filter feeding Geofield proximity sources.
- Queue geocoding to avoid slow saves on high-traffic sites.
