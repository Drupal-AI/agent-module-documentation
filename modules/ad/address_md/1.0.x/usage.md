Address for Republic of Moldova extends the Address module with Moldova's districts and localities plus a matching Moldovan address format.

---

Address for Rep. of Moldova (`address_md`) registers one event subscriber, `AddressEventsSubscriber`, on the Address module's `AddressEvents::ADDRESS_FORMAT` and `AddressEvents::SUBDIVISIONS` events, acting only when the country code is `MD`. For the format it sets a Moldova-specific format string (name, organization, administrative area + locality, dependent locality, postal code, address lines), a `subdivision_depth` of 2, and an administrative-area type of DISTRICT. Unlike the Indonesia and Luxembourg modules, the subdivision data is not inline: the subscriber computes the Addressing library's group key for the requested parents (`hash('tiger128,3', …)`), loads the matching bundled file from the module's `json/` directory with `file_get_contents`, `json_decode`s it, and caches the result permanently in `cache.data` under the `subdivisions` tag. The `json/` directory ships the top-level `MD.json` (all districts, e.g. `MD-CU` Chișinău) plus one file per district group holding that district's localities. There is no configuration, no routes, no permissions and no external network call — enabling the module is the whole setup.

---

- Provide a district → locality cascading select on Moldovan address fields.
- Label the administrative-area level as "District" for `MD` addresses.
- Apply a Moldova-conventional address layout for entry and display.
- Populate the district dropdown with all Moldovan districts and their ISO codes.
- Let editors choose a locality scoped to the selected district.
- Standardise Moldovan address data across the site.
- Localise Address forms for Moldovan storefronts or member directories.
- Feed structured Moldovan subdivisions into Drupal Commerce checkout.
- Improve data quality by constraining entry to known districts/localities.
- Capture Moldovan customer or contact addresses in a consistent structure.
- Render Moldovan addresses with correct administrative divisions on displays.
- Serve subdivision data offline from bundled JSON with no API dependency.
- Cache subdivision lookups permanently for fast repeated rendering.
- Support multi-country sites needing richer MD subdivisions than the base library offers.
- Back autocomplete or filtering UIs that rely on district/locality structure.
- Seed test/demo content with realistic Moldovan addresses.
- Enable region-based reporting on Moldovan records by district.
- Serve as a reference implementation for a JSON-backed Address subdivision subscriber.
