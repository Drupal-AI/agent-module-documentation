# Simple User Management — agent index

Lets non-admin roles manage other users (approve / create / deactivate / delete / change password)
without `administer users`, bounded by the Role Delegation module. Four confirm forms at
`/admin/manage-users/{op}/{user}`, plus a route-access swap on core's user-create form. No global
config page (`configure` null), no config schema, no Drush. Depends on `role_delegation`.

- **The five permissions, the routes they gate, and the delegation guard on each** →
  [permissions/permissions.md](permissions/permissions.md)
- **How to set the module up (permissions to grant, People view tweak, the create-route swap)** →
  [configure/setup.md](configure/setup.md)
- **The delete-bypass alter hook for programmatic use** → [api/hooks.md](api/hooks.md)

Key facts:
- Forms: `UserApprovalForm`, `UserChangePasswordForm`, `UserDeactivateForm`, `UserDeleteForm`
  (`src/Form/`). Deactivate/delete call core `user_cancel()`; approve calls `$user->activate()`.
- Delegation guard (`getAssignableRoles()`): deactivate, delete, and change-password refuse a target
  whose non-`authenticated` roles are not all delegatable by the current user.
- `RouteSubscriber` replaces `_entity_create_access` on `user.admin_create` with
  `_permission: create user accounts`.
- Self-deactivation / self-deletion are blocked; already-blocked users can't be re-deactivated.
