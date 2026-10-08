<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# One Time Password — agent index

Authenticator-app **TOTP (RFC 6238)** two-factor authentication for Drupal accounts. Stores each user's
TOTP secret as an `otpauth://` provisioning URI in a hidden `one_time_password` base field on the user
entity (via **`spomky-labs/otphp`**; QR via **`endroid/qr-code`**; time via **`symfony/clock`**). Hooks the
standard login form, the one-time-login (password reset) link flow, and the REST `user.login.http`
endpoint. One config option (`force_otp`). Depends only on `drupal:user`. No Drush, no recovery codes.

- **Enrolment + the OTP verification/login flows** (setup form, login-form alter, `/otp` entry form,
  reset-link subscriber, REST X-OTP) → [forms/verification.md](forms/verification.md)
- **Settings form, `force_otp`, config schema, force-enrol subscriber** → [config/settings.md](config/settings.md)
- **The TOTP secret field, secret storage, developer API, hooks & subscribers** → [api/totp-field.md](api/totp-field.md)
- **Permission & access model** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Secret storage: a base field `one_time_password` of type `one_time_password_provisioning_uri`
  (`no_ui = TRUE`), one `uri` varchar(256) column, holding the full `otpauth://totp/...?secret=...` URI.
  Stored **in cleartext** in the DB (`users_field_data`-adjacent field table); not encrypted. Entity
  field access for this field is **always `forbidden`** (`UserFieldAttach::entityFieldAccess`), so it is
  never emitted through the entity/REST API.
- TOTP params are fixed to authenticator-app defaults: 30-second period, SHA1, 6 digits
  (`ProvisioningUriItemList::regenerateOneTimePassword()` uses `TOTP::generate($clock)`).
- Verification: `TOTP::verify($code, NULL, $leeway = 10)`. Replay protection stores the accepted window
  upper bound in `user.data` (`one_time_password` / `one_time_password_totp_time_window`) and rejects any
  code where `now - 10 <= last_accepted_window`.
- Flood control (shared by login form and `/otp` entry form): `UserLoginEnforce::FLOOD_THRESHOLD = 5`,
  `FLOOD_WINDOW = 3600`s, keyed both per-uid (`one_time_password.uid`) and per-IP (`one_time_password.ip`).
- Routes: `one_time_password.setup_form` `/user/{user}/two-factor-auth` (`_entity_access: user.update`);
  `one_time_password.settings` `/admin/config/people/one_time_password/settings`
  (`administer one time password settings`); `one_time_password.entry` `/otp/{uid}/{hash}`
  (anonymous-only, `_custom_access` `EntryForm::checkAccess`, `no_cache`, `_maintenance_access`).
- The only permission is `administer one time password settings` (`restrict access: true`). Enabling/
  disabling one's own 2FA needs no permission beyond `user.update` on the target account.
- `RouteSubscriber` re-points `user.login.http` to `UserAuthenticationController` (subclass of core's),
  requiring header `X-OTP` for TFA accounts.
- `force_otp` (bool, default unset) → `ForceOneTimePasswordSubscriber` redirects any authenticated user
  without a secret to the setup form (except setup/settings/logout/asset routes).
- `hook_requirements` (runtime) warns when non-cookie authentication providers are enabled (possible MFA
  bypass).
- No recovery/backup codes exist in 2.x: a user who loses their authenticator must have an admin disable
  2FA on the account.
