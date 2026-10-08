<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Authenticator Login Plus adds TOTP-based two-factor authentication to Drupal login, with QR-code enrollment, backup codes, optional enforced enrollment, and delegated admin management. It replaces the older alogin/aloginplus modules.

After a valid username/password the module holds the login in a private-tempstore pending state and diverts the visitor to an OTP challenge (`/2fa/login`) before any Drupal session is finalized — `user_login_finalize()` runs only once `verifyCode()` accepts a TOTP or backup code. TOTP verification is replay-protected (the matched time step must exceed the stored `last_verified_step`), flood-controlled per uid (10 failures / 15 min), and backup codes are single-use. Self-service reset uses a single-use, SHA-256-hashed, one-hour token compared with `hash_equals`; the REST login endpoint (`user.login.http`, overridden by `RestLoginController`) additionally requires an `mfa_token`. A `LoginEnforcementSubscriber` confines pending-login visitors and can force enrollment on protected routes. Secrets are encrypted at rest via a key provider.

Use it to require 2FA for staff/admin logins, let users self-enroll with an authenticator app, and give helpdesk staff a scoped "manage user 2FA" capability to reset or disable enrollments.
---
TOTP two-factor authentication for Drupal login with QR enrollment, backup codes, and delegated admin control.
---
- Require TOTP two-factor authentication at login
- Enroll a user with a scannable authenticator QR code
- Issue one-time backup codes at enrollment
- Enforce mandatory 2FA setup on protected/admin routes
- Verify OTP after password before the session is granted
- Reset a user's authenticator via a self-service emailed link
- Let helpdesk staff reset/disable/enable a user's 2FA (manage user 2fa)
- Require an mfa_token on the JSON/REST login endpoint
- Flood-limit failed OTP attempts per account
- Prevent OTP replay via monotonic time-step tracking
- Regenerate a fresh set of backup codes
- Disable 2FA enforcement without discarding the secret
- Re-enable 2FA using an existing stored secret
- Grant "bypass enforced 2FA redirect" to selected roles
- Theme the 2FA setup/challenge page
- Migrate from alogin / aloginplus
- Configure the issuer name shown in authenticator apps
- Sign in with a backup code when the device is lost
- Audit 2FA status for any user from the admin overview
- Run Drush commands to manage enrollment
