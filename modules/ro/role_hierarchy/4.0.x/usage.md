<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Hierarchy stops lower-privileged users from editing, deleting, or granting/revoking roles on users who hold more powerful roles, using the role ordering on the People > Roles page as the hierarchy.

---

The module turns the weight order of roles at `/admin/people/roles` into an access hierarchy: by default a role can only edit users and assign/remove roles that sit at or **below** its own most-powerful role (lower in the list = less powerful). It enforces this in three places: `hook_ENTITY_TYPE_access()` for `user` forbids `update`/`delete` on a user your role is not high enough to manage; `hook_form_user_form_alter()` / `hook_form_user_register_form_alter()` strip role checkboxes you are not allowed to grant from the account edit/register forms; and `hook_action_info_alter()` swaps core's "Add/Remove a role" bulk user actions for subclasses that apply the same weight check. All comparisons run through the `role_hierarchy.helper` service (`RoleHierarchyHelper`), which computes each account's highest hierarchical role weight and compares it to the edited role/user. Three settings, edited directly on the People > Roles form (saved to `role_hierarchy.settings`), tune it: **invert** (edit roles *above* you instead of below), **strict** (cannot edit *equal* roles, only strictly higher/lower), and **non_hierarchical_roles** (roles excluded from the hierarchy entirely). Two permissions matter: `bypass role hierarchy` exempts a role from all checks (e.g. real site admins), and `edit user roles` exposes the roles element on the user form. User 1 is always protected (only user 1 can edit user 1), and users always keep the roles they already have on their own account.

---

- Prevent an "editor" role from promoting themselves or others to "administrator".
- Stop a mid-level moderator from deleting or editing an admin account.
- Hide roles above the current user from the account edit form's role checkboxes.
- Hide un-grantable roles from the user registration form when admins create accounts.
- Restrict the bulk "Add a role to the selected users" action to roles you may grant.
- Restrict the bulk "Remove a role from the selected users" action the same way.
- Enforce a clear org chart of roles (e.g. support < editor < manager < admin).
- Let real administrators bypass all checks via the `bypass role hierarchy` permission.
- Order roles at /admin/people/roles to define who outranks whom.
- Invert the hierarchy so a role manages roles above it (unusual delegation setups).
- Turn on strict mode so peers cannot edit each other's accounts.
- Exclude cross-cutting roles (e.g. "newsletter subscriber") from the hierarchy as non-hierarchical.
- Protect the super-admin (user 1) account from being edited by anyone else.
- Allow users to edit their own account without losing roles they already hold.
- Delegate limited user management to team leads without granting full user administration.
- Reduce privilege-escalation risk on multi-team or client-managed platforms.
- Keep a helpdesk role from touching higher-tier staff accounts.
- Apply the role check programmatically via the `role_hierarchy.helper` service in custom code.
- Gate a custom user-management screen using `RoleHierarchyHelper::hasEditAccess()`.
- Give a role the `edit user roles` permission to surface role editing while still bounded by the hierarchy.
- Combine with core permissions so lower staff can edit users but not escalate roles.
- Model tiered client administrators who can only manage their own tier and below.
- Prevent lateral role tampering between equally-ranked editors (strict mode).
