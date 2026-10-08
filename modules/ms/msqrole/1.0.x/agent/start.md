# Masquerade as Role — agent index

Lets a permitted user view the site with a **different set of roles** while staying logged in as
the **same user id** (contrast: the Masquerade module switches user). Works by overriding the
`user` entity class (`MasqueradeRoleUser::getRoles()`) and the `current_user` service
(`MasqueradeAccountProxy`); state is per-user in `user.data` (module key `msqrole`).

- **Settings: extra cache tags to invalidate (`msqrole.settings`), admin route** →
  [configure/settings.md](configure/settings.md)
- **Permissions: the three static perms + the dynamic per-role `masquerade as <role>`** →
  [permissions/permissions.md](permissions/permissions.md)
- **Service API: `msqrole.manager` (activate, set roles, generate links, reset)** →
  [api/manager.md](api/manager.md)

Key facts:
- Config object `msqrole.settings`, key `tags_to_invalidate` (text, default `''`) — extra cache
  tags cleared on masquerade, on top of the hardcoded `RoleManagerInterface::TAGS_TO_INVALIDATE`.
- Routes: `msqrole.settings_form` (`/admin/config/people/masquerade-role`, perm
  `administer masquerade role`), `msqrole.form` (`/admin/people/masquerade-role`, perm
  `masquerade role`), `msqrole.set` (activate via `?key=`), `msqrole.reset`.
- Service `msqrole.manager` (`RoleManagerInterface`): `setActive()`, `setRoles()`, `isActive()`,
  `generateUrl()`, `getRolesForKey()`, `invalidateTags()`, `removeData()`.
- Link keys live in the `msqrole.urls` key/value collection. Cache context: `msqrole_is_active`.
- Configurable roles exclude `anonymous`, `authenticated`, `administrator`.
