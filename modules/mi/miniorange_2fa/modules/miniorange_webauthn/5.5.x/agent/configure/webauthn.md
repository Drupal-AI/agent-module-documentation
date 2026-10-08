# WebAuthn endpoints, entity & access

No settings page. WebAuthn is enabled as a 2FA method through the parent module; this submodule provides
the credential entity, the browser-API endpoints, and the local attestation/assertion logic
(`web-auth/webauthn-lib`).

## Routes (`miniorange_webauthn.routing.yml`)

| Route | Path | Access | Purpose |
|---|---|---|---|
| `mo_webauthn.register.options` | `/mo-webauthn/attestation` | perm `mo_access_user_profile` | Returns attestation (creation) options JSON; stores them + the user entity in the private tempstore. |
| `mo_webauthn.register_form` | `/user/{user}/mo-webauthn/register-form` | `_access: TRUE` | Renders the registration form. **The permission is commented out**, so the form itself is open — but see the binding note below. |
| `mo_webauthn.read_configuration` | `/user/{user}/mo-webauthn` | `WebAuthnDeviceFormAccessCheck` | Lists the user's `mo_webauthn_credential` entities. |
| `mo_webauthn.remove_configuration` | `/user/{user}/mo-webauthn/delete/{id}` | perm `mo_access_user_profile` | Delete a credential. |
| `mo_webauthn.login.options` | `/mo-webauthn/assertion` | perm `mo_anonymous_user` | Assertion (login) options JSON. |
| `mo_webauthn.login.resp` | `/mo-webauthn/assertion/login` | perm `mo_anonymous_user` | Verifies the assertion and completes WebAuthn login. |

## Permissions (`miniorange_webauthn.permissions.yml`)

- `mo_access_user_profile` — "Register WebAuthn credentials" (manage your own).
- `mo_anonymous_user` — "Use WebAuthn login" — meant to be grantable to **anonymous** so the assertion
  endpoints are reachable during the login challenge (by design for a login mechanism).

`WebAuthnDeviceFormAccessCheck::access()`: allowed if the account has `administer users`; otherwise
requires `mo_access_user_profile` **and** `account->id() === {user}->id()` (own credentials only).

## Why the open `register_form` route is not an account-takeover vector

Although `/user/{user}/mo-webauthn/register-form` is `_access: TRUE`, the credential it creates is **not**
bound to the `{user}` URL parameter:

- The attestation options are produced by `MoAttestationReqController` (`/mo-webauthn/attestation`), which
  requires `mo_access_user_profile` and calls `MoCurrentUserPredictor::findUser()` →
  `currentUser->id()`. The resulting `PublicKeyCredentialUserEntity` (with the server-set `userHandle`) is
  stored in the **private, per-session** tempstore.
- On submit, `RegistrationForm` reads those options from the tempstore, verifies the attestation with
  `AuthenticatorAttestationResponseValidator` (challenge + request host), and stores the credential under
  the `userHandle` from the options — i.e. the current authenticated user — not the URL `{user}`.

So an attacker cannot register their authenticator against a victim's account by changing the URL: without
valid attestation options (which require the permission and bind to the current user) the submit fails.

## Credential entity

- Content entity `mo_webauthn_credential` (`src/Entity/MoWebauthnCredential.php`), list builder
  `MoWebauthnCredentialListBuilder`. Repositories under `src/MoRepo/` (`MoPubKeyCredSourceRepo`,
  `MoPubKeyCredUserRepo`) persist and look up credential sources by user handle / credential id.
- Registration form enforces per-user **label uniqueness** (`validateLabel` / `checkDuplicate`).

## Requirements

Browser WebAuthn requires a secure context (HTTPS or `localhost`). The JS lives in
`js/mo-webauthn-register.js` / `mo-webauthn-login.js`; server verification uses `web-auth/webauthn-lib`.
