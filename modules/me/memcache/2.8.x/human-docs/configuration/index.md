# Configuration

Memcache has **no admin settings form** — you configure it entirely in your site's
`settings.php` (typically `sites/default/settings.php`, or a
`settings.local.php` you include from it). Drupal reads these values very early in
the bootstrap, before the database is available, which is exactly why they live in
a file rather than in an admin page. Add the snippets below, then clear caches.

Everything here lives under two arrays: `$settings['memcache']` (how to reach the
daemon and how bins map to it) and `$settings['cache']` (which backend Drupal
actually uses).

## Prerequisite

Before any of this does anything, a memcached daemon must be running and one of
the PECL extensions (`memcache` or `memcached`) must be loaded — see
[Installation → Requirements](../installation/index.md#requirements).

## Minimal setup — a single local daemon

For a single site talking to memcached on the same host, this is all you need:

```php
$settings['memcache']['servers'] = ['127.0.0.1:11211' => 'default'];
$settings['memcache']['bins'] = ['default' => 'default'];
$settings['memcache']['key_prefix'] = '';

// Make memcache the default cache backend for every bin:
$settings['cache']['default'] = 'cache.backend.memcache';
```

If you would rather move only certain caches to memcached and leave the rest in
the database, skip the `default` line and route individual bins instead:

```php
$settings['cache']['bins']['render'] = 'cache.backend.memcache';
$settings['cache']['bins']['page'] = 'cache.backend.memcache';
```

## Servers, clusters, and bins

Memcache thinks in three layers, which lets a large site spread cache across
several memcached hosts:

- **`servers`** — a map of `'host:port' => 'cluster'`. You can also point at a Unix
  socket with `'unix:///path/to/socket' => 'cluster'`.
- **`clusters`** — named groups of servers that act together as one shared memory
  pool. A simple site just uses the implicit `default` cluster.
- **`bins`** — a map of `'bin_name' => 'cluster'`, sending a specific cache bin to a
  specific cluster. Any bin you don't list falls back to the `default` cluster.

A multi-server example:

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

## The other keys

- **`key_prefix`** *(string)* — a unique prefix per site. Set this whenever more
  than one Drupal install shares the same memcached daemon, so their cache keys
  never collide. Leave it empty (`''`) if the daemon is dedicated to one site.
- **`key_hash_algorithm`** *(string, default `sha1`)* — the algorithm used to hash
  a cache key when the prefix + key + bin name would exceed memcached's 250‑byte
  key-length limit. Most sites never need to change this.
- **`extension`** — force `Memcache` or `Memcached` when both PECL extensions are
  installed and you want to pin one of them. Omit it to let the module choose.

## A note on multiple servers

If you run more than one memcached server, set the PHP extension's hash strategy to
**consistent** so that adding or removing a server doesn't invalidate the whole
cache. That is configured in the extension's own `.ini` file, not in Drupal.

## Going further — lock backend and container cache

Copying a couple of extra service definitions lets you also use memcache for the
**lock backend** (reducing database lock contention), for the **cache-tags
checksum** service, and even for the early **bootstrap/container cache** (faster
cold starts). The module ships an `example.services.yml` with ready-made snippets
to copy into your site's `services.yml`. The exact service overrides are laid out
for developers in the sibling [`agent/`](../agent/start.md) docs.

## Apply your changes

Configuration in `settings.php` takes effect on the next request, but clear caches
to be sure everything switches over cleanly:

```bash
drush cache:rebuild
```

If you enabled the **Memcache Admin** submodule, visit **Reports → Memcache**
(`/admin/reports/memcache`) to confirm Drupal is connected to the daemon and
serving cache from memory.
