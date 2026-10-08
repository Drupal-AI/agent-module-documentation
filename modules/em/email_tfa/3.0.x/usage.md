<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email TFA adds email-based two-factor authentication: after a user logs in, the module emails them a one-time security code that they must enter on a verification page before their session is granted.

---

The module overrides Drupal's `user.login` form (and the `user.login.http` REST endpoint) via a route subscriber with its own login form. On successful authentication it generates a numeric one-time code, stores it in the private tempstore keyed by a `hash_salt`-based hash, and emails it using `hook_mail` (key `send_email_tfa`) with a customizable subject/body that supports the `[user:email_tfa]` token for the code. The user is redirected to `/tfa/verify/{uid}/{hash}` to enter the code, subject to a configurable timeout and flood control. Everything is driven by the single config object `email_tfa.settings`: a master `status` switch, a `tracks` mode (`globally_enabled` for everyone, or `optionally_by_users` where each user opts in through an `email_tfa_status` boolean base field added to the user entity), role targeting (`role_exclusion_type` = `disable_for` / `force_for` plus an `ignore_role` list), an "exclude user 1" toggle, `security_code_length` (4–9 digits), `timeouts` (seconds, min 60), `dev_mode` (prints the code on screen for testing), `flood_threshold`/`flood_window`, excluded `routes`, and fully translatable verification-form labels and messages. It also ships a user-login Block plugin and integrates with `gin_login` theming. A `hash_salt` must be set in `settings.php` for the module to work.

---

- Require every user to enter an emailed one-time code after logging in (global 2FA).
- Let users individually opt in to email 2FA via a checkbox on their account edit form.
- Force email 2FA only for privileged roles (e.g. editors, admins) with `force_for`.
- Exempt trusted roles from email 2FA using `disable_for` and an ignore-role list.
- Exclude the root user (user 1) from the 2FA flow during setup or recovery.
- Customize the OTP email subject and body, inserting the code with `[user:email_tfa]`.
- Set the security code length to anywhere from 4 to 9 digits.
- Control how long a code stays valid with the timeout setting (seconds, minimum 60).
- Rate-limit code requests/attempts per user with flood threshold and window settings.
- Turn on dev mode to display the code on-screen while testing without checking email.
- Translate the verification field labels, buttons, and success/failure messages per language.
- Customize the "Verify" and "Resend" button text on the verification form.
- Exclude specific routes (e.g. logout) from triggering the TFA verification interruption.
- Protect the REST login endpoint (`user.login.http`) as well as the web login form.
- Log Email TFA events (email sent / login) to the Drupal log for auditing.
- Place the Email TFA user-login block on a custom page via the provided block plugin.
- Style the verification page consistently when using the Gin Login module.
- Add a lightweight second factor without SMS or an authenticator app.
- Reduce account-takeover risk from stolen passwords by requiring email possession.
- Roll out 2FA gradually by starting in optional mode then switching to global.
- Brand the OTP email with your site name via the `[site:name]` token in the body.
- Enforce a minimum session-security posture for an intranet or admin-only site.
- Resend a fresh code from the verification form if the first email is delayed.
- Give a security team an on/off master switch (`status`) to enable 2FA site-wide instantly.
