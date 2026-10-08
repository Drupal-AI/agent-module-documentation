<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Decoupled Commerce (address_decoupled_commerce) — agent index

Submodule of **Address Decoupled**. Adds one Commerce-aware REST resource returning the **current**
store's supported shipping/billing countries — no store id in the path. Version 1.0.7.
Core `^9 || ^10 || ^11`.

## Dependencies
- Modules: `address`, `rest`, `commerce`, `commerce_store`, plus parent `address_decoupled`
  (uses its `address_decoupled` service). No config schema / permissions.yml / drush of its own.

## What it provides
- `src/Plugin/rest/resource/AddressDecoupledStoreSupportedCountriesResource.php`
  (`Drupal\address_decoupled_commerce\Plugin\rest\resource`), `@RestResource` **id
  `address_decoupled_store_supported_countries`** (same id as the base module's resource — this is
  the Commerce override), canonical path `/address-decoupled/api/store/supported-countries`
  (no `{store}` arg). GET, `json`, `cookie` auth (`config/install/rest.resource.*.yml`).
- Injects `commerce_store.current_store` (`CurrentStoreInterface`) + the parent
  `address_decoupled` service. `get()` resolves `currentStore->getStore()`, reads
  `shipping_countries`/`billing_countries` field values, expands them via
  `AddressDecoupled::getCountriesList()`, and returns `{shipping_countries, billing_countries}` with
  cacheable dependencies on the store entity and `url`.

## Access
Core-`rest` auto-generated permission `restful get address_decoupled_store_supported_countries`
(RESTful Web Services group). Returns public store reference data (country lists), no PII.

## Solution docs
- API surface: `api/store-supported-countries.md`
- Parent module: `../../../1.0.x/agent/start.md`
