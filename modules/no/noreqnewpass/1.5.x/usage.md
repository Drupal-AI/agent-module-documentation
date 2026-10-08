<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
No Request New Password removes Drupal's "Request new password" (forgotten-password) flow from a site, so end users can no longer trigger a password-reset email from the login form or the `/user/password` page.

---

The module adds a single boolean setting, `noreqnewpass_disable`, in the config object `noreqnewpass.settings_form` (admin form at `/admin/config/people/noreqnewpass`, gated by the `administer noreqnewpass` permission). When that flag is TRUE the module does three things at once: a route subscriber (`RouteSubscriber::alterRoutes`) sets `_access: FALSE` on the core `user.pass` and `user.pass.http` routes so `/user/password` and its REST sibling return access-denied; a `hook_form_alter` on `user_login_form` and `user_login_block` swaps core's `::validateFinal` login validator for the module's own `validateForm` (which re-implements flood registration and the generic "Unrecognized username or password." error without steering the user toward a reset link); and a `hook_preprocess_block__user_login_block` unsets the `request_password` link item so it disappears from the user login block. When the flag is FALSE the module is inert and core behaves normally. There are no plugins, no Drush commands, and no dependencies beyond Drupal core. A D7-to-D-current migration (`newreqnewpass_settings`) maps the old `noreqnewpass_disabled` variable into the new config key.

---

- Prevent end users from ever requesting a password-reset email on a closed or invite-only site.
- Force all password changes to go through an administrator instead of self-service reset.
- Hide the "Reset your password" / "Request new password" link under the login form.
- Remove the `request_password` link from the user login block placed in a sidebar or footer.
- Lock down the `/user/password` route so it returns access-denied for everyone.
- Also block the REST/HTTP password-reset endpoint (`user.pass.http`) on a decoupled site.
- Harden a site where accounts are provisioned by SSO/LDAP and local resets should not exist.
- Reduce a phishing/enumeration surface by removing the forgot-password entry point.
- Keep the standard login form but strip only its self-service recovery affordance.
- Suppress the password-reset path on a staging or internal environment.
- Comply with a policy that mandates helpdesk-mediated password changes.
- Avoid password-reset emails on a site with no reliable outbound mail configuration.
- Turn the behavior on or off site-wide from one checkbox without touching code.
- Grant a trusted non-admin role rights to toggle the setting via `administer noreqnewpass`.
- Migrate a Drupal 7 site that used the original noreqnewpass variable to modern config.
- Preserve core flood protection (IP and per-user login throttling) while removing reset.
- Present a generic "Unrecognized username or password." error with no reset hint.
- Disable password recovery for a kiosk or shared-terminal deployment.
- Enforce that only users with `administer users` can change other people's passwords.
- Keep the login block usable while removing its recovery link across all themes.

