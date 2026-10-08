Geo Entity: Address adds an `address` bundle to the Geo entity for storing a point location plus a structured postal address, with a geocoding address-autocomplete field widget.

---

This submodule installs the `address` geo type and its fields (`postal_address` from the Address module, a `location` geofield, `external_id`, `accessibility`) with default form/view displays and `embed`/`full`/`inline` modes. Its main code is a field widget `geo_entity_address` (`AutocompleteAddress`, extending Address module's `AddressDefaultWidget`) and a matching form element `geo_entity_address` (extending Address element). The widget's settings form lets an admin pick and order one or more Geocoder providers and a target geofield to populate. As an editor types, the element geocodes the entered address (through the parent module's HMAC-protected `geo_entity.autocomplete` route) and offers structured suggestions; selecting one fills the address subfields and, if configured, the latitude/longitude of the chosen geofield. It ships two Geocoder provider configs (`geo_entity_osm` OSM/Nominatim and a demo Photon provider). Depends on `geo_entity`, `geocoder` and `address`.

---

- Add a bundle that stores a point (lat/lon) together with a full structured postal address.
- Give editors an address field that autocompletes and geocodes as they type.
- Populate a geofield's coordinates automatically from the selected geocoded address.
- Choose which Geocoder provider(s) resolve addresses per field (OSM/Nominatim, Photon, commercial).
- Order/weight multiple providers so the first that returns a result wins.
- Format address line 1 with house-number-before-street rules for the relevant countries.
- Reuse the OSM (`geo_entity_osm`) provider config shipped by the submodule instead of configuring Nominatim by hand.
- Build a directory of businesses/venues each stored as an address geo entity.
- Let a custom form embed the `geo_entity_address` element to get address autocomplete outside the geo entity.
- Store an `external_id` on each address for syncing with an external system.
- Record accessibility information alongside the address.
- Render an address geo in its `embed` view mode inside another entity via Entity Browser.
- Swap the demo Photon provider for a self-hosted Photon instance.
- Localize geocoding by passing the interface language through to the provider.
- Reuse one stored address across many nodes via the geo library Entity Browser.
