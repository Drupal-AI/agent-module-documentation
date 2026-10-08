Address Decoupled exposes the Drupal Address module's country, subdivision, address-format, validation and address-save logic to a headless/decoupled front end through five JSON REST resources.

---

Address Decoupled is a thin API layer over the core `address` module and the underlying CommerceGuys addressing library. A single service (`address_decoupled`) wraps the country repository, address-format repository, subdivision repository and the entity type manager, and five `rest` resource plugins publish that service under `/address-decoupled/api/*`. A decoupled client (React, Vue, mobile app, etc.) can list countries, fetch a country's full address-format metadata (used/required/uppercase fields, postal-code pattern, field labels, and nested subdivisions), validate an address against a country's format, and write an address array back onto an existing entity's address field. Each resource is a standard Drupal REST resource: it returns `json`, ships with `cookie` authentication in its default install config, and is gated by the per-resource `restful <method> <id>` permission that the core `rest` module generates automatically. An optional `address_decoupled_commerce` submodule replaces the store-id-in-path resource with one that resolves the current Commerce store automatically. All errors are logged to the `address_decoupled_rest` logger channel (dblog).

---

- Build a country dropdown in a decoupled checkout by calling `GET /address-decoupled/api/countries-list` for the full ISO-keyed country list (code, name, three-letter/numeric code, currency, locale).
- Fetch only a subset of countries by passing a JSON map, e.g. `GET /address-decoupled/api/countries-list/{"AU":"AU","UA":"UA"}`, to limit the picker to supported destinations.
- Drive a dynamic address form: `GET /address-decoupled/api/country-data/AU` returns `used_fields`, `required_fields`, `uppercase_fields`, `subdivision_fields`, postal-code type/pattern/prefix and localized `field_labels`.
- Render country-specific field labels (e.g. "State" vs "Province", "Suburb" vs "City") from the `field_labels` map instead of hard-coding them in the front end.
- Populate a state/province select from the `subdivisions` tree returned by the country-data endpoint, including nested localities and dependent localities where a country defines them.
- Show or hide the postal-code field and apply client-side validation using the returned `postal_code_pattern` and `postal_code_type`.
- Validate a user-entered address before submit with `GET /address-decoupled/api/validate-address/{address_json}` and surface any per-field violation messages returned on a 400.
- Localize country names and labels automatically — resources read the current request language, so sending an Accept-Language / interface-language context returns translated names.
- Persist a collected address onto a node's address field via `POST /address-decoupled/api/save-address/{address_json}/{entity_id}/node/field_address`.
- Save a customer address onto a user or profile entity's address field from a headless account/settings screen.
- Integrate with any content entity that has an address field by passing the target `entity_type` and `field` machine name in the save-address path.
- Power a "supported shipping/billing countries" widget: `GET /address-decoupled/api/store/supported-countries/{store_id}` returns the Commerce store's `shipping_countries` and `billing_countries` as full country objects.
- Use the Commerce submodule's `GET /address-decoupled/api/store/supported-countries` (no id) to resolve the current store automatically in a multi-store / multi-domain setup.
- Feed a JAMstack / static-site build with country and subdivision reference data at build time.
- Reuse Drupal's canonical addressing dataset (CommerceGuys addressing) in a mobile app without shipping the dataset in the app bundle.
- Keep address validation rules server-side and consistent between the Drupal back office and the decoupled client.
- Restrict which roles can reach each endpoint by granting the matching "Access GET/POST on Address decoupled - … resource" permission under Admin › People › Permissions (RESTful Web Services group).
- Switch a resource's authentication (cookie / basic_auth / oauth2) or add formats by editing the corresponding `rest.resource.address_decoupled_*` config.
- Troubleshoot API failures via Reports › Recent log messages, filtering on the `address_decoupled_rest` channel.
- Prototype an address microservice quickly, since every endpoint is a GET (except save-address which is POST) returning plain JSON.
- Combine countries-list + country-data to lazy-load subdivision data only for the country the user actually selects, keeping initial payloads small.
