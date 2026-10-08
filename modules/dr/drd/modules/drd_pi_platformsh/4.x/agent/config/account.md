<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drd_pi_platformsh — Platform.sh account & sync

## Install / enable

`drush en drd_pi_platformsh` (pulls in `drd_pi` and `drd`). The `platformsh/client` PHP library
is provided through the parent `drupal/drd` Composer requirements. Configure a DRD encryption
profile so the API token is stored encrypted.

## Create an account

Configuration → DRD → Platform.sh → Accounts (`/drd/settings/platformsh/accounts`) → Add
PlatformSH Account. Form (`Entity\AccountForm`) fields:

- **Enabled** / **Label** / **Machine name** (from `DrdPiAccountForm`).
- **API token** (`api_token`, required) — from the Platform.sh dashboard "Account Settings".

`AccountForm::submitForm()` → `setApiToken()` → `setEncrypted('api_token', …)` encrypts via
DRD's `drd.encrypt` before save; `getApiToken()` decrypts on read. The entity constructor
instantiates `Platformsh\Client\PlatformClient` and calls
`getConnector()->setApiToken(getApiToken(), 'exchange')`.

## Config objects

- Account entities: `drd_pi_platformsh.platformsh_account.<id>` — keys `id`, `label`, `uuid`,
  `api_token` (schema `config/schema/platformsh_account.schema.yml`). `admin_permission =
  administer site configuration`; `config_export` `status,id,label,api_token`.
- `drd_pi_platformsh.settings` — declared editable by `Form\Settings` but currently stores
  nothing.

## Platform.sh API (platformsh/client)

All calls go through the library over HTTPS (token exchanged for a session by the connector).

- `getPlatformHosts()` → `client->getProjects()`; keeps projects whose `status === 'active'`;
  one `DrdPiHost` per project `id`.
- `getPlatformCores(host)` → `client->getProject(host->id())->getEnvironments()`; for each
  environment with `status === 'active'` and `has_code`, a `DrdPiCore` + `DrdPiDomain`. The
  domain host comes from `_links['pf:routes'][0]['href']` via `parse_url(...PHP_URL_HOST)`.
  If `http_access.basic_auth` is set, each user/pass is `base64_encode`d and stored on the
  domain as `Authorization: Basic …` (via `DrdPiEntity::setHeader()`), which `drd_pi` later
  writes into the DRD domain's `header` field so DRD can reach a protected environment.
- `getAuthorizationSecrets(domain)` → `['PLATFORM_PROJECT' => host id]`.
- `getAuthorizationMethod()` → `drd_agent` `Base::SEC_AUTH_PLATFORMSH`.

## Routes & permissions

- `drd_pi_platformsh.drd_pi_platformsh_settings` — `/drd/settings/platformsh`, `Form\Settings`,
  `_permission: access administration pages`.
- `entity.platformsh_account.collection` — `/drd/settings/platformsh/accounts`,
  `_permission: administer site configuration`.
- Add/edit/delete/canonical routes from the entity's `AdminHtmlRouteProvider`; links in
  `drd_pi_platformsh.links.{task,action,menu}.yml`.

## Running the sync

No command of its own: use `drd_action_pi_sync`, `drush drd:pi:sync`, or the DRD dashboard.
`WidgetPlatformsh` (block `drd_pi_platformsh`) shows account/host/core/domain counts and a
settings link.
