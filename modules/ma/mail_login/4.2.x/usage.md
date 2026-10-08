Mail Login lets users sign in with their email address in addition to (or instead of) their username, with optional relabelling of the login and password-reset form fields.

---

Mail Login decorates Drupal core's `user.auth` authentication service (`AuthDecorator`, decorating `user.auth`) so that when a login identifier looks like an email address (`filter_var(..., FILTER_VALIDATE_EMAIL)`) it is resolved to the matching user account by the `mail` property before authentication. A single config object, `mail_login.settings`, holds all behavior: `mail_login_enabled` turns email login on, `mail_login_email_only` disables username login entirely (rejecting non-email identifiers with an error), and `mail_login_case_sensitive` controls whether email matching respects RFC 5321 case sensitivity (a case-insensitive match is only accepted when exactly one account matches). A `hook_form_alter()` on `user_login_form` and `user_pass` injects a `mail_login_validate_authentication` validator (ordered before core's `::validateFinal`) that translates a submitted email to the canonical username so Drupal's flood control still keys on one consistent identifier, and — when `mail_login_override_login_labels` is on — swaps in custom titles/descriptions for the username, password and password-reset fields. Blocked accounts are rejected with a message. The admin settings form lives at **Admin → Configuration → People → Mail Login** (`/admin/config/people/mail-login`, route `mail_login.admin`) behind the `administer mail login` permission, and all label fields are translatable via config schema. The module has no external dependencies and defines no submodules. Unlike `login_emailusername` (which core-patches the login flow and adds a username-in-registration option), Mail Login works purely by decorating the auth service and altering the two forms, and it adds an explicit "email only" mode plus case-sensitivity handling rather than registration-side changes.

---

- Let existing users log in with their email address instead of remembering a username.
- Accept either username or email in the same login field (default behavior once enabled).
- Force email-only login by enabling `mail_login_email_only`, disabling username sign-in.
- Show a clear error ("Login by username has been disabled. Use your email address instead.") when a username is entered in email-only mode.
- Relabel the login form's username field title and description for clarity.
- Relabel the password field description when in email-only mode.
- Customize the password-reset form's field title and description to mention email.
- Provide separate label sets for the mixed username/email mode versus email-only mode.
- Translate all login/reset labels per language via translatable config schema.
- Make email matching case-insensitive so `User@example.com` matches `user@example.com` when unique.
- Keep email matching case-sensitive (RFC 5321 compliant) to guarantee uniqueness when duplicates could exist.
- Preserve Drupal flood control by resolving an email to its canonical username before rate-limit checks.
- Reject login attempts from blocked or not-yet-activated accounts with an informative message.
- Configure everything from one admin screen at `/admin/config/people/mail-login`.
- Gate access to the settings form with the dedicated `administer mail login` permission.
- Deploy login behavior between environments by exporting the `mail_login.settings` config object.
- Enable email login on a members' site where users identify themselves primarily by email.
- Reduce support requests from users who forget their username but know their email.
- Roll out email login with minimal setup (sensible defaults ship enabled out of the box).
- Toggle email login on or off site-wide by flipping `mail_login_enabled`.
- Keep username login available as a fallback while still allowing email login (default, non-email-only).
- Override only the labels you need while leaving authentication behavior unchanged.
- Cleanly remove all module config on uninstall (settings are deleted in `hook_uninstall()`).
- Support sites migrated from platforms where email was the primary login credential.
