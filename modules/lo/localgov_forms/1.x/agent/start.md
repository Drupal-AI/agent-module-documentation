<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Forms (localgov_forms) — agent index

Additional configuration, styling and components for Drupal **Webform**, from the LocalGov Drupal
distribution. Package `LocalGov Drupal`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir `1.x`
(installed 1.2.0).

Module dependencies (info.yml): `inline_form_errors`, `geocoder`, `webform:webform`,
`webform:webform_ui`. Composer also pulls `drupal/webform`, `drupal/geocoder`, and
`localgovdrupal/localgov_os_places_geocoder_provider` (the OS Places address backend).
Suggests `token_environment`, `config_ignore`. No permissions, no routes, no Drush, no
settings form of its own.

## Solution docs

- **UK address lookup elements + geocoder wiring + services** → [elements/address-lookup.md](elements/address-lookup.md)
- **Install-time webform.settings overrides, config schema, custodian-codes option, skip flag** → [config/webform-defaults.md](config/webform-defaults.md)
- **PII redactor plugin type, manager, best-effort plugin, text redaction** → [plugins/pii-redactor.md](plugins/pii-redactor.md)
- **Number two-decimal, character-counter ARIA, form-errors, purge_date token** → [components/enhancements.md](components/enhancements.md)

## What it provides (from source)

- **Webform elements** (FormElement + WebformElement plugin pairs in `src/Element` / `src/Plugin/WebformElement`):
  - `localgov_webform_uk_address` (`UKAddressLookup`) — composite: address search + Ajax lookup + select + manual address 1/2/town/postcode + hidden lat/lng/uprn/ward. Configurable geocoder plugins, custodian code, manual-entry button policy.
  - `localgov_forms_address_lookup` (`AddressLookupElement`) — the internal search/select sub-element with the Ajax callback (`hidden = TRUE`).
  - `webform_uk_address` (`WebformUKAddress`) — plain UK address composite, no lookup.
- **Services** (`localgov_forms.services.yml`):
  - `localgov_forms.address_lookup` → `AddressLookup` (runs geocode via `@geocoder` + selected providers).
  - `localgov_forms.geocoder_selection` → `Geocoders` (loads `geocoder_provider` config entities).
  - `plugin.manager.pii_redactor` → `PIIRedactorPluginManager` (the plugin type).
- **Plugin type** `pii_redactor` (attribute `Drupal\localgov_forms\Attribute\PIIRedactor`, interface `PIIRedactorPluginInterface`, dir `Plugin/PIIRedactor`); sample plugin `best_effort_pii_redactor`.
- **Hooks** (`localgov_forms.module`): `hook_theme` (address templates), `hook_preprocess_webform` (attaches `form_errors` lib), `hook_webform_element_alter` + `..._default_properties_alter` + `..._configuration_form_alter` (two-decimal & counter), `hook_form_webform_ui_element_form_alter`. Token: `webform_submission:purge_date` (`localgov_forms.tokens.inc`).
- **Config**: schema `config/schema/localgov_forms.webform.settings.schema.yml`; install `webform.webform_options.local_custodian_codes_gb` (GB council custodian codes). Install hook rewrites `webform.settings` (see config doc). Libraries in `localgov_forms.libraries.yml` (all local JS/CSS, no CDN).

## Security-relevant facts (public, neutral)

- The address lookup calls the Geocoder service **server-side** with the user's search text as the
  query term only; geocoder **providers are selected by the form builder** (admin config), not the
  requester, and the request never supplies a URL/host. The Ajax callback is a normal Webform form
  element callback governed by that webform's own access, not a custom route.
- Submission values render through Webform/core (select `#options`, table theme) — escaped.
