<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drd_pi_pantheon — Pantheon account & sync

## Install / enable

`drush en drd_pi_pantheon` (pulls in `drd_pi` and `drd`). Configure a DRD encryption profile so
the machine token is stored encrypted.

## Create an account

Configuration → DRD → Pantheon → Accounts (`/drd/settings/pantheon/accounts`) → Add Pantheon
Account. Form (`Entity\AccountForm`) fields:

- **Enabled** / **Label** / **Machine name** (from `DrdPiAccountForm`).
- **Machine token** (`machine_token`, required) — from the Pantheon dashboard "Account" section.

`AccountForm::submitForm()` → `setMachineToken()` → `setEncrypted('machine_token', …)` encrypts
the token via DRD's `drd.encrypt` before save; `getMachineToken()` decrypts on read.

## Config objects

- Account entities: `drd_pi_pantheon.pantheon_account.<id>` — keys `id`, `label`, `uuid`,
  `machine_token` (schema `config/schema/pantheon_account.schema.yml`). `admin_permission =
  administer site configuration`; `config_export` `status,id,label,machine_token`.
- `drd_pi_pantheon.settings` — declared editable by `Form\Settings` but currently stores
  nothing.

## Pantheon / Terminus API

Constants on `Account`: `ENDPOINT = https://terminus.pantheon.io:443/api/`, `CLIENT =
terminus`, a Terminus `USER_AGENT`, `CONTENT_TYPE = application/json`.

- `auth()` runs once per request cycle: `post(['machine_token' => getMachineToken()])` →
  `request('authorize/machine-token', ['body' => json…], 'POST', auth_first: FALSE)`. The
  response object's `session` is cached and sent as `Authorization: Bearer <session>` on later
  calls; `user_id` identifies the account.
- `request($path, $options, $method, $auth_first)` builds a Guzzle client via
  `http_client_factory->fromOptions()` (default TLS verify), sets Content-type/User-Agent
  headers, and `json_decode`s the body (returns NULL on error).

Inventory mapping:

- `getPlatformHosts()` → `GET users/{user_id}/memberships/sites`; keeps only non-frozen sites
  whose `framework` is `drupal` or `drupal8`; one `DrdPiHost` per `site->id`.
- `getPlatformCores(host)` → `GET sites/{id}` + `GET sites/{id}/environments`; for each
  `is_initialized` environment a `DrdPiCore` + `DrdPiDomain`. The domain starts as
  `{env}-{site}.{dns_zone}`; a Guzzle `HEAD` with `allow_redirects: FALSE` reads a `Location`
  header and `parse_url(...PHP_URL_HOST)` resolves the real live hostname.
- `getAuthorizationSecrets(domain)` → `['PANTHEON_SITE' => host id]`.
- `getAuthorizationMethod()` → `drd_agent` `Base::SEC_AUTH_PANTHEON`.

## Routes & permissions

- `drd_pi_pantheon.drd_pi_pantheon_settings` — `/drd/settings/pantheon`, `Form\Settings`,
  `_permission: access administration pages`.
- `entity.pantheon_account.collection` — `/drd/settings/pantheon/accounts`,
  `_permission: administer site configuration`.
- Add/edit/delete/canonical routes from the entity's `AdminHtmlRouteProvider`; links in
  `drd_pi_pantheon.links.{task,action,menu}.yml`.

## Running the sync

No command of its own: use `drd_action_pi_sync`, `drush drd:pi:sync`, or the DRD dashboard.
`WidgetPantheon` (block `drd_pi_pantheon`) shows account/host/core/domain counts and a settings
link.
