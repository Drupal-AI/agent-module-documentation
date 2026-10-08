Administer Users by Role lets you delegate limited user administration to "sub-admin" users, scoping which accounts they can edit, cancel, view or assign roles to by the target user's roles — a fine-grained alternative to core's all-or-nothing "Administer users" permission.

---

The module replaces Drupal core's coarse `administer users` / `administer permissions` grants with per-operation, per-role permissions. Each site role is first classified on the settings form (**Administration → People → Administer Users by Role**, route `administerusersbyrole.settings`) as **Allowed** (`safe`), **Forbidden** (`unsafe`) or **Custom** (`perm`); the "admin" role and any role with `administer users` is always forbidden. A sub-admin may act on a target user only if they have access to every role that user holds. Base permissions cover the four operations `edit`, `cancel`, `view` and `role-assign` against all *allowed* roles (machine names `edit users by role`, `cancel users by role`, `view users by role`, `role-assign users by role`), and each role marked *Custom* generates four extra per-role permissions (e.g. `edit users with role editor`). Additional static permissions are `create users`, `access users overview` (grants the People list, filtered to only editable users) and `allow empty user mail`. Access is enforced through `hook_user_access()`, `hook_entity_create_access()`, `hook_entity_field_access()` and a `hook_query_TAG_alter()` that hides non-editable accounts from the People view; role assignment is exposed on the user edit form and via the core "Add/Remove role" bulk actions (subclassed here so their role options respect the sub-admin's grants). An `AccessManager` service (`administerusersbyrole.access`) centralises the checks and generates the dynamic permission list. Settings are stored in the `administerusersbyrole.settings` config object and export like any config.

---

- Let a membership secretary edit and view only members, not administrators or content editors.
- Give a support team the ability to reset passwords for regular users without full user administration.
- Allow a moderator to block/cancel accounts that only hold "allowed" roles.
- Delegate role assignment so a team lead can grant the "editor" role but no other role.
- Classify each role as Allowed, Forbidden or Custom on the settings form.
- Mark the "admin" role Forbidden so no sub-admin can ever touch admin accounts (default behaviour).
- Grant `edit users by role` so a sub-admin can edit any user whose roles are all "allowed".
- Grant `cancel users by role` to let a sub-admin cancel/delete allowed users.
- Grant `view users by role` to allow viewing single user profiles of allowed users.
- Grant `role-assign users by role` to let a sub-admin assign any "allowed" role.
- Use Custom classification to expose per-role permissions like `edit users with role editor`.
- Combine a per-role permission (`edit users with role X`) with the base `edit users by role` to widen a sub-admin's reach for one specific role.
- Give a sub-admin `create users` so they can add new accounts without `administer users`.
- Grant `access users overview` to show the People page filtered to only the users they can manage.
- Grant `allow empty user mail` so sub-admins can create/manage accounts with no email address.
- Assign roles in bulk from the People list using the core "Add role to the selected users" action, restricted to allowed roles.
- Assign roles to a user who already holds only assignable roles, even without edit access to that user.
- Hide accounts a sub-admin cannot edit from the admin People listing automatically.
- Restrict the role checkboxes on the user edit form to only the roles the sub-admin may assign.
- Let a sub-admin choose a cancellation method only if they also hold core's "Select method for cancelling account".
- Export the role classification (`administerusersbyrole.settings`) as configuration between environments.
- Protect uid 0 (anonymous) and uid 1 (root) — the module never grants access to them.
- Build a tiered admin hierarchy where different staff manage different segments of the user base.
- Set up a helpdesk role that can view and edit low-privilege users but never elevate anyone to admin.
- Replace a custom permission module by driving everything from role classification plus the four operations.
