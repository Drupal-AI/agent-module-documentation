<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BankID configuration (`bankid.settings`)

Form `Drupal\bankid\Form\BankIDSettingsForm` (`ConfigFormBase`), route
`bankid.settings` at `/admin/config/system/bankid`, permission
`administer site configuration`. Edits the single config object `bankid.settings`.
Menu link `bankid.admin` under `system.admin_config_system`.

## Config keys (`config/install/bankid.settings.yml`)
Top level:
- `environment` — `test` | `prod`. Selects which nested block `BankIDClient` reads. Default `test`.
- `integration` — machine id of the `@Integration` plugin used at login. Default `default`.
- `create_user` — bool. When true and no account matches the personal number, `submitForm()` provisions a new user. Default `false`.
- `redirect_path` — internal path to send users to after login (validated to start with `/` and resolve to a real route). Default `/user`.

Per-environment blocks `prod:` and `test:`, each with:
- `api_base_url` — BankID RP API base. Prod `https://appapi2.bankid.com/rp/v6.0`, test `https://appapi2.test.bankid.com/rp/v6.0`. `BankIDClient` appends `/` then `auth`/`collect`/`cancel`/`sign`/`phone/*`.
- `rp_certificate` — Key id (type `authentication`, provider `file`) of the relying-party client cert (.p12/.pem). Used as Guzzle `cert[0]` (the file path from the Key provider's `file_location`).
- `rp_passphrase` — Key id (type `authentication`, provider `file` or `config`) of the cert passphrase. Used as Guzzle `cert[1]` (the key value).
- `issuer_of_server_certificate` — Key id (type `authentication`, provider `file`) of the CA/issuer cert. Used as Guzzle `verify` (server-cert validation — TLS verification is enabled, pinned to this CA bundle).

The three test keys are shipped as config-install Key entities
(`key.key.bankid_test_rp_certificate`, `..._rp_passphrase`,
`..._issuer_of_server_certificate`) pointing at certs in the module's `assets/`.

## How the client consumes it (`BankIDClient::__construct`)
Reads `bankid.settings.<environment>` and builds the Guzzle base client with
`base_uri = api_base_url . '/'`, `cert = [file_location(rp_certificate), keyValue(rp_passphrase)]`,
`verify = file_location(issuer_of_server_certificate)`, JSON headers. So the
active environment's three Key entities must resolve or the client constructor throws.

## Schema note
`bankid.schema.yml` is a **database table schema** (`bankid_mapping`: uid, id) — legacy;
`bankid_update_10101()` drops that table (mapping moved to externalauth). It is *not*
config schema. The module ships config-install YAML but a minimal/implicit config schema.

## Install / update hooks (`bankid.install`)
- `10101` — drop legacy `bankid_mapping` table (superseded by externalauth authmap).
- `10102` — set default `redirect_path` to `/user` if empty.
- `10104` — clear obsolete `prod.ssl_key` / `test.ssl_key` keys.

## Validation
`BankIDSettingsForm::validateForm()` requires `redirect_path` to begin with `/`
and resolve via `Url::fromUserInput()->isRouted()`, else a form error.
