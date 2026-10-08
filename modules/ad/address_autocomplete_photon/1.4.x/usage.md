<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Address Autocomplete (with Photon API) adds a **"Address autocomplete with Photon"** field widget to core Address fields: the user types a single line and picks a suggestion, and the module fills in the individual address components (street, city, postcode, country, etc.) from the open-source **Photon** geocoder (Komoot / OpenStreetMap).

---

The module extends the Address module rather than replacing it. It ships a form element `address_autocomplete` (`src/Element/AddressAutocomplete.php`, extending `\Drupal\address\Element\Address`) and a field widget `address_autocomplete_photon` (`src/Plugin/Field/FieldWidget/AddressAutocomplete.php`, extending `AddressDefaultWidget`) that swaps the address element's `#type` to `address_autocomplete`. The element injects a single extra text field (`location_field`, class `address-autocomplete-input`) above the normal Address sub-fields and attaches the `address_autocomplete_photon/autocomplete` library plus a `drupalSettings.addressAutocomplete` payload built from the site config object `address_autocomplete_photon.settings` (keys `min_length`, `limit`, `remove_duplicates`, `managed_fields_display`) together with the current country and the country's address format string. All geocoding happens **in the browser**: `js/plugin/address-autocomplete-photon.jquery.js` wires jQuery UI autocomplete to `https://photon.komoot.io/api/`, sends the typed term plus the selected country label as the query, filters results to the chosen country, optionally de-duplicates them, formats each suggestion using the country's address format, and on selection maps Photon result `properties` (name, street, housenumber, city, state, postcode, countrycode…) into the individual Address sub-field inputs. The managed sub-fields are hidden or disabled per the `managed_fields_display` setting (`hide`, `disable`, or `default`); when the widget's `allow_overrides` setting is on **and** the user holds the `override address fields` permission, a toggle button lets the user reveal and hand-edit the auto-filled fields. Configuration lives at **`/admin/config/system/address-autocomplete-photon`** (`SettingsForm`, route `address_autocomplete_photon.configure`, permission `administer address autocomplete photon`). A submodule, **address_autocomplete_photon_geofield**, additionally populates a Geofield's latitude/longitude from the selected suggestion's geometry. The module has no server-side controller or proxy — the only server route is the admin settings form — and address suggestions are limited to the countries allowed by the underlying Address field settings.

---

- Let site users enter a full postal address by typing once and selecting a suggestion, instead of filling every sub-field by hand.
- Speed up checkout, registration or contact forms that contain an Address field.
- Auto-fill street, house number, city, postal code, state and country from a single lookup.
- Use a free, open-source geocoder (Photon / OpenStreetMap) with no API key required for the public endpoint.
- Reduce data-entry errors and inconsistent address formatting across submissions.
- Hide the individual Address sub-fields so the form shows only one clean autocomplete box.
- Disable (rather than hide) the sub-fields so users can see the auto-filled values but not change them.
- Show the sub-fields normally (`default` mode) while still offering autocomplete.
- Restrict suggestions to specific countries by configuring the Address field's available countries.
- Limit the number of suggestions shown in the dropdown (`limit` setting).
- Require a minimum number of typed characters before the lookup fires (`min_length` setting).
- Remove Photon's duplicate suggestions (e.g. a city that is also a state) with the `remove_duplicates` setting.
- Allow privileged editors to override the auto-filled values via a toggle button (`override address fields` permission + widget `allow_overrides`).
- Apply the module to any entity with an Address field (node, user, Commerce customer profile, custom entity) by choosing the widget on the form display.
- Keep the correct per-country street formatting (e.g. `10 Downing Street` vs `Downing Street, 10`) automatically.
- Add the geofield submodule to capture map coordinates (lat/lon) alongside the postal address.
- Prepopulate a Geofield for storing/displaying the selected address on a map.
- Fall back gracefully to the standard Address form when JavaScript is disabled.
- Localize suggestions to the current site language via the Photon `lang` parameter.
- Offer address autocomplete for Drupal Commerce billing/shipping profiles limited to supported store countries.
