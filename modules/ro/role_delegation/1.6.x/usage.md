Role Delegation lets administrators grant non-admin roles the ability to assign a specific, limited set of roles to other users — without handing over the dangerous "administer permissions" privilege.

---

By default only users with "administer permissions" can change other users' roles, which effectively makes them full administrators. Role Delegation solves this by generating a fine-grained permission for every role — "assign {role} role" — plus a blanket "assign all roles" permission. Roles you are allowed to delegate then appear as a "Roles" tab/form on each user's profile (`/user/{user}/roles`), and their checkboxes are also injected into the normal user add/edit form, filtered to just the roles you may assign. It ships bulk **Action** plugins ("Add role to the selected users" / "Remove role from the selected users") that respect delegation rights, an EntityReferenceSelection handler and a Views bulk-operations field so role assignment integrates with Views listings and VBO. Access is enforced by a dedicated access check service, and the assignable-role list can be filtered in code via `hook_role_delegation_assignable_roles_alter()`. This makes it ideal for delegating user management to editors, team leads, or sub-site administrators while preserving the principle of least privilege.

---

- Let editors assign only the "Contributor" role, not admin roles.
- Give a team lead the power to promote users to "Moderator".
- Delegate membership management for a specific role to a group manager.
- Allow support staff to grant a "Premium member" role.
- Enable department admins to manage roles within their department only.
- Keep the dangerous "administer permissions" privilege for super-admins only.
- Add a per-user "Roles" tab so delegated managers can adjust roles.
- Bulk-add a role to many users at once via a VBO/action.
- Bulk-remove a role from selected users on an admin listing.
- Assign roles directly from a Views listing of users.
- Filter the user register/edit form to show only assignable roles.
- Let a community manager grant a "Verified" badge role.
- Delegate "Newsletter editor" role assignment to the marketing lead.
- Grant "assign all roles" to a trusted user-manager who still shouldn't touch permissions.
- Restrict which roles a moderator can hand out to prevent privilege escalation.
- Programmatically hide certain roles from a manager via the alter hook.
- Build a self-service onboarding flow that assigns a starter role.
- Let course instructors enroll students by assigning a "Student" role.
- Separate "who can edit content" from "who can grant content-editor roles".
- Provide sub-site admins scoped role management on a multi-tenant site.
- Audit and constrain role escalation paths across an editorial team.
- Assign a temporary "Event staff" role to helpers before an event.
- Integrate delegated role assignment into an existing user-management View.
- Give HR the ability to assign employee roles without full site admin.
