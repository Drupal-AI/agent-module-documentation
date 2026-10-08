<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login with email only removes the username as a login option: the login form's single identifier box accepts an email address and nothing else, and the "Forgot your password" form is relabelled to ask for an email too.

---

This is one of the smallest useful modules in the campaign — a single hook file plus its info, README and licence. All the behaviour lives in `login_onlyemail.module`, which uses `hook_form_FORM_ID_alter()` to change two core forms. On the user login form it relabels the identifier field to "Email address" and appends a validator that resolves the typed email to an account with `user_load_by_mail()`, then hands the resolved account name to core's normal password and flood-control checks; the result is that usernames no longer work at login. On the forgot-password form it applies the same relabelling and an email lookup. There is no configuration form, no permission, no schema and no service; enabling it is the entire setup. That simplicity is also its limitation: the change is site-wide and unconditional, so there is no per-role or per-path exemption, and a site that still wants usernames to work at login needs a different module (`email_registration` or `mail_login` accept either). Because it only changes the *login* and *password-reset* forms, usernames continue to exist and are still shown wherever Drupal displays an account name — this module does not make the email address the display name. One operational caveat from the README: disable it before running core integration tests that call `drupalLogin()`, which submits a username.

---

- Let users log in with only their email address.
- Remove the "username or email" ambiguity from the login form.
- Match the login experience users expect from other web services.
- Avoid users forgetting a username they never deliberately chose.
- Relabel the forgot-password form to ask for an email address.
- Simplify support requests about which identifier to use at login.
- Pair with automatic username generation on registration.
- Reduce login-form friction on a consumer-facing site.
- Enforce email as the sole credential identifier at sign-in.
- Keep usernames for display while dropping them from login.
- Standardise the login experience across several sites in an estate.
- Cut a field from a mobile login form.
- Migrate a site to email-first authentication with no config step.
- Deploy a login change that needs only `drush en`.
- Provide a predictable identifier for password-reset flows.
- Align Drupal login with an external CRM keyed on email.
- Remove a source of user error at sign-in.
- Test whether email-only login suits a site, reversibly.
- Present a single, obvious identifier field to non-technical users.
- Stop users from having to remember two separate credentials.
- Roll email-only login out site-wide without touching individual roles.
- Reverse the change instantly by uninstalling the module.
