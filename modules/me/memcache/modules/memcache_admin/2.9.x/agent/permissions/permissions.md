# Permissions

Defined in `memcache_admin.permissions.yml`:

- `access memcache statistics` — view the memcache statistics reports under
  `/admin/reports/memcache` (all cluster/server/type pages), and see the optional per-page
  statistics footer.
- `access slab cachedump` — dump the contents of a memcache slab from the stats UI (the
  `.../cachedump/{slab}` route, PECL memcache extension only). Marked `restrict access: true`
  — grant only to trusted administrators, as it exposes raw cache keys and cached data.

The settings form at `/admin/config/system/memcache` is gated by core's
`administer site configuration` permission (set on the route, not defined here).
