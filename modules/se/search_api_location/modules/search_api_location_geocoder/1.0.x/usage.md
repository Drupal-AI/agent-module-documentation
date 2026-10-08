<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Location Geocoder adds a "Geocoded input" Location Input plugin to Search API Location, letting users type a plain address (instead of coordinates or a map click) that is geocoded to latitude/longitude using the Geocoder module's providers before the proximity search runs.

---

This submodule integrates the contrib **Geocoder** module with Search API Location by providing one `@LocationInput` plugin: **`geocode`** ("Geocoded input"), a class extending `LocationInputPluginBase` and implementing `ContainerFactoryPluginInterface` to inject the `geocoder` service, `config.factory` and the `geocoder_provider` entity storage. Its `getParsedInput()` takes the user's address string, calls `geocoder->geocode($value, $active_plugins, $plugin_options)` using the geocoder providers that are enabled in the plugin's configuration (ordered by weight, first valid result wins), and returns the first result's `"lat,lon"`. Its configuration form lists all `geocoder_provider` config entities as a draggable table of checkboxes so an admin can pick and order which providers to try. Because it plugs into the same Location Input plugin type, the `geocode` input becomes selectable anywhere a Location Input is used — e.g. the `search_api_location_views` proximity filter's exposed widget, or a facet. It therefore requires the Geocoder module and at least one configured `geocoder_provider` to be useful; the quality/availability of geocoding depends on those providers (many call external services). Enable it, configure Geocoder providers, then choose "Geocoded input" as the input method on your location filter.

---

- Let site visitors search "restaurants near 10 Downing Street" by typing an address.
- Power a "search near this postcode/ZIP" box on a store locator.
- Use a city or place name as the origin of a proximity search.
- Geocode a typed address to coordinates before running a Search API distance filter.
- Offer address entry as an alternative to raw lat/lon or map-click inputs.
- Choose and order multiple geocoder providers so a fallback is tried if the first fails.
- Use a local/offline geocoder provider (e.g. a file or test provider) for development.
- Use a commercial geocoder (Google, Nominatim, etc. via Geocoder) for production address lookup.
- Combine geocoded address input with a distance-sorted Views results list.
- Let editors preview address-based searches in the Views UI.
- Provide address search on a decoupled front end via a geocoded proximity filter.
- Support international address formats by picking a suitable geocoder provider.
- Reduce user friction versus asking visitors for coordinates.
- Feed the geocoded point into a facet or contextual filter.
- Fall back across providers ordered by weight until one returns a valid coordinate.
- Localise a directory search to "near me" by geocoding a typed location.
- Add address-based proximity search to an events or jobs search page.
- Pair with search_api_location_views so the exposed filter widget is an address box.
- Standardise geocoding across search filters by configuring providers once.
- Support autocompleteless plain-text address entry that resolves server-side.
