<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Web Authentication (wa)

**Settings form:** `/admin/config/people/wa` (route `wa.admin_settings`,
permission `administer all user passkey`). **HTTPS is required** for WebAuthn.

## Settings

- **Enable Passkey Login** — global toggle; when off, the login button AND the `/wa/login/*`
  endpoints are inactive.
- **Allowed roles** — only users whose role is listed may register/use passkeys (owners), unless
  they hold `administer all user passkey`.
- **Allowed authenticators (AAGUID allowlist)** — deny-all by default; tick the authenticator
  models you accept, or add a custom AAGUID with a friendly label. Enforced at register + login.
- **User verification requirement** — require PIN/biometric for higher assurance.
- **Resident key requirement** — set **Required** to enable usernameless "Sign in with Passkey".
- **Enforce user handle** — stricter login validation (handle must be present + numeric).
- **Notification email** — subject/body (token-enabled) for the "new passkey added" mail.

## Routes / endpoints

| Route | Path | Method | Access |
|---|---|---|---|
| `wa.settings` | `/user/{user}/passkeys` | GET | `_wa_passkey_manage_access` |
| `wa.passkey_delete` | `/wa/passkey/delete` | POST | `_user_is_logged_in` |
| `wa.register_options` | `/wa/register/options` | POST | `_user_is_logged_in` (CSRF header, flood 10/300s) |
| `wa.register_verify` | `/wa/register/verify` | POST | `_user_is_logged_in` (flood 5/3600s) |
| `wa.login_options` | `/wa/login/options` | POST | `_access: TRUE` (flood 10/300s, Origin/Referer host-match) |
| `wa.login_verify` | `/wa/login/verify` | POST | `_access: TRUE` (flood 5/900s, blocks disallowed users before crypto) |
| `wa.admin_settings` | `/admin/config/people/wa` | — | `administer all user passkey` |

The `_access: TRUE` login routes are self-protected: flood-limited, config-gated, CSRF-checked
(`X-Requested-With` + Origin/Referer), one-time 120s CSPRNG challenge, session migration on success,
and `SafeLoginFinalizer` rejecting external redirects via `Url::fromUserInput()`.

## Extending — `hook_wa_login`

Invoked in `/wa/login/verify` after the assertion validates and before finalize. Implementations can
**veto** the login or return a **redirect** (used by `wa_email_otp` to insert an email-OTP step).

## wa_email_otp submodule

Email one-time-password step-up after passkey login. Enable it, then configure at
`/admin/config/people/wa/email-otp`. `OtpService` uses `bin2hex(random_bytes(32))` link hashes,
`password_hash()` for the code, session-bound entry (`/wa_otp/{uid}/{hash}`), a 60s validity window,
and flood limits (5/3600s per IP and per user).

## Admin passkey list

Views-based list at `/admin/people/passkeys` (field/filter plugin `wa_passkey_provider`) showing
provider label, created, and last-used per credential; admins can delete any user's passkey.
