Makes the Drupal username login comparison case-sensitive by adding a validate handler to the core user login form.

---

Core Drupal treats usernames case-insensitively at login, so the account `admin` can be reached with `admin`, `Admin`, or `ADMIN`. This module implements `hook_form_user_login_form_alter()` to append a custom validate handler that looks up the submitted name against `users_field_data` with an exact `=` condition and, when no matching user is found, rejects the login with a generic "Unrecognized username or password" error. The check is purely additive: it layers on top of core's own name, authentication, and flood validators rather than replacing them, and it never authenticates anyone by itself. There is no configuration, no permissions, no routes, and no services — installing the module is the only step. Note that the effective behavior depends on the collation of the `users_field_data.name` column: on a case-insensitive collation (the common MySQL default) the `=` comparison still matches regardless of case, so the module can be a no-op unless the column/DB uses a case-sensitive (binary) collation. It affects the interactive login form only and does not alter registration, password reset, or programmatic logins.

---

- Enforce exact-case usernames at the login form so `admin` and `Admin` are treated as distinct login inputs.
- Prevent users from logging in with a differently-cased variant of their registered username.
- Add a case-sensitivity layer to an existing site without changing any core authentication code.
- Harden a login page as part of a broader account-security posture (paired with a case-sensitive DB collation).
- Standardize username entry so support/onboarding docs can specify one canonical casing.
- Reduce accidental logins to the wrong account when two visually similar names differ only by case.
- Match the login behavior of an upstream system that itself treats usernames case-sensitively.
- Satisfy an internal policy that requires exact-match credential entry.
- Deploy on a multisite where a case-sensitive login convention is mandated.
- Combine with a case-sensitive (binary/utf8mb4_bin) collation on `users_field_data.name` to actually enforce the check.
- Install with zero configuration: enable the module and the login form validator is active immediately.
- Keep password reset, registration, and API-based logins on core's default behavior while only tightening the login form.
- Provide a lightweight, single-hook module that is easy to audit before adding to a site.
- Use in a staging/QA environment to test how case-sensitive login affects existing accounts.
- Discourage credential sharing that relies on remembering a "loose" casing of a shared account name.
- Serve as a starting point/example for a custom login-validation hook in a bespoke module.
- Roll back easily by uninstalling: because the module only adds a validate handler, disabling it restores stock core login behavior.
- Apply on sites migrated from a platform where usernames were case-sensitive, to preserve that expectation.
- Enforce casing on service/bot accounts whose usernames are entered by scripts through the UI login form.
- Document to end users that their username must be typed with the exact casing used at registration.
