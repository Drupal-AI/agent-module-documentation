# Address integration

No admin page — configure geocoding on the field itself via **geocoder_field**'s third-party
settings (Field UI → your field → Edit); see the `geocoder_field` submodule's
`configure/field-geocoding.md`. This module supplies the Address-aware plugins/service.

## Provides
| Piece | Purpose |
|---|---|
| Preprocessor `Address` | Turn an Address field value into a single geocodable string. |
| GeocoderField `AddressField` | Lets an Address field be picked as geocode source/target. |
| Formatter `AddressGeocodeFormatter` | Display-time geocoding of an Address field. |
| Service `geocoder_address.address_service` (`AddressService`) | `addressArrayToGeoString(array $values)` builds the string using the country's address format; `getFormatter($langcode, $countrycode, $formatter)` returns an address formatter. |

## Typical setups
- **Address → coordinates:** on a coordinate/Geofield field, method `geocode`, source = the
  Address field, choosing providers/dumper.
- **coordinates → Address:** on the Address field, method `reverse_geocode`, source = a
  coordinate/Geofield field. The resolved result is mapped back into Address components
  (country, locality, postal code, …).

## Hook
`hook_geocoder_address_values_alter(array &$values)` (`geocoder_address.api.php`) — adjust the
structured address values before they are written to the Address field. Country resolution also
honors the base module's `hook_geocode_country_code_alter`.
