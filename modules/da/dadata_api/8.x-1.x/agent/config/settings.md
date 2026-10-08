<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DaData API — configuration & settings

## Install / enable
`drush en dadata_api -y`. No external Drupal module dependencies; requires network access to
DaData.ru and a DaData account API key (and a secret for the Base/Cleaner endpoints).

## Config object `dadata_api.settings`
Defaults (`config/install/dadata_api.settings.yml`):
```yaml
api_key: ''
secret: ''
timeout: 30
```
Schema (`config/schema/dadata_api.schema.yml`, type `config_object`):
- `api_key` (string) — token used in the `Authorization: Token <api_key>` header on every request.
- `secret` (string) — sent as the `X-Secret` header on Base API balance/stat calls and all Cleaner
  calls (the `secret => TRUE` request option).
- `timeout` (float) — max seconds per request; `0` waits indefinitely.

Read at construction time by `DaDataApiBase::__construct()` via
`$config_factory->get('dadata_api.settings')`, then applied through `setApiKey()`, `setSecret()`,
`setTimeout()`. Because config is loaded in the constructor, changing settings takes effect for
service instances built after the change (clear/rebuild the container if needed). Values can also be
overridden at runtime on an instance with the public `setApiKey()` / `setSecret()` / `setTimeout()`
setters.

## Settings form
`Drupal\dadata_api\Form\SettingsForm` (`ConfigFormBase`, form id `dadata_api_settings`) at
route `dadata_api.settings` → `/admin/config/services/dadata-api`, linked under
Configuration » Web services (`dadata_api.links.menu.yml`). Fields: **API key** and **Secret**
(textfields, `autocomplete=off`) and **Timeout** (number, min 0, max 30, step 0.01, required).
`getEditableConfigNames()` returns `['dadata_api.settings']`; `submitForm()` saves all three keys.

## Permission
`administer dadata api` (`dadata_api.permissions.yml`, `restrict access: TRUE`) — the sole
requirement on the settings route. It does not gate the service methods themselves; any code with a
service reference can call the API.
