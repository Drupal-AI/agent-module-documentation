<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DaData Integration (dadata_integration) — agent index

Integrates the [DaData Suggestions API](https://dadata.ru/api/suggest/) to add autocomplete dropdowns (address, full name/`fio`, email, company/`party`) to Drupal form fields matched by CSS selector. Client-side JS calls a server-side proxy controller that forwards each query to DaData using the site's stored API token.

## Facts
- Machine name: `dadata_integration`. Package: Custom. License: GPL-2.0-or-later.
- Core: `^10.1 || ^11 || ^12`. Dependencies: `drupal:system` only. No Composer requirements.
- Provides: no entities, no plugin types, no permissions of its own, no Drush commands.
- Config object: `dadata_integration.settings` (schema in `config/schema/dadata_integration.schema.yml`).
- Ships translations: `translations/dadata_integration.pot`, `translations/ru.po`.

## Routes
- `dadata_integration.settings` — `GET/POST /admin/config/services/dadata`, `_form` `Form\SettingsForm`, permission `administer site configuration`. Admin settings + field mapping UI. Menu link under Web services (`dadata_integration.links.menu.yml`).
- `dadata_integration.suggest` — `/dadata/suggest/{type}`, `_controller` `Controller\SettingsController::suggest`, permission `access content`, `_format: json`. Proxy to DaData.

## Services & hooks
- `Drupal\dadata_integration\Hook\DadataIntegrationHooks` (autowired) — `#[Hook('page_attachments')]` `pageAttachments()`: attaches library `dadata_integration/dadata` and injects the configured field list into `drupalSettings.dadataIntegration.fields`. `dadata_integration.module` bridges the legacy hook via `#[LegacyHook]`.
- No custom service beyond the hook class; the controller uses the core `http_client`.

## Frontend
- Library `dadata` (`dadata_integration.libraries.yml`): `js/dadata_autocomplete.js` + `css/dadata_autocomplete.css`, depends on `core/drupal`, `core/drupalSettings`.
- `Drupal.behaviors.dadataAutocomplete` binds each configured selector; after 3 chars it `fetch`es `/dadata/suggest/{type}` and renders a `<ul class="dadata-suggestions">` dropdown.

## Solution docs
- [Settings & configuration](config/settings.md) — the settings form, config keys, schema, field-row mapping.
- [Suggest proxy endpoint & JS behavior](api/suggest.md) — the `/dadata/suggest/{type}` controller, request payload, and client behavior.
