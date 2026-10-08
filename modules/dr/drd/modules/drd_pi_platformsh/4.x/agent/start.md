<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Platform Integration: Platform.sh (drd_pi_platformsh) — agent index

Concrete provider for **DRD** that imports **Platform.sh** inventory into DRD via the `drd_pi`
framework, using the official **`platformsh/client`** PHP library. Package `DRD`. Depends on
**`drd_pi`** (which depends on `drd`); code also uses `drd_agent` constants. Core `^10 || ^11`.
Version dir 4.x (release 4.1.7). Configure route
`drd_pi_platformsh.drd_pi_platformsh_settings` (`/drd/settings/platformsh`). No permissions of
its own; provides config schema; no Drush command of its own (uses `drd_pi`'s `drd:pi:sync`).

- **The account config entity, token auth, platformsh/client calls, routes and block** →
  [config/account.md](config/account.md)

## What it actually is (from source)

- **Config entity** `platformsh_account` (`src/Entity/Account.php`, extends `DrdPiAccount`):
  `@ConfigEntityType`, `admin_permission = administer site configuration`, `config_export`
  `status,id,label,api_token`. Its constructor builds a `Platformsh\Client\PlatformClient` and
  `getConnector()->setApiToken(getApiToken(), 'exchange')`.
- **Credential**: `getEncryptedFieldNames()` = `['api_token']`; `getApiToken()` /
  `setApiToken()` via base `getDecrypted()`/`setEncrypted()` (DRD `drd.encrypt`).
- **Auth**: `getAuthorizationMethod()` = `drd_agent` `Base::SEC_AUTH_PLATFORMSH`;
  `getAuthorizationSecrets()` = `['PLATFORM_PROJECT' => host id]`.
- **Inventory** (via the library, HTTPS): `getPlatformHosts()` → `client->getProjects()`
  (only `status === 'active'`) → one `DrdPiHost` per project id. `getPlatformCores($host)` →
  `client->getProject(id)->getEnvironments()` (only active envs with `has_code`); domain host
  from `_links['pf:routes'][0]['href']` via `parse_url(...HOST)`. If
  `http_access.basic_auth` is present, its user/pass are `base64`-encoded into a `Basic`
  `Authorization` header on the `DrdPiDomain`.
- **Forms**: `Entity\AccountForm` (adds API-token field; encrypts on submit) and
  `Form\Settings` (`ConfigFormBase`, "No settings required at this point.").
- **Block**: `WidgetPlatformsh` (id `drd_pi_platformsh`, tag `drd_widget`, `account_type =
  platformsh_account`, extends `drd_pi`'s `WidgetPlatforms`).
- **Routes** (`drd_pi_platformsh.routing.yml`): settings `/drd/settings/platformsh`
  (`access administration pages`); account collection `/drd/settings/platformsh/accounts`
  (`administer site configuration`). Entity CRUD via `AdminHtmlRouteProvider`.

## Config

- Config entities: `drd_pi_platformsh.platformsh_account.<id>` (schema
  `config/schema/platformsh_account.schema.yml`). Settings object
  `drd_pi_platformsh.settings` (unused by the settings form).
