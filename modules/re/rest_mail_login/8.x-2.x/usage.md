<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Email Login lets front-end/decoupled clients log in with an email address and password via a JSON POST, instead of Drupal's default username-based `/user/login` REST route.

---

The module exposes a single route `POST /user/email-login` (`_format: json`, `_user_is_logged_in: FALSE`). Its controller extends core's `UserAuthenticationController`: it reads `credentials.mail`, looks the account up with `user_load_by_mail()`, swaps the resolved username into the credentials as `name`, and then calls the parent `login()` method. Password verification, flood control and the returned CSRF/logout tokens are all handled by core's authentication controller — this module only translates email to username. There are no permissions, config, or services of its own. Because the account is resolved from a submitted email, an unknown email returns a distinct 400 error, which is a mild user-enumeration signal; rate limiting is only whatever core flood control provides on the username. The password field is still required, so it is not an authentication bypass.

---

- Let a decoupled React/Vue front-end authenticate users by email + password.
- Support mobile apps that collect an email rather than a Drupal username.
- Return a CSRF token and user id for subsequent authenticated REST calls.
- Reuse core's password checking and flood protection unchanged.
- Avoid exposing internal usernames to the login UI.
- Provide an email-first login for sites where usernames are opaque.
- Drop-in alongside core REST user authentication routes.
- Feed the returned token into `X-CSRF-Token` for write operations.
- Keep login JSON-only for API consumers.
- Migrate SPA logins from username to email without custom code.
- Bridge external identity forms that only know a user's email.
- Serve as a thin example of extending UserAuthenticationController.
- Pair with HTTPS to protect credentials in transit.
- Combine with a password-reset flow keyed on email.
- Restrict to anonymous callers via the `_user_is_logged_in: FALSE` requirement.
