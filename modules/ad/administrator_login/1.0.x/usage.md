<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Administrator Login limits the login and password-reset forms to accounts that hold the `administrator` role.

---

Administrator Login is a tiny, configuration-free module for sites that should only ever be used by administrators (for example a staging environment or a staff-only build). Once enabled, it adds a validation handler to core's login form and password-reset form so that only accounts with the `administrator` role can submit them — any other username is rejected with an "unauthorised" message. It ships as a single procedural `.module` file: no settings page, no routes, no permissions, no schema. It depends only on core `user` and supports Drupal 10 and 11.

---

- Lock a staging or staff-only site so only administrators can use the login form.
- Reject login attempts from accounts that do not hold the `administrator` role.
- Restrict the password-reset (forgot-password) form to administrator accounts.
- Prevent non-admin accounts from requesting a one-time login link through the reset form.
- Add an admins-only layer without writing a custom module or access hook.
- Keep the standard core login page and theme — only the allowed accounts change.
- Deploy on a build where every legitimate user is already an administrator.
- Enable with zero configuration (no settings form to fill in).
- Depend only on core `user`, keeping the dependency surface minimal.
- Show a clear rejection message to non-admin users attempting to log in.
- Show a clear rejection message to non-admin users attempting a password reset.
- Use on Drupal 10 or Drupal 11 sites.
- Combine with a maintenance/closed-registration setup for a private site.
- Uninstall cleanly to restore normal login for all active accounts.
- Rely on the account's `administrator` role as the single allow condition.
- Avoid granting extra permissions — the module adds none of its own.
- Serve as a lightweight alternative to a full role-based access module for the login step.
- Keep admin credentials as the only path through the standard login form.
- Apply the same admin-only rule to both authentication and account recovery entry points on the form.
