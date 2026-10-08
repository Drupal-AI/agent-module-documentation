TFA (Two-factor Authentication) is a pluggable base module that adds a required second authentication step — a one-time code from an authenticator app, a recovery code, or a trusted-browser cookie — on top of Drupal's username/password login.

---

TFA overrides the core `user.login`, `user.login.http`, and `user.reset.login` routes so that when a user with TFA configured (or a role required to use TFA) signs in, they are redirected to a second-factor entry form before the login is finalized. It ships validation plugins for time-based (TOTP) and counter-based (HOTP) one-time passwords, a recovery-code plugin, and a "trusted browser" login plugin that lets a user skip the second step on a remembered device. Secrets (OTP seeds and recovery codes) are encrypted at rest through the Encrypt module using an admin-selected encryption profile, and validated codes are recorded to block replay. Administrators configure the module globally at `/admin/config/people/tfa` — enabling TFA, choosing which validation plugins users may set up, which roles are required to use TFA, flood-control thresholds, and the notification emails — while each user manages their own methods at `/user/{user}/security/tfa`. Flood control (per-uid by default) throttles failed code attempts, and a configurable number of "skips" can let users log in a limited number of times before they must finish setup. The module defines four plugin types (`TfaValidation`, `TfaSetup`, `TfaLogin`, `TfaSend`) so contrib modules can add SMS delivery, third-party services, or alternative validators. It also provides Drush commands to reset a user's TFA data and to sanitize TFA data during `sql-sanitize`, a block that replaces the core login block, and a Views field showing whether an account has TFA enabled.

---

- Require administrators and other privileged roles to use two-factor authentication for compliance (e.g. PCI DSS 8.3.1).
- Let users protect their accounts with an authenticator app such as Google Authenticator, Microsoft Authenticator, FreeOTP, or Authy via TOTP.
- Offer HMAC-based one-time passwords (HOTP) as an alternative to time-based codes.
- Generate one-time recovery codes so a user can regain access if they lose their device.
- Allow users to mark a browser as trusted so they are not prompted for a code on every login for a configurable number of days.
- Encrypt OTP seeds and recovery codes at rest using an Encrypt module encryption profile (OpenSSL-backed).
- Enable TFA globally and choose the default and allowed validation plugins from the settings form.
- Restrict which roles are required to configure TFA, and grant a limited number of login "skips" before setup is mandatory.
- Redirect users who have not yet configured TFA to their setup page immediately after login.
- Throttle brute-force code guessing with configurable flood window and threshold, keyed by uid only or by uid+IP.
- Let administrators with the right permission set up, reset, or disable TFA on behalf of other users (using their own password to confirm).
- Reset a locked-out user's validation-skip counter from the TFA overview page.
- Customize the emails sent when a user enables or disables TFA, using site and user tokens.
- Present a QR code plus a text seed during setup so users can provision their authenticator app.
- Replace the core user-login block with a TFA-aware login block.
- Show a "TFA enabled" boolean column in a Views listing of users to audit adoption.
- Reset an individual user's TFA data from the CLI with `drush tfa:reset-user`.
- Automatically strip TFA seeds and recovery codes when running `drush sql-sanitize` for safe database copies.
- Block the JSON `user.login.http` endpoint for TFA-enabled accounts so REST logins cannot bypass the second factor.
- Enforce TFA during one-time password-reset login links, with an optional bypass for the super administrator.
- Support alternate second-factor methods on the entry form so a user can switch to recovery codes when their primary device is unavailable.
- Extend the system with custom validation, setup, login, or send plugins (for example SMS delivery or third-party 2FA services).
