<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config, routes & permission

## Install / enable

`composer require drupal/engaging_networks` then `drush en engaging_networks`. Requires the **Key** module
(`drupal/key ^1.15`) and the `openpublicmedia/engaging-networks-php ~0.10` library (pulled by Composer). Before
configuring, create a Key entity of type **authentication** holding the ENS API key.

## Form

`Drupal\engaging_networks\Form\RestApiSettingsForm` (`src/Form/RestApiSettingsForm.php`), form id
`engaging_networks_rest_api_settings`, at **`/admin/config/engaging-networks/settings/rest-api`**. Fields:

- `endpoint` — textfield, the ENS API base URI.
- `api_key` — `key_select` element filtered to `type => authentication`, `#required`. Stores the selected
  **Key id**, not the secret.
- Advanced (`details`, collapsed):
  - `cache_enable` — checkbox, cache the session token in Drupal state.
  - `token` → `cache_keys.token`, `expire` → `cache_keys.expire` — both textfields, `#required`, the state
    cache key names.

Each field is `#disabled` when `configIsOverridden()` finds a `settings.php` override (editable value ≠ active
value). `submitForm()` only writes keys that are not overridden.

## Config object & schema

Config object **`engaging_networks.rest_api`** (`getEditableConfigNames()`), schema in
`config/schema/engaging_networks.schema.yml` (`type: config_object`): `endpoint` (string), `api_key` (string,
"API key credential identifier"), `cache_enable` (boolean), `cache_keys` mapping → `token`, `expire` (strings).

Install defaults (`config/install/engaging_networks.rest_api.yml`): `api_key: ''`, `cache_enable: true`,
`endpoint: ''`, `cache_keys.token: 'engaging_networks.rest_api.cache_keys.token'`,
`cache_keys.expire: 'engaging_networks.rest_api.cache_keys.expire'`.

## Routes, menu, permission

`engaging_networks.routing.yml`:
- `engaging_networks.admin_config_engaging_networks` — `/admin/config/engaging-networks`, renders the core
  `SystemController::systemAdminMenuBlockPage` menu block.
- `engaging_networks.settings.rest_api` — `/admin/config/engaging-networks/settings/rest-api`, the form.

Both require permission **`administer engaging networks`** (`engaging_networks.permissions.yml`,
`restrict access: TRUE`). Menu links (`*.links.menu.yml`) place the group under
`system.admin_config`; a local task (`*.links.task.yml`) exposes the REST API tab.

Note: `info.yml` declares `configure: engaging_networks.settings`, which is not a defined route; use
`engaging_networks.settings.rest_api`.
