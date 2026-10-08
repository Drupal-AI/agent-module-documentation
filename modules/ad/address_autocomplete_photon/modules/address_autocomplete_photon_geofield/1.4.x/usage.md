<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Geofield prepopulate is a submodule of Address Autocomplete (Photon) that automatically fills a **Geofield's latitude and longitude** from the geometry of the address suggestion the user selects in the Photon-backed autocomplete widget.

---

The submodule has almost no PHP: a single hook implementation (`AddressAutocompletePhotonGeofieldHooks::fieldWidgetSingleElementFormAlter()`, registered via `#[Hook('field_widget_single_element_form_alter')]` and the autowired service in `address_autocomplete_photon_geofield.services.yml`) attaches the library `address_autocomplete_photon_geofield/autocomplete` to the widget form of every field of type `geofield`. That library's JavaScript (`js/address-autocomplete.js`, `Drupal.behaviors.addressAutocompletePhotonGeoField`) listens for the parent widget's `autocompleteselect` event and, when the selected Photon result has a `geometry`, writes `geometry.coordinates[0]` into the `.geofield-lon` input and `geometry.coordinates[1]` into `.geofield-lat`, then triggers their `change` events. It hides or sets the Geofield inputs read-only in step with the parent module's `managed_fields_display` setting, and re-shows them when the parent's override toggle is used. If the user later edits an address sub-field by hand (because a Photon property was missing), the behavior re-queries `https://photon.komoot.io/api/` from the browser with the recomposed address and updates the coordinates from the first result. The submodule provides no routes, no permissions, no config and no settings of its own — it depends on both the parent `address_autocomplete_photon` module and `geofield`, and inherits the parent's configuration entirely.

---

- Store map coordinates (lat/lon) for an address whenever a user picks an autocomplete suggestion.
- Populate a Geofield automatically so editors never type coordinates by hand.
- Keep a node's address and its Geofield point in sync from a single lookup.
- Feed Leaflet / Geofield Map / OpenLayers displays with coordinates derived from the entered address.
- Geocode customer or member addresses at data-entry time instead of running a batch geocoder.
- Show submitted locations on a map view using the auto-filled Geofield.
- Capture coordinates for store locators, event venues or delivery addresses on submission.
- Hide the raw lat/lon inputs so the form shows only the address autocomplete box.
- Set the lat/lon inputs read-only (disable mode) so users see but cannot alter the coordinates.
- Re-geocode coordinates when a user manually corrects an address sub-field.
- Add geospatial data to any entity that already uses the Photon address autocomplete widget plus a Geofield.
- Avoid a separate geocoding module/API key by reusing the address autocomplete's Photon results.
- Reveal the Geofield again for manual editing via the parent module's override toggle.
- Support Commerce or profile entities that need both a postal address and map coordinates.
- Keep coordinate capture entirely client-side, driven by the address the user selects.
