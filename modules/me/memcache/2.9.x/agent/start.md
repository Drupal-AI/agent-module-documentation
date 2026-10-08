# memcache — agent start

Memcached-backed cache + lock + flood backends. Servers/bins configured in `settings.php`
(no admin UI); the lock, flood and cache-tag services are swapped in your site's `services.yml`.
Requires a memcached daemon and the `memcache` or `memcached` PECL extension (Memcached 3.2.0+
on PHP 8.1+). Submodule `memcache_admin` adds a stats UI.

- Configure servers/clusters/bins & set the default backend (settings.php) → [configure/settings-php.md](configure/settings-php.md)
- Services provided (cache backend, lock, flood, factory) → [api/services.md](api/services.md)
- Override services: lock, flood, cache-tags checksum, bootstrap container → [extend/service-overrides.md](extend/service-overrides.md)
