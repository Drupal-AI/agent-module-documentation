<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Decoupled Commerce — store supported-countries resource

One `@RestResource` plugin:
`src/Plugin/rest/resource/AddressDecoupledStoreSupportedCountriesResource.php`
(namespace `Drupal\address_decoupled_commerce\Plugin\rest\resource`).

## Install & enable
`drush en address_decoupled_commerce` (requires parent `address_decoupled` + `commerce`,
`commerce_store`). Its `config/install/rest.resource.address_decoupled_store_supported_countries.yml`
enables `GET`, `json`, `cookie` auth, `granularity: resource`, and depends on modules
`address_decoupled, serialization, user, commerce, commerce_store`. Grant
`restful get address_decoupled_store_supported_countries` to the intended role(s) under
Admin › People › Permissions (RESTful Web Services).

## Endpoint
`GET /address-decoupled/api/store/supported-countries` — no path arguments.

`get()`:
1. `currentStore->getStore()` (Commerce `commerce_store.current_store`). Not a `StoreInterface` →
   `{message:"There are no any supported countries for this store."}`.
2. If the store has `shipping_countries`, `array_column(..., 'value')` → country codes →
   `AddressDecoupled::getCountriesList()` (parent service).
3. Same for `billing_countries`.
4. Returns a `ResourceResponse` of `{shipping_countries, billing_countries}` (each an ISO-keyed map
   of full country objects), with `addCacheableDependency($store_object)` and
   `addCacheableDependency('url')` (multi-domain safe).

## Relationship to the base module resource
This resource re-uses the **same plugin id** `address_decoupled_store_supported_countries` as the
base module's `Drupal\address_decoupled\...\AddressDecoupledStoreSupportedCountriesResource`
(which takes a `{store}` id and has its own install config in the base module). Enabling this
submodule provides the id-less, current-store variant; be aware both modules define the id, so
which class/route resolves depends on plugin discovery — in practice run one or the other for the
supported-countries feature.

## Notes for agents
- Output is public store reference data (allowed shipping/billing countries) — no customer/order
  PII, safe to cache. No writes, no external HTTP, no SQL.
