<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Case Sensitive User Login (case_sensitive_user_login) — agent index

Makes the interactive **user login form** treat the username case-sensitively. Version **1.0.0**,
core `^10 || ^11`, package "User Login". Depends only on core **`user`**.

## What it provides
- No entities, plugins, routes, services, permissions, config, or config schema.
- A single procedural file, `case_sensitive_user_login.module`, implementing
  `hook_form_user_login_form_alter()` which appends one custom **validate handler** to the login form.
- The handler runs an exact-case `=` lookup against `users_field_data.name`; if no case-exact user
  exists it sets a generic login error. It is **additive** — core's own name/auth/flood validators
  still run, and it never authenticates a user itself.

## Operating notes
- Zero configuration: enable the module and the validator is live.
- Effectiveness depends on the DB collation of `users_field_data.name`; under a case-insensitive
  collation the `=` comparison still matches any case, making the check a **no-op** there.
- Affects only the login form — not registration, password reset, or programmatic logins.

## Solution docs
- [agent/api/login-validator.md](api/login-validator.md) — the form alter + validate handler, the
  query, and behavior/limitations.
