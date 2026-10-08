Address Country Unknown adds Address-field widgets and formatters that let you enter, store and display an address even when the country is left empty/unknown.

---

The standard Address module treats the country as mandatory: clearing the country hides and wipes every other address field, and validation is driven by the selected country's official format. Address Country Unknown works around that by overriding the core `AddressItem` field type, the address form element, the default widget and the default/plain formatters. When a country code is present the module defers entirely to Address's normal behaviour; when the country is empty it substitutes a generic fallback address format (a synthetic `NONE` country format) so the name, organization, street, postal-code, locality, district and administrative-area inputs still render, save and display. It also stops empty-country address values from being reported as "empty", so migrated or partial data is preserved rather than silently cleared. The custom widget and formatters are designed to be used together — mixing them with the stock Address widget/formatter produces errors — and the project explicitly warns against using it with Drupal Commerce, which relies on complete addresses.

---

- Record a mailing address when the country is genuinely unknown or not yet known.
- Store a partial address (street, city, postcode) without forcing a country selection.
- Preserve migrated legacy address data that lacks a `country_code` instead of having it cleared.
- Let editors leave the country blank on an Address field while keeping all other inputs visible.
- Display a country-less address on the entity view using the generic fallback format.
- Show a plain-text rendering of a country-less address (no country line) via the plain formatter.
- Keep normal per-country address behaviour intact for any address that does have a country.
- Capture "information only" addresses that do not need to be postally valid.
- Avoid Address's automatic hiding of dependent fields when no country is chosen.
- Provide a generic address form for regions/territories not well modelled by a single country.
- Enter historical addresses whose country no longer exists or is ambiguous.
- Collect addresses in data-entry workflows where the country is filled in later.
- Skip the `AddressFormatConstraint`/`CountryConstraint` validation for empty-country values.
- Treat an Address field as non-empty when only non-country parts are filled in.
- Use the fallback format's generic labels (state/city/district/postal) for uncoded addresses.
- Configure the "Address (with empty / unknown country)" widget on an entity form display.
- Configure the matching default or plain "empty / unknown country" formatter on a view display.
- Support content types where addresses are reference notes rather than shippable destinations.
- Retain address text for reporting/search even when the country dimension is missing.
- Give developers a drop-in override of Address's strict country requirement on a specific project.
