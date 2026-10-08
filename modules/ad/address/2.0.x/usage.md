Address provides a compound field type for storing, validating and displaying international postal addresses, driven by Google's i18n address data through the commerceguys/addressing library.

---

Address adds `address`, `address_country` and `address_zone` field types (plus matching widgets and formatters) so any entity can capture a full postal address. Each country's form dynamically shows the correct fields and labels — for example "State/ZIP" in the US versus "County/Postcode" in the UK — because the layout, required fields and subdivision lists come from the commerceguys/addressing dataset. Fields are validated against country-specific address formats and postal-code patterns, and rendered with the country's own ordering rules. Per-field settings let you restrict the list of available countries, override which properties are hidden/optional/required, and pin the address language. Programmatic access is provided through repository services for address formats, countries and subdivisions, plus a postal label formatter. Site builders configure everything through the standard Field UI when adding an Address field; there is no bespoke permission set or Drush command. Developers extend behaviour by subscribing to three events that alter address formats, the available country list, and custom subdivisions. It is the D8+ successor to the addressfield module and the foundation for Drupal Commerce addresses.

---

- Add a postal address field to a content type (e.g. an "Event venue" address).
- Store a customer's shipping and billing addresses on a Commerce order or profile.
- Collect an organisation's mailing address on a webform-style entity.
- Capture user home addresses on the user profile entity.
- Display an address correctly formatted for its own country's conventions.
- Show US-style "State / ZIP code" labels but UK-style "County / Postcode" automatically.
- Validate that a postal code matches the selected country's pattern.
- Restrict an address field to a subset of allowed countries (e.g. EU only).
- Force certain properties (name, organization) to be hidden, optional or required per field.
- Pin an address field to a single language so formats don't shift with the UI language.
- Render a plain, template-overridable address for print or postal labels.
- Generate a postal label string via the postal label formatter service.
- Look up the address format (field layout) for any country in custom code.
- Fetch the list of countries or a country name from the country repository.
- Retrieve subdivisions (states, provinces, cities) for cascading address dropdowns.
- Provide a standalone `#type => 'address'` form element in a custom form.
- Provide a country-only field with the `address_country` field type.
- Define a geographic zone (territory set) with the `address_zone` field type.
- Add custom subdivisions for a country not fully covered by the dataset (e.g. extra GB regions).
- Alter a country's address format definition before it is used.
- Dynamically change which countries are available on a field via an event subscriber.
- Sort, filter or display address components (country, subdivision) in Views.
- Migrate legacy addressfield / Drupal 7 address data into the new field type.
- Import addresses from a feed using the Feeds targets.
- Display the country name instead of the two-letter code in a Views column.
- Build multi-country checkout or registration forms with correct local formats.
- Theme address output per entity type, bundle, view mode or field via theme suggestions.
