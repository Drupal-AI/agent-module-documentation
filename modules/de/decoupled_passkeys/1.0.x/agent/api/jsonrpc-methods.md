<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Passkeys — JSON:RPC methods

All four endpoints are `@JsonRpcMethod` plugins under
`src/Plugin/jsonrpc/Method/`, called through the `jsonrpc` module's endpoint (default
`/jsonrpc`). Each is `final`, extends `JsonRpcMethodBase`, and is constructed via `create()` with
`current_user`, `logger.factory` (channel `decoupled_passkeys`), `entity_type.manager`, and the
`public_key_credential_source.webauthn` service (`PublicKeyCredentialSourceWebauthnInterface`,
here `$this->webauthn`). Params come from the `ParameterBag`; inputs are checked with
`Webmozart\Assert\Assert`. The heavy WebAuthn work is entirely inside `$this->webauthn`.

## Registration (2 methods)

Both require the permission **`create public key credential source entities`** (declared in the
`access = {...}` annotation, provided by the `public_key_credential_source` module). Both act on
the **current authenticated user** — you cannot register a device for another account.

### `user.register_device_options` — `GetRegisterDeviceOptions`
- Params: none. Output schema: `{"type":"string"}`.
- `execute()`: loads the current user (`entity_type.manager->getStorage('user')->load($uid)`,
  asserted `UserInterface`), then `return json_encode($this->webauthn->getRegistrationOptions($account))`.
- The client feeds this JSON to a WebAuthn library (`startRegistration(response)`) to produce an
  attestation.

### `user.register_device` — `RegisterDevice`
- Params: `attestation` (string, required) — the stringified attestation JSON from the client.
- Output schema: `{"type":"boolean"}`.
- `execute()`: `Assert::stringNotEmpty($attestation)`, loads the current user, calls
  `$this->webauthn->registerDevice($account, $attestation)`, returns `TRUE`. Verification and
  credential-source storage happen inside that service.

## Login / authentication (2 methods)

Both require this module's permission **`login by passkey`** (`decoupled_passkeys.permissions.yml`).

### `user.request_options` — `GetRequestOptions`
- Params: `userHandle` (string, required) — per the README, the target user's uid as a string.
- Output schema: `{"type":"string"}`.
- `execute()`: `Assert::stringNotEmpty($user_handle)`, then
  `return $this->webauthn->getRequestOptions($user_handle)` — the request/assertion options the
  client passes to `startAuthentication(response)`.

### `user.authenticate_request` — `AuthenticateRequest`
- Params: `request` (string, required — stringified assertion JSON) and `userHandle` (string,
  required). Output schema: `{"type":"string"}`.
- `execute()`:
  1. Asserts both params are non-empty.
  2. `$pk = $this->webauthn->authenticateRequest($user_handle, $authentication_request)` — this is
     where the WebAuthn framework verifies the assertion (signature, challenge, origin/rpId).
  3. **Only** if `$pk instanceof Webauthn\PublicKeyCredentialSource`: it reads
     `$pk->userHandle` (a user **UUID** carried by the verified credential — not the raw request
     param), loads that account with `getStorage('user')->loadByProperties(['uuid' => $uuid])`,
     asserts `UserInterface`, calls **`user_login_finalize($account)`**, and returns
     `json_encode($account)`. The logged-in account is the one bound to the verified credential.
  4. Otherwise throws `DecoupledPasskeysException('Failed to get PKCredentialSource!')`.

## Error handling

Each `execute()` wraps its body in `try/catch (\LogicException $e)`: the message is logged via
`$this->loggerFactory->error()` and re-thrown as `JsonRpcException::fromError(Error::internalError())`.
`create()` throws `DecoupledPasskeysUnexpectedValueException` if the plugin definition is not a
`MethodInterface`. The `register_device_options` and `register_device` methods also emit a
`debug()` log line containing the uid — a comment warns not to enable debug logging in production.

## Client flow (README)

Register: call `user.register_device_options` (no params) → `startRegistration(response)` →
call `user.register_device` with the stringified `attestation`.
Login: call `user.request_options` with `userHandle` (uid string) → `startAuthentication(response)`
→ call `user.authenticate_request` with the stringified `request` (and `userHandle`). The module
ships no frontend; `@simplewebauthn` is the suggested browser library.
