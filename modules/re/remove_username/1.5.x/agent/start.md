<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remove Username field — agent index

Hides the separate "Username" field on user forms, makes email required, and copies the
email into the account `name` so username always equals email. **No config, no configure
route, no permissions, no Drush, no plugins, no config schema.** Pure hooks.

- **What it changes on which forms, and the email→username mechanism** →
  [behavior/mechanism.md](behavior/mechanism.md)

Key facts:
- `remove_username_user_presave()` sets `$user->setUsername($user->getEmail())` on **every**
  user save — the username field still exists and stays unique, it is just hidden and forced
  to the email.
- Register/edit forms: `account][name` is `#access = FALSE`, `account][mail` is `#required`.
- Login and password forms: the "Username" field is only **relabelled** to "Email address".
- Enabling the module runs `remove_username_install()`, copying every existing user's email
  into their username.
