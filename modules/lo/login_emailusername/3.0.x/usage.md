Login with Email or Username lets people sign in with EITHER their username OR their email address from the same input box on Drupal's standard login form. It keeps the username field — it just also accepts an email in it.

---

This very simple module improves the standard Drupal login flow without adding any content type, config entity, or settings. On the HTML login form (`user_login_form`) it implements `hook_form_FORM_ID_alter()` to relabel the `name` field to "Username or email address", update its description, and attach an extra element-validate handler. That handler (`login_emailusername_user_login_validate`) tries `user_load_by_name()` first; if no account matches, it falls back to `user_load_by_mail()` and, on a hit, rewrites the submitted `name` value to that account's real username so core's normal authentication proceeds unchanged. For the JSON/REST HTTP endpoints, a `RouteSubscriber` swaps the controllers on the `user.login.http` and `user.pass.http` routes to a subclass of core's `UserAuthenticationController` that applies the same email-to-username resolution before flood control and account lookup. The password-reset endpoint accepts a `name` or `mail` credential and looks the account up by either. Unlike `email_registration`, it does NOT hide or replace the username — accounts still have and use a username; email simply becomes an accepted login identifier. It depends only on core `user`, requires Drupal `^10.3 || ^11.0`, has no permissions, and has no configuration options — enabling the module is all that is required.

---

- Let users log in with their username on the standard login form as before.
- Let the same users log in with their email address in the same input box.
- Relabel the login "Username" field to "Username or email address" automatically.
- Update the login field description to tell users either identifier is accepted.
- Keep usernames intact (unlike email_registration, which replaces the username field).
- Resolve a submitted email to the matching account's username before authentication.
- Fall back to email lookup only when no username matches the input.
- Reduce login friction for users who remember their email but not their username.
- Support email-based login on the JSON:API/REST `user.login.http` endpoint.
- Support email-based login for decoupled or mobile app authentication requests.
- Accept either `name` or `mail` on the REST password-reset (`user.pass.http`) endpoint.
- Trigger a password-reset email by supplying an email address as the `name` credential.
- Trigger a password-reset email by supplying a username as the `mail` credential.
- Preserve core flood control and blocked-account checks during email login.
- Add "log in with email" without writing a custom form alter or authentication controller.
- Enable email login on a site that intentionally keeps meaningful usernames.
- Provide a LoginToboggan-style email-login convenience on Drupal 10.3+/11.
- Deploy the behavior with zero configuration — just enable the module.
- Avoid storing any extra config, so nothing new needs exporting between environments.
- Give support teams one login box to explain instead of separate email/username fields.
- Let editors who were invited by email sign in with that email immediately.
- Keep a single authentication path for both web form and API clients.
- Uninstall cleanly to revert to username-only login with no leftover config.
