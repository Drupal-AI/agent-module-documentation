<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Passkeys (decoupled_passkeys) — agent index

Adds **passkey (WebAuthn) registration and login** for a **decoupled** Drupal front-end, exposed
entirely as **JSON:RPC methods**. No UI, no config objects, no HTTP routes of its own. Depends on
**`jsonrpc`** (^2), **`public_key_credential_source`** (^1.0@alpha) and **`webauthn_framework`**.
Core `^10 || ^11`, PHP `>=8.2`. License GPL-2.0-or-later. Version 1.0.x (installed `1.0.0-alpha6`).

- **The four JSON:RPC methods, params, access, and the register/login flow** →
  [api/jsonrpc-methods.md](api/jsonrpc-methods.md)
- **Install, dependencies, permissions, and operating notes** →
  [config/setup.md](config/setup.md)

## What it actually is

- Four `@JsonRpcMethod` plugins in `src/Plugin/jsonrpc/Method/`, all extending
  `Drupal\jsonrpc\Plugin\JsonRpcMethodBase`:
  - `user.register_device_options` — `GetRegisterDeviceOptions` (no params) → creation options JSON.
  - `user.register_device` — `RegisterDevice` (`attestation` string) → boolean.
  - `user.request_options` — `GetRequestOptions` (`userHandle` string) → request options.
  - `user.authenticate_request` — `AuthenticateRequest` (`request` + `userHandle` strings) → logs
    the user in and returns the account JSON.
- One permission: **`login by passkey`** (`decoupled_passkeys.permissions.yml`), gating the two
  login methods. Registration methods reuse **`create public key credential source entities`**
  from the `public_key_credential_source` module (registration acts on the current user only).
- Three exception classes in `src/Exception/` (`DecoupledPasskeysException` and two subclasses).
- **No `.module`, no `.install`, no `.services.yml`, no `.routing.yml`, no `config/`.** All WebAuthn
  logic (options building, attestation/assertion verification, credential storage) lives in the
  injected `public_key_credential_source.webauthn` service, not here.

## Mechanism (from source)

- Every method resolves the caller as `current_user` and injects `entity_type.manager`,
  `logger.factory` (channel `decoupled_passkeys`), and `public_key_credential_source.webauthn`.
- Register: `execute()` loads the current user and calls `$this->webauthn->getRegistrationOptions()`
  / `->registerDevice($account, $attestation)` — the account is always the authenticated caller.
- Login: `GetRequestOptions` calls `->getRequestOptions($userHandle)`; `AuthenticateRequest` calls
  `->authenticateRequest($userHandle, $request)`, and only if that returns a
  `Webauthn\PublicKeyCredentialSource` does it load the account by the credential's stored
  `userHandle` (a user UUID) and call `user_login_finalize($account)`.
- Errors caught as `\LogicException` are logged and re-thrown as a JSON:RPC internal error.

## Notes

- The module ships **no frontend**; a JS/TS client (e.g. `@simplewebauthn/browser`) drives the
  flow. The relying party, origin/rpId, and challenge handling are configured in the
  `webauthn_framework` layer, not in this module.
