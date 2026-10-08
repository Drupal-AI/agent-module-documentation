<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable user 1 edit — agent index

Blocks entity access to **user 1** (the superuser) even for accounts with `administer users`.
One access hook, one boolean config. No dependencies.

- **Turn the protection on/off, config semantics, route, permission, mechanism** →
  [configure/protection.md](configure/protection.md)

Key facts:
- Config `disable_user_1_edit.settings:disabled` (integer, default `0`). **Inverted semantics:**
  `0` = restriction ACTIVE (user 1 locked); `1` = restriction OFF (user 1 editable).
- `hook_ENTITY_TYPE_access` (`disable_user_1_edit_user_access`) returns `forbidden` for entity id 1
  when active (guarded by a non-existent permission, so always forbidden).
- The hook does **not** filter `$operation`, so it forbids update, delete AND view of user 1.
- Settings form route `disable_user_1_edit.config_form` → `/admin/config/people/disable_user_1_edit`;
  permission `administer disable user 1 edit` (`restrict access: true`).
- No Drush, no plugins.
