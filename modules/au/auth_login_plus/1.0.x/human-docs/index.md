# Authenticator Login Plus — manual setup guide

**Authenticator Login Plus** (`auth_login_plus`) adds **two-factor authentication
(2FA)** to Drupal login using time-based one-time passwords (TOTP) — the six-digit
codes produced by authenticator apps such as Google Authenticator, Authy, or 1Password.
Users enroll by scanning a QR code, get a set of one-time backup codes for when their
phone is unavailable, and from then on must enter a valid code after their password
before they are actually logged in. It replaces the older `alogin` / `aloginplus`
modules.

The login flow is built to be safe by design. After a correct username and password,
the module does **not** finalize the Drupal session — it parks the login in a pending
state and sends the visitor to an OTP challenge at `/2fa/login`. Only when a valid TOTP
or backup code is accepted does the session actually start. TOTP verification is
replay-protected (a code cannot be reused), failed attempts are flood-limited per
account, and backup codes are single-use. Self-service reset uses a hashed, single-use,
one-hour link, and the REST login endpoint additionally requires an `mfa_token`. 2FA
secrets are encrypted at rest via a key provider.

Beyond individual enrollment, the module can **force** enrollment on protected or admin
routes so that staff cannot skip it, and it gives helpdesk staff a scoped "manage user
2FA" capability to reset, disable, or re-enable another user's 2FA without full admin
rights. Note that the current release is an early **alpha**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — the settings form, the user enrollment
   and challenge flow, admin management, and self-service reset.

## Where it lives in the admin menu

- **Settings:** **Configuration → People → Authenticator Login Plus**
  (`/admin/config/people/auth_login_plus/settings`), which requires the
  *Administer site configuration* permission.
- **Per-user 2FA management for admins/helpdesk:**
  **People → Authenticator Login Plus** (`/admin/people/auth_login_plus`), which
  requires the **`manage user 2fa`** permission.
- **User enrollment** happens at `/user/{user}/2fa-plus`, and the **OTP challenge** at
  `/2fa/login` during login.
