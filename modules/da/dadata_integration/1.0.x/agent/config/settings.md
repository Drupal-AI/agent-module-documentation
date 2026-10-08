<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install / enable
```bash
composer require drupal/dadata_integration
drush en dadata_integration
```
No contrib dependencies (only core `system`). Obtain a DaData API key at dadata.ru.

## Settings form
`Form\SettingsForm` (`extends ConfigFormBase`, form id `dadata_integration_settings_form`), route `dadata_integration.settings` at `/admin/config/services/dadata`, permission `administer site configuration`. Menu link "DaData" under Configuration » Web services (`dadata_integration.links.menu.yml`). Editable config: `dadata_integration.settings`.

Form fields:
- `api_key` — textfield, required. Stored verbatim in config.
- `api_url` — textfield, required. Default `https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest`. On save it is `rtrim($value, '/')`-ed.
- `fields` — an AJAX table of rows. Each row: `field_selector` (CSS selector textfield), `suggest_type` (select: `address`/`fio`/`email`/`party`), `bound` (select: `address`,`country`,`region`,`city`,`settlement`,`street`,`house` — disabled unless type is `address`). "Add field" (`addField()`) and per-row "Remove" (`removeField()`) rebuild the wrapper via `ajaxCallback()`; working rows are held in `$form_state->get('dadata_fields')`.

`submitForm()` filters out rows with an empty `field_selector`, normalizes each to `{field_selector, type, bound}` (coercing an unknown type to `address`), reindexes with `array_values()`, and saves `api_key`, `api_url`, `fields` to config.

## Config object & schema
`dadata_integration.settings` (`config/schema/dadata_integration.schema.yml`, `type: config_object`):
- `api_key` (string) — DaData API token.
- `api_url` (string) — base suggest URL.
- `fields` (sequence of mappings) — each mapping: `field_selector` (string), `type` (string), `bound` (string).

Note the stored per-row key is `type` (written by `submitForm()`), while the form element/`$form_state` working copy uses `suggest_type`; the build form reads `$field['suggest_type'] ?? $field['type']` to tolerate both.

## How the config drives the frontend
`Hook\DadataIntegrationHooks::pageAttachments()` (`#[Hook('page_attachments')]`) reads `dadata_integration.settings` `fields`, maps each to `{field_selector, type (allowlisted to address/fio/email/party, else address), bound}`, attaches library `dadata_integration/dadata`, and sets `drupalSettings.dadataIntegration.fields`. The library and settings are attached on every page render (no route/field targeting server-side); the JS binds only selectors present in the current DOM. See [suggest.md](../api/suggest.md).
