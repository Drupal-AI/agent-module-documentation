# Configure Memcache Admin

Settings form `Drupal\memcache_admin\Form\MemcacheAdminSettingsForm` at
`/admin/config/system/memcache` (route/`configure`: `memcache_admin.settings`). Config object
`memcache_admin.settings`.

## Setting
- `show_memcache_statistics` (bool, default `false`) — when on, appends a compact memcache
  statistics summary to the bottom of every page (a development/debugging aid; leave off in
  production).

## Reports (no config needed)
Controller `MemcacheStatisticsController` serves:
- `/admin/reports/memcache` — all servers (route `memcache_admin.reports`).
- `/admin/reports/memcache/{cluster}` — one cluster.
- `/admin/reports/memcache/{cluster}/{server}` — raw stats for one server.
- `/admin/reports/memcache/{cluster}/{server}/{type}` — a specific stats type.

Stats are collected via event subscribers (`MemcacheServerStatsSubscriber`,
`McrouterStatsSubscriber`) firing a `MemcacheStatsEvent`, so both plain memcached and mcrouter
setups are supported. Servers/clusters come from the main memcache `settings.php` config.
