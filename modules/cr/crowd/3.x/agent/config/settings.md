<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, Key & permissions

## Install / enable

```
composer require drupal/crowd
drush en crowd -y
```

Pulls in `externalauth` and `key` (both hard dependencies). On install, Drupal imports the config
object `crowd.settings` (defaults in `config/install/crowd.settings.yml`) and the Key entity
`crowd_password` (`config/install/key.key.crowd_password.yml`).

## Settings form

`Drupal\crowd\Form\SettingsForm` (extends `ConfigFormBase`), route **`crowd.settings`** →
`/admin/config/crowd/settings`, permission **`administer crowd`**, menu link `crowd.settings`
under `user.admin_index` (*Configuration → People*). Constant `SettingsForm::CROWD_SETTINGS =
'crowd.settings'`. Editable config: `crowd.settings` only.

Form fields → config keys (written in `submitForm`):

| Field | Config key | Type | Notes |
|-------|-----------|------|-------|
| Crowd server URI | `server_uri` | string (`#type url`, required) | Base URI; REST paths are appended to it. |
| Username | `username` | string (required) | Application account used for HTTP Basic auth to Crowd. |
| Password | — | — | Not a config value; a static item linking to the `crowd_password` Key at `/admin/config/system/keys/manage/crowd_password`. |
| Use email for username | `email_as_username` | boolean | When on, the email address is used as the Crowd username; email then can't be changed. |
| Restricted domains | `restricted_domains` | sequence of strings | One domain per line; those users can't change email/password/account. Stored via `array_map('trim', explode("\n", …))`. |
| Verified role | `verified_role` | string (role id) or `~` | Role granted once the user verifies their email. Options exclude the authenticated/anonymous roles (query uses `accessCheck(FALSE)` only to build the option list). |

Install defaults: `username: ''`, `server_uri: ''`, `restricted_domains: []`,
`email_as_username: true`, `verified_role: ~`.

## Config schema

`config/schema/crowd.schema.yml` defines `crowd.settings` as a `config_object` with mappings:
`username` (string), `email_as_username` (boolean), `server_uri` (string), `restricted_domains`
(sequence of string), `verified_role` (string).

## The Crowd API password (Key)

`crowd_password` Key (`key.key.crowd_password`): `key_type: authentication`,
`key_provider: env`, `key_provider_settings.env_variable: CROWD_REST_API_PASSWORD`,
`strip_line_breaks: true`, `key_input: none`. So by default the password is read from the
`CROWD_REST_API_PASSWORD` environment variable. `crowd.module` sets a **placeholder** env value
(`EDIT_THE_CROWD_KEY_IN_ADMIN_CONFIG_SYSTEM_KEYS`) via `putenv()` only when the variable is unset,
so the site boots before an operator supplies a real password or switches the Key to another
provider. `CrowdConnector::getAuthentication()` loads this Key via `key.repository`; if the Key is
missing it logs `critical` and throws `MissingKeyException` (constant `PASSWORD_KEY_ID =
'crowd_password'`).

## Permissions (`crowd.permissions.yml`)

- **`administer crowd`** (`restrict access: true`) — gates the settings form.
- **`login to local drupal account`** (`restrict access: true`) — lets a holder bypass Crowd and
  authenticate with a local Drupal password (used for non-Crowd-managed accounts).

## Logging

Service `logger.channel.crowd` (channel `crowd`) records connector activity — logins, registers,
verification, and errors including the Crowd **response** body on failures.
