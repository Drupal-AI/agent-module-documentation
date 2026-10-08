<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Platform Integration: Pantheon (drd_pi_pantheon) — agent index

Concrete provider for **DRD** that imports **Pantheon** inventory into DRD via the `drd_pi`
framework. Package `DRD`. Depends on **`drd_pi`** (which depends on `drd`); code also uses
`drd_agent` constants. Core `^10 || ^11`. Version dir 4.x (release 4.1.7). Configure route
`drd_pi_pantheon.drd_pi_pantheon_settings` (`/drd/settings/pantheon`). No permissions of its
own; provides config schema; no Drush command of its own (uses `drd_pi`'s `drd:pi:sync`).

- **The account config entity, machine-token auth, Terminus API calls, routes and block** →
  [config/account.md](config/account.md)

## What it actually is (from source)

- **Config entity** `pantheon_account` (`src/Entity/Account.php`, extends `DrdPiAccount`):
  `@ConfigEntityType`, `admin_permission = administer site configuration`, `config_export`
  `status,id,label,machine_token`. Consts `ENDPOINT = https://terminus.pantheon.io:443/api/`,
  `CLIENT = terminus`, a Terminus `USER_AGENT`, `CONTENT_TYPE = application/json`.
- **Credential**: `getEncryptedFieldNames()` = `['machine_token']`; `getMachineToken()` /
  `setMachineToken()` via base `getDecrypted()`/`setEncrypted()` (DRD `drd.encrypt`).
- **Auth**: `auth()` (once) POSTs the machine token to `authorize/machine-token`
  (`post()` → `request(..., auth_first: FALSE)`); the returned `session` is then sent as a
  `Bearer` header on subsequent `request()` calls. `getAuthorizationMethod()` = `drd_agent`
  `Base::SEC_AUTH_PANTHEON`; `getAuthorizationSecrets()` returns `['PANTHEON_SITE' => host id]`.
- **API/inventory**: `request($path, opts, method, auth_first)` via `http_client_factory`
  (Guzzle, default TLS verify). `getPlatformHosts()` → `users/{user_id}/memberships/sites`
  (only non-frozen `drupal`/`drupal8` sites). `getPlatformCores($host)` → `sites/{id}` +
  `sites/{id}/environments` (initialized envs only); each core builds a `DrdPiDomain` from
  `{env}-{site}.{dns_zone}`, then a Guzzle HEAD with `allow_redirects: FALSE` follows a
  `Location` header to resolve the real hostname.
- **Forms**: `Entity\AccountForm` (adds machine-token field; encrypts on submit) and
  `Form\Settings` (`ConfigFormBase`, "No settings required at this point.").
- **Block**: `WidgetPantheon` (id `drd_pi_pantheon`, tag `drd_widget`, `account_type =
  pantheon_account`, extends `drd_pi`'s `WidgetPlatforms`).
- **Routes** (`drd_pi_pantheon.routing.yml`): settings `/drd/settings/pantheon`
  (`access administration pages`); account collection `/drd/settings/pantheon/accounts`
  (`administer site configuration`). Entity CRUD via `AdminHtmlRouteProvider`.

## Config

- Config entities: `drd_pi_pantheon.pantheon_account.<id>` (schema
  `config/schema/pantheon_account.schema.yml`). Settings object `drd_pi_pantheon.settings`
  (unused by the settings form).
