RoleAssign lets non-administrators assign a restricted, configurable subset of roles to other users through the standard user edit form, without granting the dangerous "Administer permissions" permission.

---

RoleAssign solves a classic Drupal delegation problem: to let an assistant administrator assign roles to users you would otherwise have to grant "Administer permissions", which also lets them grant any right to any role (and thereby escalate their own privileges). RoleAssign introduces a new "Assign roles" permission instead. A site administrator (holder of "Administer permissions") picks which roles are assignable at **People → Role assign** (`/admin/people/roleassign`, route `roleassign.settings`), storing them in the `roleassign.settings` config object under the `roleassign_roles` key. Any user who has both "Assign roles" and core "Administer users" then sees an "Assignable roles" checkbox set on user edit forms, limited to exactly those configured roles. A `hook_form_alter()` replaces the roles field on user forms (and the CAS bulk-add form) with the restricted list, and a `hook_user_presave()` enforces the restriction server-side: roles the restricted user cannot assign are preserved from the original account ("sticky" roles) so they can neither be added nor removed. The anonymous and authenticated roles are always excluded from assignment. RoleAssign also protects user 1's name, email, and password fields. It is best for small sites with a single assistant-admin role; for finer-grained "which role may assign which role" control the README points to Role Delegation.

---

- Let a support team assign an "editor" role to users without giving them full permission administration.
- Delegate user-role management to an assistant admin while withholding "Administer permissions".
- Restrict which roles a role manager may hand out to a specific, configured subset.
- Prevent privilege escalation by keeping "Administer permissions" with trusted site admins only.
- Configure the assignable-roles list at `/admin/people/roleassign`.
- Grant the "Assign roles" permission to a role that should manage other users' roles.
- Combine "Assign roles" with core "Administer users" so a delegatee can edit accounts and set roles.
- Show a limited "Assignable roles" checkbox set on the user edit form instead of the full roles list.
- Preserve a user's existing non-assignable ("sticky") roles when a restricted admin edits them.
- Stop a restricted admin from removing roles they are not permitted to assign.
- Keep the "Authenticated user" and "Anonymous user" roles out of the assignable set automatically.
- Deploy the assignable-roles configuration between environments via `drush config:export`.
- Set the assignable roles from the command line with `drush cset roleassign.settings roleassign_roles`.
- Protect the user 1 (super admin) account's name, email, and password from restricted admins.
- Run a small site with one system administrator and one reasonably restricted assistant-admin role.
- Limit the roles offered when bulk-adding users through the CAS module's bulk-add form.
- Audit that only chosen roles are delegatable by reviewing the `roleassign_roles` config value.
- Migrate legacy Drupal 6/7 RoleAssign settings using the bundled migration templates.
- Let front-desk staff promote members to a "premium" role without touching site permissions.
- Give community moderators the ability to grant a "moderator" role but nothing more.
- Enforce role restrictions server-side (via presave), not just by hiding form fields.
- Keep an assistant admin from granting themselves administrative roles.
- Confine what a delegated user administrator can do while still allowing account management.
