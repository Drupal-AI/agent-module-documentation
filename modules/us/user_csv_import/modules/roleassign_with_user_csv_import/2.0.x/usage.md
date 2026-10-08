<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RoleAssign with User CSV Import is a small glue submodule that makes the User CSV Import form list only the roles the current user is allowed to assign under the RoleAssign module, so the form's visuals match what RoleAssign will actually permit.

---

Without this submodule, the [User CSV Import](https://www.drupal.org/project/user_csv_import) form shows **all** roles in its "Roles" checkboxes, while the [RoleAssign](https://www.drupal.org/project/roleassign) module silently prevents a delegated administrator from actually granting roles they aren't permitted to assign — a confusing mismatch. This submodule implements `hook_form_alter()` for the `user_csv_import_form` and intersects the form's role `#options` with the assignable roles configured in RoleAssign (`roleassign.settings` → `roleassign_roles`). The result is that the import form only offers roles the user may assign. It depends on both `user_csv_import` and `roleassign`, has no configuration, permissions, schema, services or Drush of its own — its entire behaviour is that one form alteration. Its effect is driven purely by RoleAssign's own `roleassign_roles` configuration.

---

- Show delegated site admins only the roles they may assign when bulk-importing users.
- Prevent confusion where the import form offered roles RoleAssign would block.
- Keep the CSV import UI consistent with RoleAssign's per-role delegation rules.
- Let an "editor manager" import users and grant only the "editor" role, not "administrator".
- Combine bulk user import with fine-grained role-assignment delegation.
- Avoid exposing privileged roles (e.g. administrator) in the import form to non-super-admins.
- Enforce least-privilege role granting during bulk onboarding.
- Reuse RoleAssign's existing `roleassign_roles` config to control the import form automatically.
- Give agencies safe delegated user-import workflows for client teams.
- Ensure the import form's role list reflects the assignable roles for the acting user.
- Reduce accidental over-privileging of imported accounts.
- Support multi-team sites where different admins manage different role sets.
- Make the import experience match single-user create/edit behaviour under RoleAssign.
- Drop it in without configuration once both parent modules are set up.
- Limit the visible import roles to a curated assignable set for compliance.
