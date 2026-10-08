<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Role — agent index

Grants configured role(s) to newly created user accounts.

Key facts:

- Config object is **`registration_role.setting`** — note the **singular** `setting`, not
  `settings`. Keys: `role_to_select` (sequence of role ids) and `registration_mode`
  (`user` | `admin`).
- Form route **`registration_role.setting.form`** → `/admin/people/registration-role`,
  permission **`administer registration roles`**.
- One runtime hook: `registration_role_user_presave()`. No tables, no services, no plugins,
  no Drush commands, no tokens.
- `registration_mode: user` = self-registration only. `registration_mode: admin` = also when
  another user (or **CLI/Drush**) creates the account.

Docs:

- **Settings keys, drush recipes, UI steps** → [configure/settings.md](configure/settings.md)
- **Exactly when roles get assigned (the presave logic) + the 2.0 security note** →
  [api/assignment-logic.md](api/assignment-logic.md)
- **`administer registration roles`** → [permissions/administer.md](permissions/administer.md)
