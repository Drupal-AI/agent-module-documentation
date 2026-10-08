<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Administer Users by Role for blocking extends Administer Users by Role, granting sub-admins a 'block users' permission limited to users whose roles are configured as safe.

---

Install the module (requires administerusersbyrole). Grant the 'block users' permission to sub-admin roles and mark the target roles as safe in administerusersbyrole.settings. Enforcement happens in hook_user_presave: a block/unblock transition by a non-'administer users' user is only allowed when every gate passes, otherwise it errors and redirects.

---

- Grant sub-admins a scoped 'block users' permission.
- Allow block/unblock only for roles marked safe.
- Enforce checks in hook_user_presave.
- Detect active->blocked and blocked->active transitions.
- Bypass checks for users with 'administer users'.
- Read allowed roles from administerusersbyrole.settings.
- Block the save and show an error when not permitted.
- Redirect back to the current path on denial.
- Depend on the Administer Users by Role module.
- Prevent sub-admins acting on non-safe users.
- Serve delegated user-management workflows.
- Add a single 'block users' permission.
- Complement the parent module's edit gating.
- Keep 'administer users' as the override permission.
- Note: guards the block/unblock action specifically.
- Work for site builders delegating moderation.
- Apply to any user save path.
- Avoid privilege escalation by role scoping.
