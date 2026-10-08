<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Atlassian Crowd (crowd) — agent index

Makes an **Atlassian Crowd** server the identity provider for Drupal. When core's local
password check fails, credentials are validated against Crowd's REST User Management API
(`/rest/usermanagement/1`) over HTTP Basic auth, and a Drupal account is auto-provisioned and
mapped to the `crowd` external-auth provider. Registration, profile edits and password changes
are written back to Crowd. No submodules.

- **Dependencies:** `externalauth` (^2), `key` (^1); core `~9.0 || ~10.0 || ^11`; PHP `>=8.1`.
  Dev/test only: `tfa` (^2).
- **License:** GPL-2.0-or-later. Package: none declared. Version dir `3.x` (branch by larowlan /
  PreviousNext).

## What it provides (from source)

- **Service `crowd.connector`** → `Drupal\crowd\Crowd\CrowdConnector` (implements
  `CrowdConnectorInterface`): the entire Crowd REST client — `login`, `logout`, `register`,
  `updateUser`, `updatePassword`, `updateUserStatus`, `getUser`, `userExists`, `isVerified`,
  `passwordReset`. Value objects `CrowdUser` and `CrowdResult`; `MissingKeyException`.
- **Config form** `SettingsForm` at route `crowd.settings` → **`/admin/config/crowd/settings`**
  (permission `administer crowd`; menu link under *Configuration → People*). Writes config object
  **`crowd.settings`**.
- **Permissions** (`crowd.permissions.yml`): `administer crowd`, `login to local drupal account`.
- **User base fields** (`hook_entity_base_field_info`): `given_name`, `surname`, `display_name`.
- **Form hooks** (all in `crowd.module`, delegating to `src/Hooks/*`): user login, register, edit
  (profile), password-reset, and TFA-setup form alters/validators; `hook_user_login`,
  `hook_user_logout`, `hook_entity_field_access`, `hook_entity_extra_field_info`.
- **Key** `crowd_password` (shipped `config/install/key.key.crowd_password.yml`): holds the Crowd
  API password; env provider reading `CROWD_REST_API_PASSWORD` by default.
- No plugin types, no Drush, no custom routes beyond the settings form.

## Solution docs

- **Settings, config object, schema, Key & permissions** →
  [config/settings.md](config/settings.md)
- **The `crowd.connector` REST client API (methods, endpoints, auth, result objects)** →
  [api/connector.md](api/connector.md)
- **Login / register / profile / password-reset / TFA form integration and user provisioning** →
  [integration/user-forms.md](integration/user-forms.md)
