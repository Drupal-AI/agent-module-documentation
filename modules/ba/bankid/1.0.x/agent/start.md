<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BankID (bankid) — agent index

Swedish/Nordic BankID.com e-ID login for Drupal. Renders a "Login with BankID"
block/form, drives the BankID relying-party API v6.0 (auth → QR/app → collect),
then matches or provisions a Drupal user by the authenticated personal number and
logs them in via externalauth. Core `^10 || ^11`.

## Dependencies
- `key:key` (>=1.17) — holds the RP client certificate, its passphrase, and the CA/issuer certificate as Key entities.
- `externalauth:externalauth` (>=2.0) — owns the account mapping (`authmap`) and finalizes login.
- Optional `markdown` (help page rendering), `twig_tweak` (embed the form in a template).

## What it provides
- Config: single object `bankid.settings` (env + integration + create_user + redirect_path + per-env `api_base_url`/three key names). Schema is a DB-table schema (`bankid.schema.yml`), config schema is minimal. See [config/settings.md](config/settings.md).
- Routes (`bankid.routing.yml`): `bankid.settings` (admin form, `administer site configuration`); front-end RP proxy `bankid.authenticate` `/api/bankid/authenticate`, `bankid.collect` `/api/bankid/collect/{orderRef}`, `bankid.cancel` `/api/bankid/cancel/{orderRef}` (all `access content`, `no_cache`).
- Controller: `BankIDController` (authenticate/collect/cancel) → returns `BankIDResponse::getBody()` as JSON.
- Service `bankid` = `BankIDClient` (extends `GuzzleHttp\Client`; mutual-TLS via Key certs). Client methods: `authenticate`, `sign`, `phoneAuth`, `phoneSign`, `collect`, `cancel`. See [api/authentication-flow.md](api/authentication-flow.md).
- Form `BankIDAuthenticateForm` (the login button + AJAX modal + `submitForm()` that finalizes login). Admin form `BankIDSettingsForm`.
- Block `bankid_authenticate_block` (renders the form).
- Plugin type `@Integration` (`src/Plugin/BankID/`, manager `plugin.manager.bankid.integration`, base `IntegrationBase`, default `DefaultIntegration`) — `getUser()`/`createUser()`. See [plugins/integration.md](plugins/integration.md).
- JS library `bankid/bankid.authenticate` (`js/authenticate.js` + qrious/crypto-js) — polls collect, submits the completed response into the login form.
- Hooks (`bankid.module`): `hook_help`, `hook_theme` (`authenticate_dialog`), `hook_validation_constraint_alter` (decorates ProtectedUserField), `hook_form_user_form_alter` (hides password fields for BankID users).
- Value object `BankIDResponse` + `BankIDUserMessages` (RFA recommended-message codes).

## Operate
- Install: enable `key`, `externalauth`, then `bankid`; visit `/admin/config/system/bankid`.
- Test env works out of the box with bundled certs (`assets/`) + the three `key.key.bankid_test_*` config-install keys.
- Production: create Key entities for bank-issued certs (File provider, outside webroot) + passphrase, select them per-env, set `environment: prod`.
- Add the BankID Authenticate block or embed `BankIDAuthenticateForm` in Twig.
