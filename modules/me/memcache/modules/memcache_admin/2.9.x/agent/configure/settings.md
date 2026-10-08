# Configure Memcache Admin

Settings form `Drupal\memcache_admin\Form\MemcacheAdminSettingsForm` at
`/admin/config/system/memcache` (route/`configure`: `memcache_admin.settings`). Config object
`memcache_admin.settings`.

## Setting
- `show_memcache_statistics` (bool, default `FALSE`) — when on, appends a compact memcache
  statistics table to the bottom of every page (a development/debugging aid; leave off in
  production). It is only shown to users with the `access memcache statistics` permission, and
  it shows nothing unless per-request collection is also enabled with
  `$settings['memcache']['collect_statistics'] = TRUE;` in settings.php. The form prints a
  reminder when `collect_statistics` is off.

## Reports (no config needed)
Controller `MemcacheStatisticsController` serves:
- `/admin/reports/memcache` — all servers (route `memcache_admin.reports`).
- `/admin/reports/memcache/{cluster}` — one cluster.
- `/admin/reports/memcache/{cluster}/{server}` — raw stats for one server.
- `/admin/reports/memcache/{cluster}/{server}/{type}` — a specific stats type.
- `/admin/reports/memcache/{cluster}/{server}/{type}/cachedump/{slab}` — slab contents
  (separate `access slab cachedump` permission).

Stats are collected via event subscribers (`MemcacheServerStatsSubscriber`,
`McrouterStatsSubscriber`) firing a `MemcacheStatsEvent`, so both plain memcached and mcrouter
setups are supported. Servers/clusters come from the main memcache `settings.php` config. When
memcache is disabled in the environment (both `servers` and `bins` are empty), the report
pages return a short "Memcache is disabled" notice instead of statistics.
