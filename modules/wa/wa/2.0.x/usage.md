<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Web Authentication (wa) implements passwordless passkey / WebAuthn (FIDO2) login for Drupal, with an optional email-OTP step-up submodule.

---

Users register authenticators (Touch ID, Face ID, Windows Hello, YubiKeys, password managers) against their account and sign in with them using the `web-auth/webauthn-lib` v5 library. Credentials are stored in a custom `wa` table (uid, raw credential id, public key, credential hash, user handle, sign counter, transports, aaguid, timestamps) and surfaced through a Views admin list at `/admin/people/passkeys` and a per-user "Passkeys" tab at `/user/{user}/passkeys`. Registration is a two-step AJAX/JSON flow: `POST /wa/register/options` (CSRF `X-CSRF-Token` header, flood-limited, role- and config-gated) issues `PublicKeyCredentialCreationOptions` with a 32-byte CSPRNG challenge held in session for 120s; `POST /wa/register/verify` validates the attestation via `WebAuthnService`, enforces the allowed-AAGUID list, rejects duplicates by SHA-256 hash, stores the credential, and emails a notification. Login mirrors this: `/wa/login/options` returns a fresh challenge; `/wa/login/verify` looks up the credential, blocks disallowed users before the expensive crypto, validates the assertion, updates the sign counter, invokes `hook_wa_login`, migrates the session (fixation defense), and finalizes via `SafeLoginFinalizer`.

`SafeLoginFinalizer` is the notable hardening piece: it wraps `user_login_finalize()` while intercepting redirect injections from other login modules and validating every redirect candidate through `Url::fromUserInput()` so only local paths survive (open-redirect defense). This module has been security-reviewed and is SOUND — challenges are `random_bytes(32)`, assertions are verified with `AuthenticatorAssertionResponseValidator`, user handles are validated with `ctype_digit` before query use, and flood control guards every endpoint. The `wa_email_otp` submodule adds an email one-time-password step after passkey login (demonstrating `hook_wa_login`): its `OtpService` uses `bin2hex(random_bytes(32))` link hashes, stores the OTP with `password_hash()`, binds the entry form to a session uid, enforces a 60s validity window, and flood-limits attempts. Admins configure allowed roles, an AAGUID allowlist (deny-all default), user-verification and resident-key requirements, and notification text at `/admin/config/people/wa`. HTTPS is required.

---

- Enable passwordless passkey login for the site.
- Register a Touch ID / Face ID passkey on a user account.
- Register a YubiKey or other hardware security key.
- Register a password-manager passkey (1Password, Bitwarden, iCloud).
- Sign in with the usernameless "Sign in with Passkey" button.
- Add multiple passkeys per user.
- Delete one's own passkey from the profile tab.
- Let an admin manage/delete passkeys for any user.
- View a site-wide passkey list at `/admin/people/passkeys`.
- Restrict passkey usage to specific roles.
- Restrict allowed authenticator models via the AAGUID allowlist.
- Add a custom AAGUID with a friendly label.
- Require user verification (PIN/biometric) for higher assurance.
- Require resident keys to enable usernameless login.
- Enforce user-handle presence for stricter login validation.
- Globally disable passkey login (kills the button and the API endpoints).
- Email users automatically when a new passkey is added.
- Customize the passkey-added notification subject/body with tokens.
- Add an email-OTP step after passkey login via wa_email_otp.
- Configure the OTP email subject and body.
- Resend an OTP from the entry form.
- Block or redirect login programmatically via `hook_wa_login`.
- Rate-limit brute force via flood control on register/login/OTP.
- Trace failures via ticket IDs in the logs.
- Support reverse-proxy client-IP resolution for accurate flood keying.
