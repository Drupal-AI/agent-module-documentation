<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliocommons — install & configuration

## Install
`composer require drupal/bibliocommons` then `drush en bibliocommons`. Pulls `key`, `field` (core), `wsdata`, `ui_patterns`. Enabling installs the config objects below (`config/install/`); `hook_uninstall` (`bibliocommons.install`) deletes `bibliocommons.settings` and the three wsdata configs.

## Settings form
- Route `system.admin_config_services.bibliocommons`, path `admin/config/services/bilbiocommons` (path is misspelled in `bibliocommons.routing.yml` but works), title "Administer Bibliocommons".
- Permission: `administer bibliocommons` (`bibliocommons.permissions.yml`).
- Menu link: `bibliocommons.settings_form` under System > Configuration > Web services.
- Form: `\Drupal\bibliocommons\Form\BibliocommonsForm` (a plain `FormBase`, not `ConfigFormBase`). Fields:
  - `bib_api_key` — `key_select` (required), saved to `api_key`. Stores a **Key entity id**, not the raw secret.
  - `bib_library` — textfield, saved to `library_id` (the BiblioCommons subdomain / library slug).
  - `bib_client_id` — textfield, saved to `client_id` (Syndetics cover-image client id).
  - `submitForm()` writes all three into editable `bibliocommons.settings`. `validateForm()` is a no-op (`return TRUE`).

## Config objects
`bibliocommons.settings` (schema in `config/schema/bibliocommons.schema.yml` only defines the formatter mapping; the three settings keys are plain strings):
- `api_key` — id of a Key entity holding the BiblioCommons API key.
- `library_id` — used both as a request param and to build patron `holds` / `my shelf` links (`https://<library_id>.bibliocommons.com/...`).
- `client_id` — Syndetics client id embedded in cover-image URLs.

wsdata config (installed, editable in the wsdata UI):
- `wsdata.wsserver.bibliocommons_version_1` — `endpoint: https://api.bibliocommons.com/v1/`, connector `WSConnectorSimpleHTTP` (Guzzle; standard TLS verification).
- `wsdata.wscall.books` — path `lists/[ID]`, method `get`, decoder `WSDecoderJSON`, encoder `ApiRequestEncoder`, `expires: 3600` (cached).
- `wsdata.wscall.book` — path `titles/[ID]`, method `get`, same decoder/encoder, no expiry set.

## Key setup
Create a Key entity (e.g. env or file provider) holding the BiblioCommons API key, then select it in the settings form. `BibliocommonsService::getBookList()` resolves the raw value at call time via `KeyRepository::getKey($keyId)->getKeyValue()` — the secret is not stored in `bibliocommons.settings`.

## Request flow
`ApiRequestEncoder::encode()` (WSEncoder plugin) appends `library`, `locale`, and `api_key` as query params onto the wsdata request URL. `locale` comes from the active interface language (`language_manager`). Responses are decoded from JSON and cached per the WSCall's `expires`.
