<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Switcher lets a logged-in user who holds more than one custom role choose which single role is "active" for their current browser session, without ever changing the user's stored role assignment.

---

By default Drupal applies the union of all a user's roles at all times. Role Switcher adds an "Acting as" dropdown (a standalone form at `/user/role-switch` and a block, `RoleSwitcherBlock`) that narrows the active permission set to one chosen role; "All my original roles" reverts to the full set. The selection lives only in the PHP session (never in `users_roles`), so it is per-session and per-device. Security is enforced server-side in `RoleSwitcherManager::setActiveRole()`, which validates the target role id against `getSwitchableRoles()` — the user's own roles minus `authenticated` and `administrator` — so a user can never switch into a role they do not already hold (no privilege escalation). The `administrator` role is never offered as a target and is always implicitly retained, so an admin cannot lock themselves out; if a held role is revoked while active, the override self-clears. The switch form only needs the user to be logged in (`_user_is_logged_in: 'TRUE'`).

Set up by simply enabling the module and optionally placing the Role Switcher block; no permission or configuration is required.

---
- Let a multi-role user pick one active role per session.
- Reduce the chance of acting under the wrong role.
- Test how the site behaves under a single role.
- Revert instantly to all original roles.
- Switch via a block or the standalone `/user/role-switch` form.
- Keep the switch scoped to one browser session/device.
- Never modify the stored `users_roles` assignment.
- Prevent switching into a role the user does not hold.
- Exclude `administrator` and `authenticated` from the choices.
- Keep admins from locking themselves out of admin.
- Auto-clear an override when its role is revoked.
- Provide a non-JS/accessible fallback form.
- Support CSR/volunteer/trustee style multi-hat accounts.
- Debug permission issues from a user's perspective.
- Demonstrate role-specific UI to stakeholders.
- Require no admin setup beyond enabling.
- Add the "Acting as" dropdown to any region.
- Confirm effective permissions match the chosen role.
