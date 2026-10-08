<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# No Current Password — agent index

Makes core's **"Current password"** field on the user edit form optional. Entirely driven by
one boolean config flag; no permissions, no Drush, no plugins.

- **The one setting, where it lives, how the hides work, uid-1 exemption, drush read/write** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config: `nocurrent_pass.settings` → `nocurrent_pass_disabled` (boolean). **Install default is
  `TRUE`** (requirement removed out of the box).
- Configure route: `entity.user.admin_form` (`/admin/config/people/accounts`) — adds a "Do not
  require current password" checkbox in a "Require Current Password" fieldset.
- When TRUE, `hook_form_alter` on `user_form` and `change_pwd_form` hides `current_pass`
  (`#access = FALSE`) and sets `$form_state->set('user_pass_reset', 1)` to skip validation —
  **except for user 1**, who always keeps the field.
