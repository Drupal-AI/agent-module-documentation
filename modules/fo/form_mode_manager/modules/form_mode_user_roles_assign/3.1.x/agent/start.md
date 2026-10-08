<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Mode Manager User Roles Assign — agent index

Auto-assigns user roles when someone registers/is created through a Form Mode Manager **user**
form mode. Requires the parent `form_mode_manager` module plus core `field` and `user`.

- **The settings form, config keys, and how the role default is applied** →
  [configure/role-assign.md](configure/role-assign.md)

Key facts:
- Configure route: `form_mode_manager.admin_settings_roles_assign` =
  `/admin/config/content/form_mode_manager/role-assign` (permission `administer site configuration`).
- Config object: `form_mode_user_roles_assign.settings` →
  `form_modes.user_<form_mode>.assign_roles` (list of role ids to assign).
- Applies on Form Mode Manager `user` routes matching the register/create path pattern
  (`/user/register/…` or `/admin/people/create/…`); sets the configured roles as the **default
  value** of the register form's roles element (`FormAlter`).
- The config key uses the prefix `user_` + the form-mode machine name (e.g. form mode `partner`
  → `form_modes.user_partner.assign_roles`).
