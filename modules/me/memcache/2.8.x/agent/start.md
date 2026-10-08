# memcache — agent start

Memcached-backed cache + lock backends. Configured entirely in `settings.php` (no admin UI).
Requires a memcached daemon and the `memcache` or `memcached` PECL extension. Submodule
`memcache_admin` adds a stats UI.

- Configure servers/clusters/bins & set the default backend (settings.php) → [configure/settings-php.md](configure/settings-php.md)
- Services provided (cache backend, lock, factory) → [api/services.md](api/services.md)
- Override services: lock, cache-tags checksum, bootstrap container → [extend/service-overrides.md](extend/service-overrides.md)
