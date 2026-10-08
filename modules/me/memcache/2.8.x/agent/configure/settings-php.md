# Configure memcache (settings.php)

All configuration lives in `settings.php` under `$settings['memcache']` and `$settings['cache']`.
There is no admin UI in the main module. Read by `Drupal\memcache\MemcacheSettings`.

## Minimal (single local daemon)
```php
$settings['memcache']['servers'] = ['127.0.0.1:11211' => 'default'];
$settings['memcache']['bins'] = ['default' => 'default'];
$settings['memcache']['key_prefix'] = '';
// Make memcache the default cache backend:
$settings['cache']['default'] = 'cache.backend.memcache';
// Or route individual bins:
$settings['cache']['bins']['render'] = 'cache.backend.memcache';
```

## Servers / clusters / bins model
- **servers** — `'host:port' => 'cluster'` (or `'unix:///path/to/socket' => 'cluster'`).
- **clusters** — named groups of servers acting as one memory pool.
- **bins** — `'bin_name' => 'cluster'`; unmapped bins fall back to the `default` cluster.
```php
$settings['memcache'] = [
  'servers' => [
    'server1:11211' => 'default',
    'server3:11211' => 'cluster1',
    'unix:///path/to/socket' => 'clusterS',
  ],
  'bins' => [
    'default' => 'default',
    'render'  => 'cluster1',
  ],
];
```

## Other keys
- `key_prefix` (string) — unique per site when sharing a daemon between installs.
- `key_hash_algorithm` (string, default `sha1`) — used when prefix+key+bin exceeds
  memcached's 250-byte key limit.
- `extension` — force `Memcache` or `Memcached` when both PECL extensions are present.

Notes: with multiple servers, set the PHP extension's hash strategy to **consistent** (that
is configured in the extension's ini, not in Drupal). Bootstrap/container caching and the
lock backend are enabled by copying snippets from `example.services.yml` — see
[extend/service-overrides.md](../extend/service-overrides.md).
