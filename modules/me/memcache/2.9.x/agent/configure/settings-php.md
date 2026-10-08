# Configure memcache (settings.php)

Server/bin configuration lives in `settings.php` under `$settings['memcache']` and
`$settings['cache']`. There is no admin UI in the main module. Read by
`Drupal\memcache\MemcacheSettings`. Locks, flood control and cache-tag checksums are swapped
in `services.yml` instead — see [extend/service-overrides.md](../extend/service-overrides.md).

## Minimal (single local daemon)
```php
// Connects to 127.0.0.1:11211 by default; this one line is the whole setup.
$settings['cache']['default'] = 'cache.backend.memcache';
// Or route individual bins:
$settings['cache']['bins']['render'] = 'cache.backend.memcache';
```
Enable the module *before* pointing `$settings['cache']` at it, or Drupal fails with
"non-existent service cache.backend.memcache".

## Servers / clusters / bins model
- **servers** — `'host:port' => 'cluster'` (or `'unix:///path/to/socket' => 'cluster'`).
- **clusters** — named groups of servers that shard one memory pool (not replication).
- **bins** — `'bin_name' => 'cluster'`; unmapped bins fall back to the `default` cluster.
```php
$settings['memcache'] = [
  'servers' => [
    'cache1.internal:11211' => 'default',
    'render.internal:11211' => 'render',
    'unix:///var/run/memcached.sock' => 'clusterS',
  ],
  'bins' => [
    'default' => 'default',
    'render'  => 'render',
  ],
];
$settings['memcache']['key_prefix'] = 'mysite';
```

## Common keys (see README "Settings reference")
- `key_prefix` (string) — unique per site when sharing a daemon between installs.
- `extension` — force `Memcached` or `Memcache` when both PECL extensions are present.
- `options` (array) — `\Memcached::OPT_*` options applied to every connection (compression and
  consistent distribution are on by default); used for failed-server removal and timeouts.
- `persistent` (bool, default `FALSE`) — keep connection pools open for the PHP worker's life.
  Effective with the Memcached extension only since 8.x-2.9.
- `persistent_id` (string, default `drupal_memcache`) — diagnostic label for the pool.
- `ascii_auth` / `sasl` (`['username'=>…, 'password'=>…]`) — authentication (ASCII preferred).
- `collect_statistics` (bool, default `FALSE`) — record every operation for memcache_admin's
  per-page table (debugging only).
- `debug` (bool, default `FALSE`) — log every cache operation and every failure.
- `key_hash_algorithm` (string, default `sha1`) — hash used for keys over 250 bytes.
- `invalidate_all_as_delete` (bool, default `TRUE`) — treat deprecated `invalidateAll()` as
  `deleteAll()` (Drupal 11.2 deprecated it; removed in 12).
- `status_connect_timeout` / `report_evictions` / `failure_log_interval` — status-report tuning.

## Notes
- With multiple servers in a cluster each key lives on exactly one server (sharding); put a
  replicating proxy (mcrouter/twemproxy) in front if you need every key on every server.
- Every web server must use the same `servers`, `bins` and `key_prefix`, and their clocks must
  agree (invalidation is timestamp-based). Tune the tolerance via the invalidator service.
- Set both `servers` and `bins` to empty arrays to switch memcache off in an environment.
- Bootstrap/container caching and the lock/flood backends are enabled from
  `example.services.yml` — see [extend/service-overrides.md](../extend/service-overrides.md).
