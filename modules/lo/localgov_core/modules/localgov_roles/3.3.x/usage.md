LocalGov Roles installs the standard LocalGov Drupal editorial roles and provides a `hook_localgov_roles_default()` mechanism so any module can declare the default permissions its features should grant to those shared roles.

---

The submodule ships four default roles as config: `localgov_author`, `localgov_contributor`, `localgov_editor`, and `localgov_user_manager` (constants on `RolesHelper`, which also defines `localgov_admin` used by the `localgov_admin_role` submodule). On install, and whenever a module is installed, it collects `hook_localgov_roles_default()` implementations (each returning `[RolesHelper::SOME_ROLE => ['permission', ...]]`) and grants those permissions to the corresponding roles via `user_role_grant_permissions()`. This lets each LocalGov feature module ship its own slice of permissions for the shared roles without editing the roles centrally. It depends on `role_delegation` (so site admins can delegate a subset of role assignment), `toolbar`, and `path`. No permissions of its own, no config UI.

---

- Install the standard LocalGov editorial roles (author, contributor, editor, user manager).
- Let a feature module grant its permissions to LocalGov roles via `hook_localgov_roles_default()`.
- Automatically apply a module's default role permissions when that module is enabled.
- Keep per-feature permission defaults colocated with each module rather than centralized.
- Provide a consistent editorial permission baseline across a LocalGov site.
- Use `RolesHelper::EDITOR_ROLE` (etc.) constants to target roles from code.
- Delegate limited role assignment to non-superuser admins via role_delegation.
- Seed a new LocalGov build with ready-made content roles.
- Extend the role set from a custom module by implementing the roles-default hook.
- Re-apply role permission defaults by reinstalling a feature module.
- Give an author role own-content media/edit permissions out of the box (with localgov_media).
- Base a custom editorial workflow on the shared LocalGov roles.
- Assign the user-manager role to staff who administer accounts.
- Grant a contributor role limited create-only content permissions.
- Keep editorial roles consistent across multiple LocalGov sites.
- Onboard new editors quickly by assigning a ready-made role.
- Let contrib/feature modules extend role permissions without central edits.
- Re-run permission grants automatically when enabling a new feature module.
