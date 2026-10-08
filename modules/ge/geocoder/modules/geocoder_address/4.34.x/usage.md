Geocoder Address integrates the Geocoder engine with the contrib Address module, so a structured Address field can be geocoded into coordinates and coordinates can be reverse-geocoded into a properly formatted, country-aware Address field.

---

The Address module stores rich, locale-aware postal addresses (country, locality, administrative area, postal code, etc.). This submodule lets Geocoder read and write those fields. It adds an `Address` Preprocessor and an `AddressField` GeocoderField plugin so an Address field can be chosen as a geocode source or target on the Geocoder Field settings form, and it provides an `AddressGeocodeFormatter` field formatter for display-time geocoding. Its `AddressService` converts an Address value array into a single geocodable string using the correct country address format (via the Address library's format/country/subdivision repositories), and — for reverse geocoding — helps map a geocoding result back into the structured Address components. A `hook_geocoder_address_values_alter` hook lets you adjust the resolved address values before they are written, and it honors the base module's `hook_geocode_country_code_alter`. All configuration happens through Geocoder Field's per-field third-party settings; there is no separate admin screen. It depends on the contrib `address` module and `geocoder_field`. Use it whenever your addresses are stored as Address fields rather than plain text.

---

- Geocode an Address field into coordinates on entity save.
- Reverse-geocode coordinates into a structured Address field.
- Build a single geocodable string from address components.
- Respect each country's address format when geocoding.
- Populate country/locality/postal code from a reverse geocode.
- Use an Address field as a geocode source in Geocoder Field.
- Use an Address field as a reverse-geocode target.
- Geocode Commerce customer/store addresses to map them.
- Keep an Address field and a coordinate field in sync on save.
- Display-time geocode an Address via the address geocode formatter.
- Alter resolved address values before they are saved (hook).
- Correct the country code when writing the Address field.
- Migrate legacy address text into structured Address + coordinates.
- Support multilingual/locale-aware address formatting for geocoding.
- Convert a structured address to lat/lng for proximity search.
- Feed a map from auto-geocoded Address fields.
- Handle international addresses with country-specific subdivisions.
- Normalize address input before sending it to a provider.
- Reverse-geocode a dropped map pin into a full postal address.
- Reduce manual data entry by auto-filling address parts.
