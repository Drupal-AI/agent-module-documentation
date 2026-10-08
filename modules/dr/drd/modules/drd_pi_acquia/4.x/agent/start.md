<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Platform Integration: Acquia (drd_pi_acquia) — agent index

Concrete provider for **DRD** that imports **Acquia Cloud** inventory into DRD via the `drd_pi`
framework. Package `DRD`. Depends on **`drd_pi`** (which depends on `drd`); code also uses
`drd_agent` constants. Core `^10 || ^11`. Version dir 4.x (release 4.1.7). Configure route
`drd_pi_acquia.drd_pi_acquia_settings` (`/drd/settings/acquia`). No permissions of its own;
provides config schema; no Drush command of its own (uses `drd_pi`'s `drd:pi:sync`).

- **The account config entity, credentials, Acquia API calls, routes, forms and block** →
  [config/account.md](config/account.md)

## What it actually is (from source)

- **Config entity** `acquia_account` (`src/Entity/Account.php`, extends `DrdPiAccount`):
  `@ConfigEntityType`, `admin_permission = administer site configuration`, `config_export`
  `status,id,label,email,private_key`. Endpoint const `https://cloudapi.acquia.com/v1/`.
- **Credential**: `getEncryptedFieldNames()` returns `['private_key']`; `getPrivateKey()` /
  `setPrivateKey()` use the base `getDecrypted()` / `setEncrypted()` (DRD `drd.encrypt`).
  `email` is stored plain.
- **API**: `curl($command)` builds a Guzzle client via `http_client_factory->fromOptions()`
  with `auth => [email, privateKey]` (HTTP basic, default TLS verify) and GETs
  `<ENDPOINT><command>.json`. `getPlatformHosts()` → `sites`; `getPlatformCores($host)` →
  `sites/{host}/envs` (one core + one domain per env, using `default_domain`);
  `getAuthorizationSecrets($domain)` → `sites/{host}/envs/{env}/dbs` (DB username/password).
- **Auth method**: `getAuthorizationMethod()` = `drd_agent` `Base::SEC_AUTH_ACQUIA`.
- **Forms**: `Entity\AccountForm` (adds e-mail + private key fields; encrypts key on submit) and
  `Form\Settings` (`ConfigFormBase`, only shows "No settings required at this point.").
- **Block**: `WidgetAcquia` (id `drd_pi_acquia`, tag `drd_widget`, `account_type =
  acquia_account`) extends `drd_pi`'s `WidgetPlatforms`; shows account/host/core/domain counts.
- **Routes** (`drd_pi_acquia.routing.yml`): settings form `/drd/settings/acquia`
  (`access administration pages`); account collection `/drd/settings/acquia/accounts`
  (`administer site configuration`). Entity CRUD routes come from the entity's
  `AdminHtmlRouteProvider`. Menu/task/action links under DRD settings.

## Config

- Config entities: `drd_pi_acquia.acquia_account.<id>` (schema
  `config/schema/acquia_account.schema.yml`). Settings config object
  `drd_pi_acquia.settings` (currently unused by the settings form).
