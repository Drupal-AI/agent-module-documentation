<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Switcher (role_switcher) — agent index
**Lets a multi-role user activate one of their custom roles per session, without changing stored role assignments.**

- **Version:** 1.0.x  **Core:** ^10 || ^11  **Depends:** user  (project `role_switcher_session`, module machine name `role_switcher`)
- **Route:** `role_switcher.switch_form` (`/user/role-switch`) — `_user_is_logged_in: 'TRUE'` (no dedicated permission).
- **Block:** `RoleSwitcherBlock`. **Services:** `RoleSwitcherManager`, `RoleSwitcherAccountProxy`.
- **Security:** reviewed sound — `RoleSwitcherManager::setActiveRole()` validates the target rid against `getSwitchableRoles()` (the user's own roles minus authenticated/administrator), so no privilege escalation; selection stored only in session, `administrator` always retained, revoked-role overrides self-clear. No mutation of `users_roles`.
