<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA: Google (eca_google) — agent index

Base module of a suite bridging **ECA** (Event-Condition-Action) to **Google APIs**. Package `ECA`.
Provides **no ECA plugins itself** — it supplies the shared authentication/service-resolution layer
that the service submodules build on. Depends on `eca` and `google_api_client`. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.0. No composer.json (deps come via the two module dependencies).

- **The `eca_google.google_api` service, the auth-config trait, and the `auth_type:client_id`
  format** → [api/google-api-service.md](api/google-api-service.md)

## What it actually is (from source)

- One service: `eca_google.google_api` → `Drupal\eca_google\GoogleApiService`
  (`src/GoogleApiService.php`), constructed with `google_api_client.client`,
  `google_api_service_client.client`, `entity_type.manager`, `logger.factory` (channel `eca_google`).
- One trait: `GoogleAuthActionConfigTrait` (`src/GoogleAuthActionConfigTrait.php`) — adds the required
  "Google API Client" `select` (`auth_client_id`) to an action form via `getClientOptions()`, plus
  `validateApiClientId()`.
- **No routes, no permissions.yml, no config schema, no hooks, no Drush, no config/install** in the
  base module. All those (and the actual ECA actions) live in the submodule.

## Authentication model

- Credentials are **not** stored here — `google_api_client` (and its service-account sibling) own the
  OAuth2 / Service Account entities. `GoogleApiService::getService($service_name, $auth_type,
  $client_id)` loads the entity and returns the google-api-php-client service object (e.g.
  `Google\Service\Sheets`), or NULL on failure (logged).
- Actions store `auth_client_id` as `"auth_type:client_id"`; `auth_type` ∈ `api_client` (OAuth2) |
  `service_account`. `parseAuthClientId()` splits it; `getClientOptions()` builds the select options
  keyed `type:id`.

## Submodules

- **ECA: Google Sheets** (`eca_google_sheets`) — 7 Google Sheets ECA actions. Documented at
  [../modules/eca_google_sheets/1.0.x/agent/start.md](../modules/eca_google_sheets/1.0.x/agent/start.md).

## Install

Enable `google_api_client`, configure an OAuth2 API client and/or Service Account in Google Cloud
Console and at `/admin/config/services/google_api_client` (or `/google_api_service_client`), enable
the Google APIs you need, then enable `eca_google` and the matching service submodule.
