<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Reset Landing Page (PRLP) lets a user set a brand-new password right on Drupal's one-time-login (password reset) landing page, instead of logging in first and then editing their account — so they choose a memorable password immediately.

---

PRLP alters the core `user_pass_reset` form (`hook_form_user_pass_reset_alter`) to add a `password_confirm` field ("Set New Password"), required by default. It then overrides the controller of the core `user.reset.login` route with its own `PrlpController::prlpResetPassLogin`, which runs the standard one-time-login validation and, when the login succeeds and the new password was entered, sets and saves the password on the user before redirecting. Two settings live in `prlp.settings`: `password_required` (boolean, whether the new-password field is mandatory) and `login_destination` (the path the user lands on after login; default `/user/%user/edit`, where `%user` is replaced with the uid and `%front` with the site front page). Both are edited at `/admin/config/people/accounts/prlp` (route `prlp.prlp_admin_settings`, permission `administer prlp settings`). Around the save, PRLP dispatches two events — `PrlpEvents::PASSWORD_VALIDATE` (`prlp.password_validate`) before validation and `PrlpEvents::PASSWORD_BEFORE_SAVE` (`prlp.password_before_save`) before the user is saved — which the bundled `prlp_password_policy` submodule uses to integrate the Password Policy module. Modules can also implement `hook_prlp_login_destination_alter()` to change the redirect path per user. If a bad destination is configured the module logs it and falls back to the original/default; an invalid or reused login link logs the user out with an error. No code or configuration is required beyond enabling the module.

---

- Let users set a new password the moment they click a password-reset email link.
- Make the new-password entry required so users can't skip choosing a memorable password.
- Make the new-password entry optional (just log in) via the settings form.
- Redirect users to their account edit page after a reset (the default).
- Redirect users to the site front page after a reset using the `%front` token.
- Redirect users to a custom onboarding/dashboard path after a reset.
- Use the `%user` token to send each user to a uid-specific path after login.
- Reduce repeat "forgot password" requests by letting users pick a password they'll remember.
- Improve first-login UX for newly created accounts that arrive via a one-time login link.
- Integrate password strength rules on the reset page (with the `prlp_password_policy` submodule).
- Enforce a site Password Policy at reset time, not just on the account form.
- Alter the post-reset destination programmatically with `hook_prlp_login_destination_alter()`.
- React to a password reset via the `prlp.password_before_save` event (e.g. audit logging).
- Add extra validation on the reset password via the `prlp.password_validate` event.
- Keep the standard one-time-login security (link expiry, flood control) while adding password entry.
- Streamline account recovery for support teams walking users through a reset.
- Provide a friendlier recovery flow than "log in, then go edit your account".
- Gracefully handle an invalid/expired reset link by logging out and prompting for a new one.
- Restrict who can change PRLP behavior with the `administer prlp settings` permission.
- Localize/relabel the reset landing page password prompt via translation.
- Ship the reset-and-set-password flow without writing a custom controller.
- Combine with core flood protection to throttle abusive reset attempts.
- Send users straight to a "complete your profile" page after their first reset login.
