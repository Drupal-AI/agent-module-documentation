<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DaData API (dadata_api) — agent index

Developer library wrapping the DaData.ru REST APIs as three injectable Drupal services. Ships no
widgets or public routes — you call the services from your own PHP. Core `^8.8 || ^9 || ^10 || ^11`.
No module dependencies (uses core Guzzle `@http_client` + `@config.factory`).

## What it provides
- **Services** (`dadata_api.services.yml`), all extending `Drupal\dadata_api\DaDataApiBase`
  (abstract parent service `dadata_api` supplies `@config.factory` + `@http_client`):
  - `dadata_api.info` → `DaDataApiInfo`: `getVersion()`, `getBalance()`, `getStat($date)` — Base API
    at `https://dadata.ru/api/v2`.
  - `dadata_api.cleaner` → `DaDataApiCleaner`: `clean($data, $type)` — Cleaner API at
    `https://cleaner.dadata.ru/api/v1/clean`.
  - `dadata_api.suggestions` → `DaDataApiSuggestions`: `suggest()`, `findById()`, `geoLocate()`,
    `ipLocate()` — Suggestions API at `https://suggestions.dadata.ru/suggestions/api/4_1/rs`.
- **Config**: `dadata_api.settings` (`api_key`, `secret`, `timeout`) with schema in
  `config/schema/dadata_api.schema.yml`; defaults in `config/install/dadata_api.settings.yml`.
- **Admin form**: `Drupal\dadata_api\Form\SettingsForm` at route `dadata_api.settings`
  (`/admin/config/services/dadata-api`), menu link under Web services.
- **Permission**: `administer dadata api` (restrict access) — gates the settings form only.
- **Hook**: `dadata_api_help()` in `dadata_api.module`.

## Solution docs
- [Configuration & settings](config/settings.md) — install, config object/schema/keys, the settings form.
- [Service API reference](api/services.md) — every service method, request mechanics, auth headers, return contract.
