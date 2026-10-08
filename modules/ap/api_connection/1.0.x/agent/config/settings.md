<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, environments, config & permission

## Install / enable

`drush en api_connection`. No module dependencies. Enabling the framework alone does nothing at
runtime — a consuming module must declare a `RestApiConnection` plugin and call `sendRequest()`.
Optional worked example: `drush en api_connection_example` (hidden submodule).

## Config object `api_connection.settings`

- Schema `config/schema/api_connection.schema.yml` (`type: config_object`):
  - `enable_logging` (boolean) — "Enable API call logging".
  - `environment` (string) — "The current environment".
- Install defaults `config/install/api_connection.settings.yml`: `enable_logging: true`,
  `environment: 'dev'`.
- Consumed by `ApiConnectionBase` (`getEnvironment()` reads `environment`) and
  `RestApiConnectionBase` constructor (reads `enable_logging` to decide whether to attach the Guzzle
  logging middleware).

## Settings form & route

- Class `ApiConnectionSettingsForm` (`src/Form/ApiConnectionSettingsForm.php`), extends
  `ConfigFormBase` with `RedundantEditableConfigNamesTrait`; form id `api_connection_settings_form`.
  Injects `config.factory`, `config.typed`, `api_connection.environment`.
- Fields (via `#config_target`):
  - `enable_logging` — checkbox → `api_connection.settings:enable_logging`.
  - `environment` — required radios → `api_connection.settings:environment`, options from
    `ApiConnectionEnvironmentInterface::getEnvironments()`.
- Route `api_connection.settings_form` (`api_connection.routing.yml`): path
  `/admin/config/services/api_connection`, `_form` the settings form, permission
  `administer api_connection settings`, `_admin_route: TRUE`. Menu link
  `api_connection.settings_form` under `system.admin_config_services` (Configuration → Web services).

## Permission

`api_connection.permissions.yml`: **`administer api_connection settings`** — title "Administer API
connection settings", `restrict access: true`. This is the only permission the module defines.

## Environments service & event

- Service `api_connection.environment` = `ApiConnectionEnvironment`
  (`src/ApiConnectionEnvironment.php`), constructed with `@event_dispatcher`. Implements
  `ApiConnectionEnvironmentInterface::getEnvironments()`.
- `getEnvironments()` returns the base map `dev` → Development, `test` → Testing / staging,
  `live` → Live / production, then dispatches `ApiConnectionEnvironmentEvent` on
  `ApiConnectionEvents::ENVIRONMENT` (`'api_connection.environment'`) and returns the (possibly
  extended) list.
- To add environments, subscribe to that event and call
  `ApiConnectionEnvironmentEvent::addEnvironment($id, $label)`
  (`src/Event/ApiConnectionEnvironmentEvent.php`). New environment ids must have a matching key in
  each plugin's `urls` array, or `sendRequest()` throws `RestApiEnvironmentUrlException`.

## Recommended operation

The README recommends adding `api_connection.settings` to `config_ignore` or `config_split` so each
hosting environment keeps its own `environment` / `enable_logging` values instead of sharing them
through exported config.
