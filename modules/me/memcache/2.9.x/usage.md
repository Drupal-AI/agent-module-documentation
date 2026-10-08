Memcache integrates Drupal with a memcached daemon (via the PECL memcache or memcached extension), providing high-performance cache, lock and flood-control backends that offload storage from the database into memory.

---

By default Drupal stores its many cache bins in the database, which becomes a bottleneck under load. This module replaces those with a memcached-backed cache backend (`cache.backend.memcache`) and optional memcache lock and flood-control backends, keeping the data in fast, distributed memory. Configuration is done almost entirely in `settings.php`: you declare the memcached `servers`, group them into `clusters`, map cache `bins` to clusters, set a `key_prefix` (so multiple sites can share a daemon), and choose the default backend with `$settings['cache']['default'] = 'cache.backend.memcache'`; the lock, flood and cache-tag services are swapped in your site's `services.yml`. It supports multiple servers and clusters, socket connections, configurable key-hashing (keys over memcached's 250-byte limit are hashed), persistent connection pools (now effective with the Memcached extension as of 8.x-2.9), ASCII and SASL authentication, and cache-tag invalidation using a timestamp-based checksum service. It works with either the `memcache` or the `memcached` PECL extension (Memcached 3.2.0+ required on PHP 8.1+). As of 8.x-2.9, cache deletions and tag invalidations performed inside an open database transaction are deferred until commit, so a concurrent request can no longer repopulate the cache from uncommitted data. An `example.services.yml` shows how to override services — the lock backend, flood backend, the cache-tags checksum, or the bootstrap/container cache in pure memcache. The bundled `memcache_admin` submodule adds a UI to monitor memcached statistics. It requires a running memcached daemon and one of the PECL extensions.

---

- Move Drupal's cache from the database into memcached for speed.
- Set memcache as the default cache backend site-wide.
- Route only specific bins (e.g. `render`, `page`) to memcache.
- Scale a high-traffic site by offloading cache reads/writes from the DB.
- Share memory across multiple web/app servers via a memcached pool.
- Configure multiple memcached servers for capacity and redundancy.
- Group servers into named clusters and map bins to them.
- Connect to memcached over a Unix socket instead of TCP.
- Prefix keys so several Drupal sites can share one memcached instance.
- Use the memcache lock backend to reduce DB lock contention.
- Move flood control (failed-login/password-reset limits) into memcache (D10.1+).
- Enable cache-tag invalidation via the timestamp checksum service.
- Run the bootstrap container cache in memcache for faster cold starts.
- Use persistent connection pools to skip the connect handshake per request.
- Authenticate to memcached with ASCII (`-Y`) or SASL credentials.
- Choose a specific key-hashing algorithm for long cache keys.
- Use the `memcached` PECL extension for SASL/binary protocol support.
- Adjust invalidation tolerance when web-server clocks disagree.
- Drop a failed server from the ring instead of waiting out its timeout.
- Override individual services with `example.services.yml` snippets.
- Keep cache data warm across deploys that clear the database.
- Reduce database size/IO by not persisting cache in SQL.
- Monitor hit/miss ratios and slabs with the memcache_admin submodule.
- Debug cache behavior with per-operation statistics against a live daemon.
- Provide a cache layer for a decoupled/API backend under heavy load.
- Serve authenticated traffic faster with a fast dynamic-page cache store.
- Standardize caching across a multi-server production cluster.
