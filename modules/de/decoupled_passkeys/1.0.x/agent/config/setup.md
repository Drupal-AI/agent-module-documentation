<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Passkeys — install, dependencies & permissions

## Install / enable

- `composer require drupal/decoupled_passkeys` then `drush en decoupled_passkeys`.
- `.info.yml` dependencies (all must be present/enabled): `drupal:jsonrpc`,
  `drupal:public_key_credential_source`, `drupal:webauthn_framework`. `composer.json` requires
  `drupal/jsonrpc:^2`, `drupal/public_key_credential_source:^1.0@alpha`, `ext-json`, PHP `>=8.2`
  (`webauthn_framework` is pulled in via `public_key_credential_source`).
- Core `^10 || ^11`. Project is security-advisory **not-covered** (alpha; installed `1.0.0-alpha6`).
- **No install/uninstall hooks, no config, no schema, no menu links** — enabling only registers
  the four JSON:RPC method plugins and the one permission.

## Configuration

- This module has **nothing to configure** (no settings route, no config object; `configure` is
  null). It relies on the `jsonrpc` module for the transport endpoint and on `webauthn_framework`
  for all WebAuthn/relying-party settings (relying-party name/ID, origin, challenge handling).
  Configure those there, not here. (The CHANGELOG notes that relying-party config and most
  WebAuthn code were moved out to `webauthn_framework` in alpha5.)

## Permissions (which role gets what)

- **`create public key credential source entities`** (from `public_key_credential_source`) — grant
  to authenticated roles that may **register** passkeys. Guards `user.register_device_options` and
  `user.register_device`; both operate on the current user only.
- **`login by passkey`** (this module, `decoupled_passkeys.permissions.yml`, title *"Allows the
  user to log-in via a passkey."*) — guards `user.request_options` and
  `user.authenticate_request`. A returning user is anonymous at the moment they authenticate, so
  the role that needs this is typically **Anonymous** (mirrors any decoupled login endpoint).
- The `jsonrpc` module additionally gates access to its endpoint; ensure callers can reach it.

## Passkey display name (README / CHANGELOG)

- The passkey handle shown to the user is normally the **Drupal account display name**. If the
  **Email Registration** module is enabled, the **email address** is used instead so password
  managers surface the right credential. This behaviour is implemented in the WebAuthn framework
  layer that this module calls.

## Operating notes

- Logging goes to the **`decoupled_passkeys`** logger channel. `register_device_options` and
  `register_device` emit `debug()` lines with the uid — keep debug logging off in production
  (an inline source comment says so).
- No Drush commands, no services, no hooks are provided by this module.
- The module provides **no frontend**; you must build the JS/TS client (e.g. `@simplewebauthn`).
  See the FIDO Alliance passkey UX guidelines linked in the README.
