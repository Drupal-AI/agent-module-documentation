# shield — agent start

Puts the whole site behind one HTTP Basic Auth prompt via an HTTP middleware
(`shield.middleware`, priority 250, before page cache). Config UI: **Admin → Config →
System → Shield** (`/admin/config/system/shield`, route `shield.settings`, perm
`administer shield`). Depends on core `path_alias`; optional `key` for secret storage.

- Enable, credentials, exceptions (all settings keys) → [configure/settings.md](configure/settings.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- How the middleware decides (bypass order, debug header) → [extend/middleware.md](extend/middleware.md)
