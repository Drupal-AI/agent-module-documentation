<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveCampaign settings

## Install / enable

`drush en activecampaign` (the composer package `drupal/activecampaign` pulls in
`activecampaign/api-php ^2.0` and `drupal/webform ^6`). Nothing functions until credentials are set.

## Config object

`activecampaign.settings` (config_object). Schema `config/schema/activecampaign.schema.yml`, install
defaults `config/install/activecampaign.settings.yml` (all `''`). Three string keys:

| key | meaning | example |
|---|---|---|
| `url` | ActiveCampaign **app/site** base URL (used to build embed script src and app deep-links) | `https://XXX123.activehosted.com` |
| `api_url` | ActiveCampaign **API** base URL | `https://XXX123.api-us1.com` |
| `api_key` | ActiveCampaign **API key** (Settings → Developer in AC) | — |

## Settings form

`Form\SettingsForm` (`src/Form/SettingsForm.php`), extends `ConfigFormBase`; form id
`activecampaign_settings`; `getEditableConfigNames()` → `['activecampaign.settings']`.

- Route `activecampaign.settings`, path `/admin/config/services/activecampaign`,
  `_permission: 'administer site configuration'` (`activecampaign.routing.yml`).
- Menu link `activecampaign.settings` under `system.admin_config_services`
  (*Configuration → Services*), weight 10 (`activecampaign.links.menu.yml`).
- Fields: `url` (textfield), and a `Api connection` details group with `api_url` and `api_key`
  textfields. `submitForm()` writes all three to the config object.

Consumed by:
- `ActiveCampaignApi::__construct()` — `api_url` + `api_key` build the `\ActiveCampaign` SDK client;
  `url` is stored for deep-link/embed URL building.
- `ActiveCampaignFormFormatter::viewElements()` — reads `url` for the embed `base_url`; render cache
  is tagged `config:activecampaign.settings`.

## Notes

- The 2.x rewrite is planned per the project roadmap. There is no submodule-specific config; the
  dashboard and webform submodules read the same `activecampaign.settings` via the shared service.
