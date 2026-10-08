<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nova Poshta API clients, routes and tables

Two classes in `src/API/`:

## `NovaPoshtaApi2` (raw transport)

Ported v2.0 client (`@author lis-dev`, MIT header). `request($model, $method, $params)` builds
`{apiKey, modelName, calledMethod, language, methodProperties}`, `json_encode`s it and POSTs to
`https://api.novaposhta.ua/v2.0/json/` (or `/xml/`). Connection type `curl` (default) or
`file_get_contents`; `prepare()` json-decodes to an array and can throw on `errors` when
`throwErrors`. Transport failures return a normalized `{success:false, errors:[...]}` via
`transportError()`.

Method families (thin wrappers over `request()`):
- **Address**: `getCities`, `getWarehouses`/`getWarehouse`, `getStreet`, `getAreas`/`getArea`,
  `searchSettlements`, `searchSettlementStreets`. `getArea` reads a bundled
  `NovaPoshtaApi2Areas.php` list.
- **Counterparty / ContactPerson**: `getCounterparties`, `getCounterpartyContactPersons`,
  `getCounterpartyAddresses`, `saveCounterparty`, `saveContactPerson`, `cloneLoyaltyCounterpartySender`.
- **InternetDocument** (waybills): `getDocumentPrice`, `getDocumentDeliveryDate`, `getDocumentList`,
  `getDocument`, `save`/`saveInternetDocumentNew`, `update`, `delete`, `newInternetDocument`
  (composes sender+recipient+params), `printDocument`/`printMarkings`, `generateReport`.
- **Tracking**: `getTrackingDocument` (`TrackingDocument.getStatusDocuments`), `documentsTracking`.
- **Common** (via `__call` whitelist): `getTypesOfCounterparties`, `getCargoTypes`,
  `getPaymentForms`, `getTypesOfPayers`, `getOwnershipFormsList`, `getTiresWheelsList`, etc.

## `NovaPoshtaAPI` (store facade)

Constructed with an API key (defaults to `novaposhta.settings:config.api_key`); builds one
`NovaPoshtaApi2` with the key and one keyless (`api2`) for public reference lookups. Adds:
- **DB reference reads**: `getRegions()`, `getCitis($params)` from `novaposhta_lists`; `getPoints()`
  (warehouses) and `getCity()` from the API with file cache.
- **File cache**: `getCache`/`setCache`/`getFileName` store per-call JSON under
  `public://settings/novaposhta/<week_m_Y>/` via `NovaPoshta::variableGet/variableSet`; cache is
  bypassed unless the request key equals the configured key.
- **Costing**: `getCost(...)` → `getDocumentPrice`, optionally adding `RedeliveryCalculate` (COD).
- **Waybills**: `internetDocument*`, `updateDocumentList()` (truncates + reloads `novaposhta_en`),
  `insertEn()` (merges a waybill row, `all_info` = `encodeStoredData`), `getStatusDocuments()`
  (tracks, updates rows, follows redirect/forwarding chains), `getPrintLink($enNum)` (builds a
  `my.novaposhta.ua/orders/print.../apiKey/...` PDF link per `novaposhta.en.settings:config.print`).
- **Settlement search**: `searchSettlements`, `getCityRefByName`, `searchSettlementStreets`.

## Routes → controller

`AutocompleteController` (`src/Controller/AutocompleteController.php`) backs the two public GET
autocomplete routes. Both are `_access: 'TRUE'` (reachable by anonymous shoppers at checkout):
- `cities()` reads `?q=`, calls `NovaPoshtaAPI::searchSettlements()`, returns
  `[{value,label}]` JSON of `Present` strings.
- `streets()` reads `?q=` + `{ref}` (settlement ref), calls `searchSettlementStreets()`.
Only search strings reach the API (the endpoint URL is fixed to `api.novaposhta.ua`).

## Tables (`novaposhta.install`)

- `novaposhta` — chosen branch per `{entity, entity_id}` (address text + serialized `data`).
- `novaposhta_en` — waybills: `ref`, `en_num`, `new_en_num`, cost/weight/status/dates, `all_info`
  blob (JSON).
- `novaposhta_en_orders` — Basket `order_id` ↔ `en_num`.
- `novaposhta_lists` — `area`/`city` reference (`ref_id`, `parent_id`, `type`, `name`).

All DB access uses the query builder (`select`/`merge`/`update`/`delete` with `condition()` and
`fields()`), so parameters are bound. `encodeStoredData`/`decodeStoredData` use JSON (unserialize
fallback uses `allowed_classes => FALSE`).
