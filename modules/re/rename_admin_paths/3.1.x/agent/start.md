# rename_admin_paths — agent start

Renames the `/admin` and `/user` route prefixes to custom terms (e.g. `/admin` →
`/backend`, `/user` → `/member`) for backend obscurity and branding. A route-alter event
subscriber rewrites the leading segment of every matching route when a prefix is enabled.
No dependencies outside core. Config UI: **Admin → Config → System → Rename Admin Paths**
(`/admin/config/system/rename-admin-paths`); settings route `rename_admin_paths.admin`.
Note: this is security-by-obscurity, not access control.

- Rename the admin/user prefixes, settings keys, the route-rewrite mechanism → [configure/settings.md](configure/settings.md)
- Permission gating the settings form → `administer path admin` (restricted; see configure/settings.md)
