<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Time Restriction lets you limit when individual users may sign in and use the site. Each user gets a
`field_ltr_access_time` date/time-range field; when the module is enabled, login is refused outside the
allowed window and any active session is terminated (with a redirect to the login page) once the window
closes. An optional sticky countdown timer and a pre-expiry warning popup can be shown to logged-in
users. Depends on the [Time Range](https://www.drupal.org/project/time_range) module.

---

Enforcement happens in **two** places, server-side. (1) A login-form validate handler
(`login_time_restriction_user_login_validate`, added via `hook_form_alter` to `user_login_form`) loads the
account by name, computes the allowed start/end times (timezone-converted per the user's timezone), and
sets a form error if the current time is outside the window. (2) A response event subscriber
(`ValidRequestEventSubscriber`, priority 5 on `KernelEvents::RESPONSE`) re-checks on every request for the
logged-in user and, if the window has closed, calls `user_logout()` and redirects to
`user.login?access_logout=1`; when still valid it attaches drupalSettings for the JS timer/warning.
Config is at `/admin/login_time_restriction/settings` (`administer site configuration`) with options:
enable, per-day (time-only) vs date-range mode, error message, warning time (minutes), sticky timer.
Routes `/ltr_access-time-confirmed` and `/ltr_confirm_logout` require a logged-in user (the logout route
also requires a CSRF request-header token). Editing a user's access-time field is gated by the
`allow access time modification` permission (`restrict access: true`); users without it cannot see or set
their own window. Per-user timer state is tracked via the `user.data` service.

---

- Allow an employee to log in only during their shift hours.
- Restrict contractor accounts to business hours on specific dates.
- Auto-logout a user the moment their allowed window ends, mid-session.
- Show a countdown timer so users know when their session will end.
- Warn a user N minutes before forced logout via a popup.
- Enforce a fixed date range (e.g. an exam window) for a set of accounts.
- Enforce a daily recurring time window (per-day/time-only mode).
- Block off-hours logins for compliance or security policy.
- Convert the allowed window into the user's own timezone automatically.
- Prevent a user from staying logged in past their permitted time by re-checking every request.
- Keep the access-time field hidden from users who lack the modify permission.
- Delegate access-time management to a role via `allow access time modification`.
- Redirect blocked users to the login page with a custom error message.
- Temporarily grant a user access by widening their time-range field.
- Combine login-time gating with normal role permissions.
- Disable the feature globally with the "enable" toggle without removing config.
- Show a persistent sticky timer for time-limited kiosk/lab sessions.
- Terminate the session via the CSRF-protected `/ltr_confirm_logout` endpoint when time expires.
