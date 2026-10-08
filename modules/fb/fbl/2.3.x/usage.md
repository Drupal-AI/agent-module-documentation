<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Based Login allows users to login with different fields.

---

Field Based Login (fbl) lets users log in with an alternative identifier — a configured **unique
user account field** (string/integer/telephone), and/or **email** — instead of only the username. It is
configured at `fbl.configuration` (`/admin/config/people/fbl`, permission `administer fbl`), provides
config schema/translation, and depends on core User. Its implementation is sound: on the login form a
validate handler (`fbl_login_name_validate`, pushed to the front of `#validate`) **resolves the entered
identifier to the real account username** — it queries users by the configured field (or by email via
`user_load_by_mail`) and rewrites the form's `name` value to the matched account's username — and then
lets **Drupal core's login authentication verify the password** against that username, so it does **not**
weaken the credential check (wrong password still fails; core flood control still applies). It uses a
**neutral "unrecognized username or password" message** on lookup failure (no clear enumeration oracle),
and it **blocks ambiguous logins**: if the field query matches more than one account it errors out instead
of guessing. Uniqueness is enforced two ways — the config form rejects a field with duplicate values and
the register/user-edit validate handler (`fbl_user_register_validate`) blocks saving a duplicate. Email
login can pull the resolved name from either the account name or display name (`user_email_source`). It has
no other access-control role.

---

- Log in with a custom unique account field (e.g. phone or membership number).
- Log in with email instead of username.
- Keep username login enabled alongside alternative identifiers.
- Resolve the entered identifier to the real username before authentication.
- Let core verify the password (no weakened credential check).
- Keep core flood control on login.
- Present a neutral login-failure message to avoid enumeration.
- Block login when an identifier matches multiple accounts.
- Enforce uniqueness of the login field at configuration time.
- Prevent saving a duplicate value on user register/edit.
- Relabel the username field on the login form (custom label).
- Add a custom description under the login field.
- Choose whether email login resolves to account name or display name.
- Configure at fbl.configuration (/admin/config/people/fbl).
- Translate the custom label/description via config translation.
- Offer a mobile-number login for a member portal.
- Offer a serial/customer-number login for a support site.
- Restrict login to a single, admin-chosen unique identifier field.
- Gate configuration behind the `administer fbl` permission.
- Have no other access-control role beyond login identifier resolution.
