# Permissions

Defined in `memcache_admin.permissions.yml`:

- `access memcache statistics` — view the memcache statistics reports under
  `/admin/reports/memcache` (all cluster/server/type pages).
- `access slab cachedump` — dump the contents of a memcache slab from the stats UI. Marked
  `restrict access: true` — grant only to trusted administrators, as it exposes cached data.

The settings form at `/admin/config/system/memcache` is gated by core's
`administer site configuration` permission (set on the route, not defined here).
