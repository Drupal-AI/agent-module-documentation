<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Separate Form (change_pwd_page) — agent index

Moves password changing onto a dedicated page and hides the password fields on the user edit form.
Depends on `user`. No config of its own, no permissions, no Drush, no plugins (`configure: null`).

- **Routes, the separate form, and the user-edit-form changes** → [configure/routes-and-form.md](configure/routes-and-form.md)
- **Password Policy integration (`password_policy.settings:change_password_route`) & reset flow** →
  [api/integration.md](api/integration.md)

Key facts: `/user/change-password` (route `change_pwd_page.change_password`) redirects to
`/user/{user}/change-password` (route `change_pwd_page.change_password_form`, form id `change_pwd_form`).
On install the module sets `password_policy.settings:change_password_route` =
`change_pwd_page.change_password_form`.
