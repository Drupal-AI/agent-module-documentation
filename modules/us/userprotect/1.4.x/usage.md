User Protect gives admins fine-grained control over who can edit or cancel which user accounts, by defining protection rules that lock specific fields or operations on a per-user or per-role basis.

---

User Protect ships a `userprotect_rule` config entity: each rule targets either one user (`protectedEntityTypeId` = `user`) or every user in a role (`protectedEntityTypeId` = `user_role`) and enables a set of protections drawn from the `user_protection` plugin type. Seven protection plugins ship: Username (`user_name`), Email address (`user_mail`), Password (`user_pass`), Status (`user_status`), Roles (`user_roles`), the Edit operation (`user_edit`, i.e. `user/X/edit`), and the Cancel operation (`user_delete`, i.e. `user/X/cancel`). Protections are enforced through `hook_ENTITY_TYPE_access()` and `hook_entity_field_access()` on the user entity: protected fields are disabled or hidden on the user edit form, and edit/cancel are blocked by denying the `update`/`delete` entity operations. Rules never apply to the target user editing their own account (self-editing of email/password/account is governed instead by the module's own `userprotect.mail.edit`, `userprotect.pass.edit`, `userprotect.account.edit` permissions), and never apply to user 1 or to anyone holding `userprotect.bypass_all`. Each saved rule also generates a per-rule bypass permission (`userprotect.{rule}.bypass`), so specific roles can be exempted. Rules are managed at **Admin → Configuration → People → User protect** (`/admin/config/people/userprotect`), and a settings form toggles whether an "applied protections" message is shown to admins on the edit form. The plugin type is extensible, so other modules can add their own protections (including `role_change` support for the Role Delegation module).

---

- Protect the `admin` account so no other user administrator can edit or cancel it.
- Prevent a specific user's username from being changed by others.
- Lock a user's email address against edits by other administrators.
- Stop other admins from resetting a protected user's password.
- Prevent a protected user's active/blocked status from being toggled.
- Block role changes on a protected user so privilege escalation can't happen through the edit form.
- Forbid the edit operation (`user/X/edit`) entirely for a protected account.
- Forbid the cancel/delete operation (`user/X/cancel`) for a protected account.
- Protect every user in the "administrator" role at once with a role-based rule.
- Apply a role-based rule so all editors' email addresses are locked from peer edits.
- Create a per-user protection rule via the `userprotect_rule` config entity.
- Create a per-role protection rule targeting a `user_role` entity ID.
- Grant a trusted role the per-rule bypass permission (`userprotect.{rule}.bypass`) to exempt it.
- Give a super-admin role `userprotect.bypass_all` so every protection rule is ignored for them.
- Let users edit their own email while blocking others, via `userprotect.mail.edit`.
- Let users change their own password only, via `userprotect.pass.edit`.
- Allow users to edit their own account (but not others') via `userprotect.account.edit`.
- Combine several protections (name + mail + pass) on a single rule for one account.
- Disable a protection rule temporarily without deleting it (rule `status`).
- Deploy protection rules across environments as exported configuration.
- Add a custom protection plugin by implementing the `user_protection` plugin type.
- Integrate with Role Delegation so its `role_change` field is also protected.
- Toggle the admin "applied protections" message on the user edit form via settings.
- Auto-clean rules: rules are removed automatically when the protected user or role is deleted.
- Restrict who can create/edit protection rules with the `userprotect.administer` permission.
