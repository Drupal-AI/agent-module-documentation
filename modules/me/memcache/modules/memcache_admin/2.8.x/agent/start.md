# memcache_admin — agent start

Submodule of **memcache**. Adds a stats-monitoring UI for the site's memcached daemons.
Reports at `/admin/reports/memcache` (+ per-cluster/server/type drill-down). Requires module
`memcache`.

- Settings form + per-page stats footer toggle → [configure/settings.md](configure/settings.md)
- Permissions (view stats, slab cachedump) → [permissions/permissions.md](permissions/permissions.md)
