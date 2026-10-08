<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveCampaign Webform (activecampaign_webform) — agent index

Submodule of **activecampaign**. Contributes one **Webform handler** that syncs Webform submissions
to ActiveCampaign as contacts via the parent `activecampaign.api` service. Package
`Automated marketing`. Depends on `activecampaign:activecampaign` and `webform:webform`. Core
`^10.3 || ^11`. Version 1.0.0-rc1 (dir `1.0.x`). GPL-2.0-or-later.

- **The handler: config form, field mapping, submit flow, debug** →
  [plugins/webform_handler.md](plugins/webform_handler.md)

## What it provides

- **One plugin**: `Plugin/WebformHandler/ActiveCampaignFormHandler` — `@WebformHandler` id
  `activecampaign_contact`, label *"Active Campaign"*, category *"Automated marketing"*,
  `cardinality = SINGLE`, `results = PROCESSED`. Extends `WebformHandlerBase`; `create()` grabs
  `activecampaign.api`.
- **Config** (`defaultConfiguration()`): `email_field` (required), `first_name_field`,
  `last_name_field`, `debug` (bool, default FALSE), `custom_active_campaign_field` (a YAML string,
  default `field[active_campaign_field_id,0]: '[webform_field_machine_name]'`). The config form
  builds field-select `#options` from the Webform's elements.
- **Submit** (`submitForm()`): reads `$webform_submission->getData()`, assembles
  `$contact_properties` (`email` always; `first_name`/`last_name` when set; extra keys from the
  parsed `custom_active_campaign_field` YAML), then `api->syncContact($contact_properties)` →
  ActiveCampaign `contact/sync`. On `!$response->success` or an `\Exception` it logs via
  `getLogger('activecampaign_webform')`. When `debug` is on it renders the submitted +
  mapped values and logs them at debug level.
- **One theme** `webform_handler_activecampaign_contact_summary`
  (`activecampaign_webform_theme()`, template
  `templates/webform-handler-activecampaign-contact-summary.html.twig`) — the handler summary.
- **No** routes, permissions, config schema, entities or Drush of its own.

## Operating notes

- The email field is `#required` in the handler config; first/last name are optional.
- The custom-YAML mapping is flagged experimental by the maintainer ("not yet working properly").
- All ActiveCampaign traffic goes through the shared `activecampaign.api` service / SDK client.
