<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an admin-editable "Password Link Reset Timeout" field to Drupal's account settings form so you can change how long a one-time password-reset login link stays valid, without editing settings.php.

---

Drupal core stores the lifetime of one-time login (password reset) links in the `user.settings:password_reset_timeout` config value (default 86400 seconds / 24 hours), and core's password-reset flow already honours it — but core ships no admin UI to change it, so normally you must edit `$settings['user.settings']['password_reset_timeout']` in `settings.php`. Expired Reset Pass Link is a UI-only module that fills that gap: it uses `hook_form_user_admin_settings_alter()` (in `ExpiredResetPassLinkHooks::formUserAdminSettingsAlter()`) to add an "Expired Reset Password Link" details group with a numeric "Password Link Reset Timeout" field (seconds, min 1, max 31536000 = one year) to the account settings form at `/admin/config/people/accounts`. A submit handler writes the value back to the same `user.settings:password_reset_timeout` config key (falling back to 86400 if left empty). It requires only Drupal core, adds no routes, permissions, entities, plugins or config of its own, and does not change how core generates or validates the reset token — it only exposes the existing lifetime setting.

---

- Change how long a password-reset link is valid from the Drupal admin UI instead of editing `settings.php`.
- Shorten the one-time login link lifetime (e.g. to 15 or 30 minutes) to tighten your reset-link policy.
- Lengthen the reset window (up to one year) for users who are slow to check email or on infrequent-login sites.
- Restore the default 24-hour (86400 second) lifetime by clearing the field (empty falls back to 86400).
- Let a non-developer site administrator manage reset-link expiry without server/file access.
- Standardise the reset-link timeout as part of your site's account-settings configuration.
- Export the resulting `user.settings:password_reset_timeout` value with your configuration sync for reproducible deployments.
- Set a stricter timeout to comply with an internal or client security/password policy.
- Reduce the window in which an intercepted reset email link could be used, by lowering the timeout.
- Give support staff a visible, self-documented setting on the accounts form rather than a hidden settings.php line.
- Configure the timeout per environment (dev/stage/prod) through normal Drupal config overrides.
- Verify or audit the current reset-link lifetime at a glance on `/admin/config/people/accounts`.
- Pair with a password-policy or account-security module to present all account controls in one place.
- Adjust reset-link expiry for a multisite where each site needs a different value.
- Onboard a new site by setting the reset timeout during initial account-settings configuration.
- Provide a UI equivalent of the documented `$settings['user.settings']['password_reset_timeout'] = 86400;` override.
- Test different timeout values quickly when tuning the account-recovery experience.
- Keep the reset-timeout setting under the same access control (`administer account settings`) as other core account options.
- Remove the module cleanly later; the value simply remains in `user.settings` as core config.
