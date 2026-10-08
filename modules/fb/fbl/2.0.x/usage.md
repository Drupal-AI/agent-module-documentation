<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Based Login lets users sign in with a configured account field or email instead of only their username.

---

Field Based Login (fbl) lets users log in with an alternative identifier — a configured **unique
user account field** (a `string`, `integer`, or `telephone` field) and/or **email** — in place of the
username. It is configured at `fbl.configuration` (`/admin/config/people/fbl`, permission
`administer fbl`), provides config schema and config translation, and depends only on core User. On the
login form a validate handler (`fbl_login_name_validate`, pushed to the front of the form's `#validate`)
**resolves the entered identifier to the matched account's real username** — it queries users by the
configured field (or resolves by `user_load_by_mail` / `user_load_by_name`) and rewrites the form's
`name` value — and then lets **Drupal core's login authentication verify the password** against that
username, so the credential check is unchanged. Failed lookups return the neutral "unrecognized username
or password" message, and a field query that matches more than one account is rejected rather than
guessing. Uniqueness of the login field is enforced both at configuration time (the settings form rejects
a field with duplicate values) and on user register/edit (`fbl_user_register_validate`). The admin can
also relabel the login form's identifier field and add a description, both translatable via config
translation. This installed copy is a **dev checkout** (`fbl.info.yml` carries no `version:` line),
documented as the `2.0.x` branch.

---

- Let users log in with a custom unique account field (e.g. phone or membership number).
- Let users log in with their email address instead of the username.
- Keep normal username login enabled alongside an alternative identifier.
- Turn off username login so only the alternative field/email is accepted.
- Offer a mobile-number login for a member portal.
- Offer a serial/customer-number login for a support or warranty site.
- Resolve the entered identifier to the real username before core authenticates.
- Let core verify the password against the resolved username (credential check unchanged).
- Keep core login flood control in effect.
- Present a neutral login-failure message.
- Reject a login attempt whose field value matches more than one account.
- Restrict eligible login fields to user-bundle `string`/`integer`/`telephone` fields.
- Enforce uniqueness of the chosen login field at configuration time.
- Prevent saving a duplicate field value on user register or edit.
- Relabel the login form's username/identifier field (custom label).
- Add a custom description under the login field.
- Choose whether email login resolves to the account name or the display name.
- Translate the custom label and description with the Config Translation module.
- Configure everything from `fbl.configuration` (`/admin/config/people/fbl`).
- Gate configuration behind the `administer fbl` permission.
- Remove the settings config automatically on uninstall (`fbl_uninstall`).
