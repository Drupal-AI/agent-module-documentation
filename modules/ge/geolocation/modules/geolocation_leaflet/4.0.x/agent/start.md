# geolocation_leaflet — agent start

Adds the open-source Leaflet library as a map provider for Geolocation, with open tile layers
and Nominatim (OSM) geocoding — no API key required. Requires `geolocation`. After enabling,
select "Leaflet" as the map provider in field widget/formatter and Views CommonMap settings.
Nominatim geocoding options: **Admin → Config → Services → Geolocation → Nominatim**
(`/admin/config/services/geolocation/nominatim`, route `geolocation_leaflet.nominatim_settings`,
form `NominatimGeocodingSettings`).

- Tile layers, Nominatim geocoding, Leaflet features → [configure/setup.md](configure/setup.md)
