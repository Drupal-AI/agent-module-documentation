<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Mode Control Role Assignment (form_mode_control_role_assignment) — agent index

**Grants a configured role to users registering via a particular user form mode (chosen by `?display=`).**

- **Version:** 1.0.x
- **Core:** `^8 || ^9 || ^10`. **Package:** Custom.
- **Configure:** `/admin/config/people/form-mode-role-mapping` (`administer site configuration`) → `form_mode_control_role_assignment.settings:role_mappings`.
- **Logic:** `hook_form_user_register_form_alter` (hides roles, pre-selects mapped role) + `hook_user_presave` (`$account->addRole()`); `UserRegistrationRoleSubscriber` on `UserEvents::USER_REGISTER`.
- **Role source:** the request `display` query parameter (register form) / routed `form_mode`.

See [configure/mapping.md](configure/mapping.md).