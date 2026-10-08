<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Address suggestion adds autocomplete to the Address module's fields, so an address is chosen from a lookup service instead of typed into five separate boxes.

---

Address entry is slow and error-prone, and an autocomplete backed by a real address database fixes both. This module supplies it as a pluggable layer built on `drupal/address`: an `AddressProvider` plugin type means the lookup service is swappable, with the active provider chosen in each **field widget's settings** rather than globally, so different fields can use different providers. As the user types, a JS autocomplete calls a server-side JSON route (`address_suggestion.addresses`), which loads the field's stored widget settings, queries the configured external provider (Nominatim, Photon, Google, Here, Mapbox, TomTom, the French/Vietnamese/Canadian/Swiss postal APIs, and more) server-side, and returns normalised address parts that pre-fill the subfields — optionally writing latitude/longitude into a linked geofield or geolocation field. Beyond the address widget it adds a text/string autocomplete widget, a geofield widget with an optional mini map, a country-by-continent widget, two map field formatters, a CKEditor 5 "Address suggestion" toolbar button (token-protected route) for embedding maps in rich text, and a Views Bulk Operations action that backfills coordinates on existing content. New providers are added by dropping a plugin class in `Plugin/AddressProvider/`, and any provider's endpoint can be pointed at a custom proxy API. Its `core_version_requirement` of `^9.2 || ^10 || ^11 || ^12` already covers Drupal 12.

---

- Autocomplete an address field.
- Reduce typos in collected addresses.
- Speed up address entry on mobile.
- Choose a lookup provider per field.
- Use a free, keyless provider (Nominatim, Photon, France Address).
- Use a commercial provider with an API key (Google, Here, Mapbox, TomTom, MapQuest).
- Improve deliverability of postal addresses.
- Insert an address or embed a map in CKEditor 5.
- Autocomplete a plain text or string field.
- Prefill latitude/longitude into a linked geofield or geolocation field.
- Standardise address formats across countries.
- Restrict suggestions to a single country.
- Filter the country select by continent.
- Display a stored address or geofield as an OpenStreetMap/ArcGIS/Mapbox/Here map.
- Point a provider at your own caching proxy endpoint.
- Write a custom address provider plugin.
- Backfill coordinates on existing content with a Views Bulk Operations action.
- Swap providers without changing fields.
- Reduce form abandonment on checkout and registration forms.
- Collect geocodable addresses for mapping.
- Prepare an address field for Drupal 12.
