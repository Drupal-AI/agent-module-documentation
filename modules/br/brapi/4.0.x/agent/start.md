<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plant Breeding API (brapi) — agent index

BrAPI **server** for Drupal: publishes plant-breeding data over REST at `/brapi/v1` and `/brapi/v2`, mapping BrAPI data types/fields to Drupal entities/fields. Version 4.0.0-beta5. Core `^9 || ^10 || ^11`. Package `Tripal`.

- **Dependency:** core `datetime`; Composer lib `galbar/jsonpath` (`^2||^3`).
- **Spec support:** BrAPI v1 (1.2, 1.3) and v2 (2.0, 2.1), driven by JSON files in `definitions/` (loaded by `brapi_get_definition()` in `brapi.module`; OpenAPI sources in `versions/`).

## Provides

- **Config entity `brapidatatype`** (`src/Entity/BrapiDatatype.php`) — maps a BrAPI data type to a Drupal entity type/bundle and each BrAPI field to a Drupal field, a JSONPath `_custom` value, or a `_submapping`. Runs the data queries (`getBrapiData`/`saveBrapiData`/`deleteBrapiData`). Access handler `BrapiDatatypeAccessController`.
- **Content entity `brapi_token`** (`src/Entity/BrapiToken.php`) — per-user bearer access token (random 16-byte hex, expiring). Helpers `getUserToken()`, `getUserTokens()`, `purgeExpiredTokens()`.
- **Entity `brapi_list`** (`src/Entity/BrapiList.php`) — backing store for BrAPI list objects.
- **Controller** `BrapiController` (`src/Controller/BrapiController.php`) — the single `brapiCall()` dispatcher plus landing/doc/token pages and per-call processors (query/post/put/delete/search, v1 login/logout/calls, v2 serverinfo).
- **Dynamic routes** `BrapiRoutes::routes()` (`src/Routing/BrapiRoutes.php`) — one route per enabled call, all `_access: TRUE` (access enforced inside the controller).
- **Event subscriber** `BrapiSubscriber` (`src/EventSubscriber/BrapiSubscriber.php`) — REQUEST: logs in a client from its bearer token; TERMINATE: runs deferred searches via `BrapiAsyncSearch`.
- **Service** `brapi.async_search` (`BrapiAsyncSearch`) and a `cache.brapi_search` cache bin.
- **Permissions** (`brapi.permissions.yml`): `use brapi`, `edit brapi content`, `use restricted brapi`, `administer brapi`.
- **Admin forms**: settings (`BrapiAdminForm`), data types (`BrapiDataTypesForm`, `BrapiDatatype*Form`), calls (`BrapiCallsForm`).
- **Alter hooks** (`brapi.api.php`): `hook_brapi_call_alter`, `hook_brapi_call_CALL_SIGNATURE[_result]_alter`, `hook_brapi_definition_alter`, `hook_brapi_DATATYPE_save_alter`, etc.

## Solution docs

- [agent/api/rest-endpoints.md](api/rest-endpoints.md) — routes, the `brapiCall()` dispatch, access/permission model, token auth, calls config, search/deferred, POST/PUT/DELETE.
- [agent/config/settings.md](config/settings.md) — install/enable, `brapi.settings` config keys, definitions, admin routes & permissions.
- [agent/entities/mappings-and-tokens.md](entities/mappings-and-tokens.md) — `brapidatatype` mapping model & data queries; `brapi_token` lifecycle.
