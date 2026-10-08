<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authenticator Login Plus (auth_login_plus) — agent index

**TOTP two-factor authentication for login: QR enrollment, backup codes, enforced enrollment, delegated admin management.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^10 || ^11 || ^12
- **Configure route:** `auth_login_plus.settings_form` → `/admin/config/people/auth_login_plus/settings` (perm `administer site configuration`)
- **Key routes:** `auth_login_plus.login_challenge` `/2fa/login` (`_access: TRUE`, acts only on a valid pending-login tempstore), `auth_login_plus.user_enroll` `/user/{user}/2fa-plus`, `auth_login_plus.reset_confirm` `/2fa/reset/confirm/{uid}/{token}` (single-use hashed token), `auth_login_plus.admin_overview` `/admin/people/auth_login_plus` (perm `manage user 2fa`)
- **Key services:** `login_challenge_manager`, `user_totp_manager`, `totp`, `backup_codes`, `secret_storage`, `login_enforcement_subscriber`
- **Permissions:** `manage user 2fa`, `auth_login_plus bypass enforced redirect` (both restricted)
- **Security:** verified sound. `user_login_finalize()` runs only after `verifyCode()` succeeds; TOTP is replay-protected (step > last_verified_step) and per-uid flood-limited; reset tokens are single-use, hashed, time-limited, `hash_equals`-compared; REST login requires `mfa_token`. The open `/2fa/*` routes only act on an existing pending-login tempstore. No auth bypass found.

See [configure/settings.md](configure/settings.md)
