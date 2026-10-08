# LocalGov Roles — agent index

Submodule of **localgov_core**. Installs the default LocalGov editorial roles and provides the
`hook_localgov_roles_default()` mechanism to grant per-feature default permissions to them. Depends on
`path`, `toolbar`, `role_delegation`. No permissions of its own, no config route.

- **The roles, `RolesHelper` constants, and `hook_localgov_roles_default()`** → [api/roles.md](api/roles.md)

Key facts:
- Roles (config/install): `localgov_author`, `localgov_contributor`, `localgov_editor`, `localgov_user_manager`.
- `RolesHelper` constants: `ADMIN_ROLE=localgov_admin`, `EDITOR_ROLE`, `AUTHOR_ROLE`, `CONTRIBUTOR_ROLE`, `USER_MANAGER_ROLE`.
- On `hook_install` and `hook_modules_installed` it calls `RolesHelper::assignModuleRoles($module)` → grants each module's `hook_localgov_roles_default()` permissions.
