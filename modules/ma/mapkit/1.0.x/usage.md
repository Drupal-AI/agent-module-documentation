<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mapkit is a provider-agnostic mapping framework that renders maps, geolocation inputs and proximity searches through pluggable map-provider, marker, location-resolver, location-input and geo-parser plugins.
---
The module itself ships no concrete map provider; it defines the plugin managers and a `mapkit_map` field formatter, theme hooks (`mapkit_map`, `mapkit_autocomplete`, `mapkit_geolocation_link`, `mapkit_location_list`) and Views integration (a location row/style/field/filter/argument plus a Search API location data type and proximity trait). Concrete providers are added by companion modules such as `mapkit_gmap`. A `MarkerSet` config entity groups marker configurations, and a `GeoParser` strategy manager decides how lat/lng is extracted from fields and Views handlers (`hook_field_formatter_info_alter` widens the `mapkit_map` formatter to any field type a parser supports).

The only route, `/admin/config/services/mapkit`, lists installed map providers and links to each provider's own configuration form; it is gated by the `administer mapkit providers` permission (a second permission, `administer mapkit markers`, guards marker config). There are no anonymous or mutating endpoints. Setup is: install a provider module (e.g. `mapkit_gmap`), configure it, then place the Mapkit map formatter on a geo-capable field or build a Mapkit Views display.
---
- Install Mapkit as the base for a maps/proximity feature.
- Add a concrete provider by enabling `mapkit_gmap`.
- Review installed providers at `/admin/config/services/mapkit`.
- Grant `administer mapkit providers` to map administrators.
- Grant `administer mapkit markers` to marker managers.
- Render a location field with the `mapkit_map` field formatter.
- Show a geofield / address / geolocation field on a map.
- Build a Views display using the Mapkit location row plugin.
- Style a View as a Mapkit map with the location style plugin.
- Add a proximity distance field to a View.
- Filter a View by distance from a point (proximity search).
- Add a location argument to a View for contextual proximity.
- Index a location for proximity search via the Search API location data type.
- Configure a MarkerSet config entity to group marker styles.
- Provide a "use my location" geolocation link in a form.
- Add an autocomplete location input to a form.
- Add a plain textfield location input to a form.
- Extract lat/lng from a custom field by adding a geo-parser plugin.
- Implement a custom map-provider plugin for another maps SDK.
- Implement a custom marker plugin.
- Theme the map output by overriding the `mapkit_map` template.
- Resolve a user's location with the user location resolver plugin.
- Integrate Mapkit maps with an Address or Geocoder field.
