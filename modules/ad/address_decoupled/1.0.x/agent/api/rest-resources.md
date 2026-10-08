<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Decoupled — REST resources

Five `@RestResource` plugins in `src/Plugin/rest/resource/`. All extend `rest`'s `ResourceBase`,
inject the `address_decoupled` service, and log to the `address_decoupled_rest` channel. Responses
are JSON via `ModifiedResourceResponse` / `ResourceResponse` / `JsonResponse`.

## Install & enable
`drush en address_decoupled` (pulls `address` + core `rest`). The five
`config/install/rest.resource.address_decoupled_*.yml` are imported on install, each with
`methods` (GET or POST), `formats: [json]`, `authentication: [cookie]`, `granularity: resource`.
To expose a resource to a role, grant the matching permission at
Admin › People › Permissions under **RESTful Web Services**:
`restful get address_decoupled_countries_list`, `restful get address_decoupled_country_data`,
`restful get address_decoupled_validate_address`, `restful post address_decoupled_save_address`,
`restful get address_decoupled_store_supported_countries`.
Change auth methods/formats by editing the resource config (e.g. add `basic_auth`, `oauth2`).

## Resources

### countries_list — GET `/address-decoupled/api/countries-list/{country_codes}`
`AddressDecoupledCountriesListResource::get(string $country_codes = NULL)`. `{country_codes}` is an
optional JSON object of ISO codes (`{"AU":"AU","UA":"UA"}`), `Json::decode()`d then cast to array;
empty → all countries. Uses the current request language for localized names. Returns an ISO-keyed
map of `{countryCode,name,threeLetterCode,numericCode,currencyCode,locale}`, or
`{message:"There are no countries to list."}`. `routes()` adds a `country_codes = NULL` default so
the trailing arg is optional.

### country_data — GET `/address-decoupled/api/country-data/{country_code}`
`AddressDecoupledCountryDataResource::get(string $country_code)`. Returns the address format for one
country: `used_fields`, `subdivision_fields`, `required_fields`, `uppercase_fields`,
`postal_code_type`, `postal_code_pattern`, `postal_code_prefix`, `field_labels`, and a nested
`subdivisions` tree (administrative area → locality → dependent locality). Unknown code → 400
`{message:"There is no such country code."}`.

### validate_address — GET `/address-decoupled/api/validate-address/{address_data}`
`AddressDecoupledValidateAddressResource::get(string $address_data)`. `{address_data}` is a JSON
address object, `Json::decode()`d and validated by the service against the CommerceGuys
`AddressFormatConstraint`. No violations → 200 `{message:"The given address is a valid one."}`;
otherwise 400 with a `{field: message}` map of violations.

### save_address — POST `/address-decoupled/api/save-address/{address_data}/{entity_id}/{entity_type}/{field}`
`AddressDecoupledSaveAddressResource::post(string $address_data, int $entity_id, string $entity_type, string $field)`.
`{address_data}` is a JSON address object; `{entity_id}`, `{entity_type}`, `{field}` name the target
entity and its address field. Delegates to `AddressDecoupled::saveAddress()`, which loads the entity,
maps camelCase address keys to Drupal address subfield keys (`country_code`, `given_name`, …), sets
the field and saves. Success → `{message:"The address was saved with success"}`; failure/exception →
400 `{message:"Something went wrong. Could not save the address."}`. Cookie-auth POSTs require the
core `X-CSRF-Token` header.

### store_supported_countries — GET `/address-decoupled/api/store/supported-countries/{store}`
`AddressDecoupledStoreSupportedCountriesResource::get(int $store = NULL)`. Loads a Commerce
`commerce_store` by id and returns `{shipping_countries, billing_countries}` as full country objects
(via `getStoreSupportedCountries()`). Non-numeric/empty id or missing store → a `message` payload.
NOTE: this resource lives in the base module but the service method it calls needs
`commerce_store`; the `address_decoupled_commerce` submodule provides a store-id-less variant
resolving the current store — see the submodule docs.

## Notes for agents
- Only actual `address`-type fields are meaningful save targets; the service maps to address
  subfield keys and relies on entity save to reject others.
- All list/format/validate endpoints return public reference data (countries, subdivisions,
  formats) — safe to cache heavily in the client.
