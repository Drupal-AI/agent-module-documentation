<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form and config object

## Route / form

- Route `campaign_monitor_rest_client.config` (`*.routing.yml`):
  path `/admin/config/services/campaign_monitor_rest_client`,
  `_form: CampaignMonitorRestClientSettingsForm`, `_admin_route: TRUE`,
  requirement `_permission: 'administer site configuration'`.
- Menu link `campaign_monitor_rest_client.config` (`*.links.menu.yml`) under
  *Configuration → Web services* (parent `system.admin_config_services`, weight 10).
- Set the module's `configure` link to this route (info.yml `configure:`).

## Form (`src/Form/CampaignMonitorRestClientSettingsForm.php`)

`ConfigFormBase` subclass, form id `campaign_monitor_rest_client_settings`, editable config
`campaign_monitor_rest_client.settings`. Two fields:

| Key | `#type` | Meaning |
|-----|---------|---------|
| `status` | `checkbox` (*Enabled*) | Turns the client on/off. When off the factory returns the disabled stub that throws on every request. Intended so it can be disabled on non-production servers. |
| `api_key` | `textarea` (*API Key*) | The Campaign Monitor REST API key used for Basic-auth. |

`submitForm()` writes both values into the config object with two separate `->set()->save()` calls.

## Config object `campaign_monitor_rest_client.settings`

Two keys, both read by `CampaignMonitorRestClientFactory`:

- `api_key` (string) — the Campaign Monitor API key. Read at
  `CampaignMonitorRestClientFactory::__construct()`/`fromOptions()` and passed as the client's
  `api_key` option; the library turns it into an `Authorization: Basic base64(<key>:x)` header.
- `status` (bool-ish) — gate checked in `fromOptions()`; falsy → `CampaignMonitorRestClientDisabled`.

There is **no `config/install` default file** (the object is created on first save) and **no
`config/schema/*.schema.yml`** shipped, so the config object is untyped/schema-less on disk.

## Operating notes

- After enabling the module, visit the settings route, paste the API key, tick *Enabled*, save.
- Verify quickly from Drush: `drush php:eval "var_dump(\Drupal::service('campaign_monitor_rest_client')->get('clients.json')->getData());"`.
- To disable in an environment without editing the form, set `status` to `0` in that environment's
  config, or override `campaign_monitor_rest_client.settings:status` via
  `$config['campaign_monitor_rest_client.settings']['status'] = FALSE;` in `settings.php`. You can
  likewise override `api_key` per-environment there so the value need not live in synced config.
