<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Decoupled — the `address_decoupled` service

`Drupal\address_decoupled\Services\AddressDecoupled` implements `AddressDecoupledInterface`
(both in `src/Services/`). Registered in `address_decoupled.services.yml` with args
`@address.country_repository`, `@address.address_format_repository`,
`@address.subdivision_repository`, `@entity_type.manager`. Uses `LoggerChannelTrait`. This is the
single business-logic layer the five REST resources delegate to; you can also call it from custom
PHP: `\Drupal::service('address_decoupled')`.

## Methods

### `getCountriesList(array $iso_codes = [], string $locale = null): array`
`countryRepository->getAll($locale)` → maps each `Country` to
`{countryCode,name,threeLetterCode,numericCode,currencyCode,locale}`, keyed by ISO code. If
`$iso_codes` is non-empty, filters the result to those keys (silently skipping unknown codes).

### `getCountryData(string $iso_code): array`
`addressFormatRepository->get($iso_code)` for the format; returns `[]` if the country is unknown.
Collects `used_fields`, `subdivision_fields` (`getUsedSubdivisionFields()`), `required_fields`,
`uppercase_fields`, `postal_code_type/pattern/prefix`, and `field_labels`
(`Drupal\address\LabelHelper::getFieldLabels()`). Builds a `subdivisions` tree by walking
`subdivisionRepository->getAll([$iso_code])` up to three levels (administrative area → locality →
dependent locality) via the private `parseDivisionChild()` helper (returns
`{countryCode,code,localCode,name,localName,locale}`).

### `validateAddress(array $address_data): array`
Builds a CommerceGuys `Address` by applying each present key through its `with*` method
(`countryCode`→`withCountryCode`, plus all `AddressField::*`), then validates with a Symfony
validator against `AddressFormatConstraint`. Returns `{propertyPath: message}` for each violation
(empty array = valid).

### `saveAddress(array $address_data, int $entity_id, string $entity_type, string $field): bool`
Loads `entityTypeManager->getStorage($entity_type)->load($entity_id)`. Returns FALSE if the entity
or `$field` is missing. Maps camelCase address keys to Drupal address subfield keys
(`country_code`, `given_name`, `additional_name`, `family_name`, `organization`, `address_line1/2`,
`postal_code`, `sorting_code`, `dependent_locality`, `locality`, `administrative_area`), then
`$entity->set($field, $data)->save()` inside a try/catch (exception → FALSE).

### `getStoreSupportedCountries(int $store_id, string $locale = null): array`
Loads a `commerce_store` (returns `[]` if not a `StoreInterface`). Reads `shipping_countries` /
`billing_countries` field values and expands each via `getCountriesList()`. Returns
`{shipping_countries, billing_countries}`. Because it references `commerce_store`, this method only
works when Commerce is installed.

## Operating notes
- The service performs no output rendering (returns arrays serialized to JSON by the resources) —
  no XSS surface here.
- It uses repository/entity APIs only, no raw SQL and no outbound HTTP.
- Errors from the resources are logged to the `address_decoupled_rest` channel (dblog).
