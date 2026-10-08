# administerusersbyrole — agent start

Delegates limited user administration to "sub-admin" users, scoped by the target user's
roles. Replaces core's all-or-nothing `administer users` with per-operation, per-role
permissions (edit / cancel / view / assign roles). No module dependencies (core only).
Settings UI: **Admin → People → Administer Users by Role**
(`/admin/config/people/administerusersbyrole`, route `administerusersbyrole.settings`,
requires core `administer permissions`).

- Permissions: static + dynamic base + per-role machine names → [permissions/administerusersbyrole.md](permissions/administerusersbyrole.md)
- Classify roles (Allowed / Forbidden / Custom) on the settings form → [configure/administerusersbyrole.md](configure/administerusersbyrole.md)
- Access checks & role listing in code (`administerusersbyrole.access`) → [api/administerusersbyrole.md](api/administerusersbyrole.md)
