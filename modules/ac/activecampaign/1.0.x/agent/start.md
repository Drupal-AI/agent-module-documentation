<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveCampaign (activecampaign) — agent index

Integrates Drupal with the **ActiveCampaign** marketing-automation / CRM platform via the official
`activecampaign/api-php` SDK (`^2.0`, a composer requirement). Package `Automated marketing`. Core
`^10.2 || ^11`, PHP `>=8.1`, license GPL-2.0-or-later, version 1.0.0-rc1 (version-dir `1.0.x`).
Also requires `drupal/webform` `^6` at the composer level (used by the `activecampaign_webform`
submodule). No Drupal-module `dependencies` in the base module's `.info.yml`.

- **Settings: config object, schema, the settings form** → [config/settings.md](config/settings.md)
- **The `activecampaign.api` service (ActiveCampaignApi) — every method** → [api/service.md](api/service.md)
- **The `active_campaign_field` field type, its two widgets, the formatter, the autocomplete route** →
  [fields/field.md](fields/field.md)

## What it actually is (base module)

- **One service** `activecampaign.api` = `Drupal\activecampaign\ActiveCampaignApi`
  (`src/ActiveCampaignApi.php`), constructed with `@config.factory`. In its constructor it reads
  `activecampaign.settings` and does `new \ActiveCampaign($config->get('api_url'), $config->get('api_key'))`
  — the SDK client. Methods: `getForms()`, `searchForms($q)`, `getContact($id)`, `getContacts()`,
  `getLists()`, `getCampaigns()`, `syncContact($contact)`, `getFormTitle($id)`,
  `createUrlToContact($id)`, `createUrlToCampaign($id)`.
- **One config object** `activecampaign.settings` with three string keys — `url`, `api_url`,
  `api_key` (schema `config/schema/activecampaign.schema.yml`, install defaults all `''`). Edited by
  `Form\SettingsForm` at route `activecampaign.settings` → `/admin/config/services/activecampaign`
  (`_permission: 'administer site configuration'`; menu link under *Configuration → Services*).
- **One field type** `active_campaign_field` (`Plugin/Field/FieldType/ActiveCampaignItem`, extends
  `StringItemBase`; single `value` text column storing an ActiveCampaign form id), with:
  - two widgets — `activecampaign_form_select_list` (default; dropdown of all AC forms) and
    `activecampaign_form_autocomplete` (typeahead) — both inject `activecampaign.api`.
  - one formatter — `activecampaign_form` (default) — renders `#theme => 'activecampaign_form_formatter'`
    which outputs a `<div class="_form_{id}">` plus ActiveCampaign's hosted
    `{base_url}/f/embed.php?id={id}` `<script>` (`templates/activecampaign-form-formatter.html.twig`).
- **One controller route** `activecampaign.autocomplete.forms` →
  `Controller\FormAutocompleteController::handleAutocomplete`, path
  `/admin/activecampaign/autocomplete/forms`, `_permission: 'access content'`. Returns JSON of AC
  forms matching `?q=` (`Xss::filter`ed) for the autocomplete widget.
- **One hook** `activecampaign_theme()` registers the `activecampaign_form_formatter` theme.
- **No** permissions of its own, **no** Drush, **no** custom entities. Provides config schema.

## Submodules (each documented in its own tree)

- **activecampaign_dashboard** → `modules/activecampaign_dashboard/1.0.x/` — three read-only admin
  form pages (contacts, lists, campaigns) under `/admin/activecampaign/*`, permission
  `access activecampaign dashboard`.
- **activecampaign_webform** → `modules/activecampaign_webform/1.0.x/` — a Webform handler
  (`activecampaign_contact`) that maps submitted fields to an AC contact and calls `syncContact()`.

## Operating notes

- Nothing works until `url`, `api_url` and `api_key` are set; widgets/dashboards call the live API
  on every render and surface API errors via messenger/log.
- The 2.x branch is a planned rewrite; the Webform handler's custom-YAML mapping is flagged
  experimental by the maintainer.
