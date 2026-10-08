Address Indonesia extends the Address module with Indonesian provinces, regencies/cities and districts plus a matching multi-level address format.

---

Address Indonesia (`address_id`) registers a single event subscriber, `IndonesiaEventSubscriber`, that listens to the Address module's `AddressEvents::ADDRESS_FORMAT` and `AddressEvents::SUBDIVISIONS` events and only acts when the country code is `ID`. For the address format it sets `subdivision_depth` to 3, defines a custom format string (name, address lines, administrative area, locality, dependent locality + postal code) and marks locality and dependentLocality as required. For subdivisions it ships a large, hard-coded three-level hierarchy — provinces (with ISO codes such as `ID-BA`, `ID-JK`), then regencies/cities, then districts (kecamatan) — returned directly from PHP arrays. This gives Indonesian address forms proper cascading province → city/regency → district dropdowns, which are commonly used with Drupal Commerce shipping-cost integrations (for example Commerce RajaOngkir). There is no configuration, no routes, no permissions and no external service; enabling the module is the entire setup.

---

- Provide cascading province → regency/city → district selects on Indonesian address fields.
- Give Indonesian addresses the correct field order and format for display and entry.
- Require locality and dependent-locality entry for `ID` addresses.
- Populate the administrative-area dropdown with all Indonesian provinces and their ISO codes.
- Feed accurate Indonesian subdivisions to Drupal Commerce checkout addresses.
- Support shipping-cost calculators (e.g. Commerce RajaOngkir) that key on province/city/district.
- Standardise Indonesian address data captured across a site.
- Let editors pick a regency/city scoped to the chosen province.
- Let editors pick a district (kecamatan) scoped to the chosen regency/city.
- Collect Indonesian customer or member addresses for a directory or CRM sync.
- Validate that Indonesian addresses include the required locality levels.
- Localise the address widget for Indonesian storefronts without custom code.
- Improve address data quality by constraining entry to known subdivisions.
- Render Indonesian addresses in a locally-conventional layout on entity displays.
- Provide subdivision data offline (bundled in code) with no API dependency.
- Support multi-country sites where Indonesia needs richer subdivisions than the core library.
- Back address autocomplete or filtering UIs that rely on structured subdivisions.
- Seed test/demo content with realistic Indonesian addresses.
- Enable region-based reporting on Indonesian orders by province/city/district.
- Serve as a reference implementation for a country-specific Address subdivision subscriber.
