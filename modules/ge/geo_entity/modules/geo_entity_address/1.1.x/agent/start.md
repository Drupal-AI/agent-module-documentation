# Geo Entity: Address — agent index

Installs the `address` geo bundle (point + structured postal address) and a geocoding
address-autocomplete widget. Depends on `geo_entity`, `geocoder`, `address`. No permissions, no config UI
(`configure` null); provides a config schema. Parent: [../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md).

- **The `geo_entity_address` field widget + form element, provider selection, geofield population** → [api/widget.md](api/widget.md)

Key facts:
- Bundle `address` with fields: `postal_address` (address), `location` (geofield), `external_id`, `accessibility`. Displays: default/inline form, default/embed/full view.
- Widget id `geo_entity_address` (`AutocompleteAddress` extends Address `AddressDefaultWidget`); form element `#type => 'geo_entity_address'` (extends Address element).
- Widget settings: `providers` (draggable Geocoder provider table, ≥1 required) and `geocode_geofield` (which geofield to fill with lat/lon).
- Autocomplete goes through the parent route `geo_entity.autocomplete` (HMAC-protected — see parent api/entity.md).
- Ships Geocoder provider configs `geo_entity_osm` (OSM/Nominatim) and a demo Photon provider.
