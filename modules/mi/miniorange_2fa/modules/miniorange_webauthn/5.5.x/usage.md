Submodule of miniOrange 2FA that adds WebAuthn (FIDO2 passkeys / security keys / platform biometrics like Windows Hello and Touch ID) as a second factor, handling credential registration and login assertions locally via the `web-auth/webauthn-lib` library.

---

`miniorange_webauthn` implements the `web-authn` authentication method for miniOrange 2FA using the PHP `web-auth/webauthn-lib` (v5). Unlike the cloud-delegated OTP methods, WebAuthn attestation and assertion are performed **locally** on the Drupal site. It stores credentials in a `mo_webauthn_credential` content entity and exposes JSON endpoints for the browser WebAuthn API: attestation options + registration (`/mo-webauthn/attestation`, `/user/{user}/mo-webauthn/register-form`), a credential list/delete UI (`/user/{user}/mo-webauthn`, `.../delete/{id}`), and assertion options + login response for authentication (`/mo-webauthn/assertion`, `/mo-webauthn/assertion/login`). Credential creation options are built server-side and bound to the **current** authenticated user (`MoCurrentUserPredictor` resolves `currentUser->id()`), then held in the private tempstore; the `AuthenticatorAttestationResponseValidator` verifies the attestation against the stored challenge and the request host before persisting. Two permissions gate it — `mo_access_user_profile` (register/manage your own credentials; the credential-form access check also requires the current user to match the `{user}` in the URL, or hold `administer users`) and `mo_anonymous_user` (use WebAuthn at login, intended to be grantable to anonymous so the assertion login endpoints are reachable during authentication). It has no settings form of its own; WebAuthn is chosen as a 2FA method through the parent module. Requires an HTTPS/localhost secure context (browser WebAuthn requirement).

---

- Let users register a hardware security key (e.g. YubiKey) as a second factor.
- Use platform authenticators — Windows Hello, Touch ID, Face ID — for 2FA.
- Support FIDO2 passkeys for phishing-resistant login.
- Register multiple named WebAuthn devices per user.
- List a user's registered WebAuthn credentials.
- Delete/revoke a specific WebAuthn credential.
- Authenticate at login by tapping a security key / biometric prompt.
- Keep WebAuthn attestation/assertion entirely on-site (no cloud OTP round-trip for this method).
- Verify attestation challenges server-side before storing a credential.
- Bind each credential to the current user (registration cannot be aimed at another account via the URL).
- Provide passwordless-style strong 2FA alongside the parent module's policies.
- Give admins the ability to manage any user's WebAuthn credentials (`administer users`).
- Enforce label uniqueness per user when naming a device.
- Offer a phishing-resistant alternative to OTP for high-value accounts.
- Combine with miniOrange 2FA role/domain policies to require WebAuthn for specific roles.
