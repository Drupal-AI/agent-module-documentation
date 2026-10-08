<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcut per Role — agent index

Assigns a default core Shortcut set per user role. When a user with the shortcut/toolbar
permissions logs in, `hook_shortcut_default_set()` returns the set mapped to their
**highest-weight** role. Depends on core `shortcut`. Its only persistent state is the
`shortcutperrole.settings` config object.

- **Configure role→set mapping, config keys, the highest-weight-role rule** →
  [configure/role-mapping.md](configure/role-mapping.md)

Key facts:
- Settings form route: `shortcutperrole.admin_config` at
  `admin/config/user-interface/shortcut/roles` (permission: `administer shortcut per role`).
- Config: `shortcutperrole.settings` → `role.<role_id>: <shortcut_set_id>`.
- Resolution: highest-weight (last-loaded) matching role wins; empty → `default`.
- No fields, entities, plugins, or Drush commands.
