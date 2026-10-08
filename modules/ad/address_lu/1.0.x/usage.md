Address for Luxembourg extends the Address module with Luxembourg's cantons and their localities plus a matching Luxembourg address format.

---

Address for Luxembourg (`address_lu`) registers one event subscriber, `AddressEventsSubscriber`, on the Address module's `AddressEvents::ADDRESS_FORMAT` and `AddressEvents::SUBDIVISIONS` events, acting only when the country code is `LU`. For the format it sets a Luxembourg-specific format string (organization, name, administrative area + locality, postal code, address lines), a `subdivision_depth` of 2, marks the administrative area and locality as required, and sets the administrative-area type to CANTON. For subdivisions it returns a hard-coded two-level hierarchy: the 12 Luxembourg cantons (Capellen, Clervaux, Diekirch, Echternach, Esch-sur-Alzette, Grevenmacher, Luxembourg, Mersch, Redange, Remich, Vianden, Wiltz — each with an ISO code such as `LU-CA`), and under each canton its list of localities. All data is defined inline in PHP arrays. There is no configuration, no routes, no permissions and no external service — enabling the module is the whole setup.

---

- Provide a canton → locality cascading select on Luxembourg address fields.
- Label the administrative-area level as "Canton" for `LU` addresses.
- Apply a Luxembourg-conventional address layout for entry and display.
- Require canton and locality on Luxembourg addresses.
- Populate the canton dropdown with all 12 cantons and their ISO codes.
- Let editors choose a locality scoped to the selected canton.
- Standardise Luxembourg address data across the site.
- Localise Address forms for Luxembourg storefronts or member directories.
- Feed structured Luxembourg subdivisions into Drupal Commerce checkout.
- Improve data quality by constraining entry to known cantons/localities.
- Capture Luxembourg customer or contact addresses in a consistent structure.
- Render Luxembourg addresses with the correct administrative divisions on displays.
- Provide subdivision data offline (bundled in code) with no API dependency.
- Support multi-country sites needing richer LU subdivisions than the base library offers.
- Back autocomplete or filtering UIs that rely on canton/locality structure.
- Seed test/demo content with realistic Luxembourg addresses.
- Enable region-based reporting on Luxembourg records by canton.
- Serve as a reference implementation for a country-specific Address subscriber.
