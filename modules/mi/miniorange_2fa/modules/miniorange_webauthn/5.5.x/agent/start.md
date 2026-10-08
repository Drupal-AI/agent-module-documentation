# miniOrange WebAuthn Authenticator — agent index

Submodule of **miniOrange 2FA** ([parent](../../../../5.5.x/agent/start.md)) adding the `web-authn`
second-factor method (FIDO2 passkeys / security keys / platform biometrics) using
`web-auth/webauthn-lib`. WebAuthn attestation/assertion run **locally** (not via the miniOrange cloud).
No settings form of its own; enable WebAuthn as a method in the parent module. Requires a secure context
(HTTPS/localhost). Provides two permissions; stores a `mo_webauthn_credential` entity.

- **Endpoints, the credential entity, permissions/access checks, and how registration binds to the
  current user** → [configure/webauthn.md](configure/webauthn.md)

Key facts:
- Endpoints: `/mo-webauthn/attestation` (options, perm `mo_access_user_profile`),
  `/user/{user}/mo-webauthn/register-form` (form; renders openly but credential creation binds to the
  current user via the tempstore), `/user/{user}/mo-webauthn` (list),
  `/user/{user}/mo-webauthn/delete/{id}` (delete, perm `mo_access_user_profile`),
  `/mo-webauthn/assertion` + `/mo-webauthn/assertion/login` (login, perm `mo_anonymous_user`).
- `MoCurrentUserPredictor::findUser()` resolves the WebAuthn user from `currentUser->id()`, so
  attestation options are always for the logged-in user; `AuthenticatorAttestationResponseValidator`
  checks the challenge + request host before storing.
- Permissions (`miniorange_webauthn.permissions.yml`): `mo_access_user_profile` (register/manage own
  credentials), `mo_anonymous_user` (use WebAuthn at login — grantable to anonymous by design).
- Access check `WebAuthnDeviceFormAccessCheck`: allows `administer users`, else requires
  `mo_access_user_profile` AND current user == `{user}`.
