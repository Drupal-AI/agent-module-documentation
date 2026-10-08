<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Decoupled (address_decoupled) — agent index

REST/JSON API layer over the core **Address** module. Exposes country lists, country
address-format metadata (fields + subdivisions), address validation, and address-save-to-entity
to a headless/decoupled front end. Version 1.0.7. Core `^9 || ^10 || ^11`.

## Dependencies
- Modules: `address`, `rest` (core). Composer: `drupal/address:^1.12 || ^2.0`.
- Submodule: `address_decoupled_commerce` (needs `commerce`, `commerce_store`) — see
  `../../modules/address_decoupled_commerce/1.0.x/agent/start.md`.
- No config schema, no permissions.yml, no drush commands, no hooks, no plugin types of its own.

## Service
- `address_decoupled` → `Drupal\address_decoupled\Services\AddressDecoupled`
  (implements `AddressDecoupledInterface`). Wraps CommerceGuys `country_repository`,
  `address_format_repository`, `subdivision_repository` + `entity_type.manager`.
  Methods: `getCountriesList()`, `getCountryData()`, `validateAddress()`, `saveAddress()`,
  `getStoreSupportedCountries()`.

## REST resources (all `Plugin/rest/resource/`, channel `address_decoupled_rest`)
| id / permission suffix | method | path | class |
|---|---|---|---|
| `address_decoupled_countries_list` | GET | `/address-decoupled/api/countries-list/{country_codes}` | `AddressDecoupledCountriesListResource` |
| `address_decoupled_country_data` | GET | `/address-decoupled/api/country-data/{country_code}` | `AddressDecoupledCountryDataResource` |
| `address_decoupled_validate_address` | GET | `/address-decoupled/api/validate-address/{address_data}` | `AddressDecoupledValidateAddressResource` |
| `address_decoupled_save_address` | POST | `/address-decoupled/api/save-address/{address_data}/{entity_id}/{entity_type}/{field}` | `AddressDecoupledSaveAddressResource` |
| `address_decoupled_store_supported_countries` | GET | `/address-decoupled/api/store/supported-countries/{store}` | `AddressDecoupledStoreSupportedCountriesResource` |

Each resource ships a `config/install/rest.resource.*.yml` enabling `GET`/`POST`, `json` format,
`cookie` auth. Access is the core-`rest` auto-generated `restful <method> <id>` permission
(RESTful Web Services permission group) — configure roles after install.

## Solution docs
- API surface & config: `api/rest-resources.md`
- The wrapper service: `services/address-decoupled.md`
