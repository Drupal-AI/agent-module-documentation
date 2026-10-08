<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Authentication (wa) — agent index

**Passwordless passkey / WebAuthn (FIDO2) login for Drupal, with an optional email-OTP step-up submodule.**

- **Version:** 2.0.x (2.0.0-rc7)
- **Core:** `^10.5 || ^11.2`
- **Dependencies:** `drupal:user`, `drupal:views`
- **Configure:** `wa.admin_settings` → `/admin/config/people/wa`
- **Submodule:** `wa_email_otp` (email OTP step-up after passkey login).

Key surfaces:
- Routes: `/wa/register/options|verify` and `/wa/passkey/delete` (`_user_is_logged_in`), `/wa/login/options|verify` (`_access: TRUE`, self-protected), `/user/{user}/passkeys` (`_wa_passkey_manage_access`), admin `/admin/config/people/wa` (`administer all user passkey`).
- Services: `wa.webauthn` (`WebAuthnService`), `wa.safe_login_finalizer`, `wa.ticket_service`, `wa.passkey_labeler`, `wa.passkey_manage_access_check`.
- Permission: `administer all user passkey`.
- Credentials in a custom `wa` DB table; Views field/filter `wa_passkey_provider`.

See [configure/wa.md](configure/wa.md) for settings, the AAGUID allowlist, the register/login endpoints, and `hook_wa_login`.

**Security:** Reviewed SOUND. The `_access: TRUE` login/options routes are not open — they are flood-limited, config-gated, and enforce Origin/Referer host-match; `/wa/login/verify` blocks disallowed users before crypto, migrates the session (fixation defense), and finalizes through `SafeLoginFinalizer`, which rejects external redirects via `Url::fromUserInput()`. Challenges use `random_bytes(32)`; assertions are verified with the webauthn-lib validator; user handles are `ctype_digit`-validated. wa_email_otp uses `bin2hex(random_bytes(32))` link hashes, `password_hash()` OTPs, session binding, 60s expiry, and flood limits. No findings.
