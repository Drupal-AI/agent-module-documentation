<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Authenticator Login Plus

**Settings:** `auth_login_plus.settings_form` → `/admin/config/people/auth_login_plus/settings` (perm `administer site configuration`). Key toggles: `enabled` (2FA on), `enforce_redirect` (force enrollment), `allow_email_reset`, `post_verification_redirect` (front|destination|user page), `issuer`, `setup_ui_enabled`, `redirect_message`.

**User flow:**
1. User signs in with password; `auth_login_plus_user_login_form_submit()` diverts to `/2fa/login` (challenge) or `/user/{user}/2fa-plus` (enrollment) via a pending private-tempstore entry — no session yet.
2. `LoginChallengeForm` calls `UserTotpManager::verifyCode()` (TOTP or single-use backup code). On success `LoginChallengeManager::completeChallenge()` calls `user_login_finalize()`.
3. Enrollment (`UserEnrollForm`) confirms a code against the pending secret, persists it encrypted (`SecretStorage`), and issues backup codes.

**Admin management:** `/admin/people/auth_login_plus` (perm `manage user 2fa`) lists status; `/admin/people/auth_login_plus/{user}/{operation}` runs reset|disable|enable via a confirm form.

**Reset:** `/2fa/reset` emails a link to `/2fa/reset/confirm/{uid}/{token}`; the token is single-use, SHA-256 hashed, 1-hour TTL, `hash_equals`-checked (`UserTotpManager::consumeResetToken`).

**REST:** `RestLoginController` overrides `user.login.http` and requires `mfa_token` in the credentials body for 2FA-enabled accounts.

**Drush:** `AuthLoginPlusCommands` for enrollment management.
