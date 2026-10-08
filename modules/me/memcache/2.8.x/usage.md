Memcache integrates Drupal with a memcached daemon (via the PECL memcache or memcached extension), providing high-performance cache and lock backends that offload cache storage from the database into memory.

---

By default Drupal stores its many cache bins in the database, which becomes a bottleneck under load. This module replaces those with a memcached-backed cache backend (`cache.backend.memcache`) and an optional memcache lock backend, keeping cache data in fast, distributed memory. Configuration is done entirely in `settings.php`: you declare the memcached `servers`, group them into `clusters`, map cache `bins` to clusters, set a `key_prefix` (so multiple sites can share a daemon), and choose the default backend with `$settings['cache']['default'] = 'cache.backend.memcache'`. It supports multiple servers and clusters, socket connections, configurable key-hashing (long keys are hashed to fit memcached's 250-byte limit), and cache-tag invalidation using a timestamp-based checksum service. It works with either the `memcache` or the `memcached` PECL extension. An `example.services.yml` shows how to override services — for instance to use memcache for the lock backend or the cache-tags checksum, or to run the bootstrap/container cache in pure memcache. The bundled `memcache_admin` submodule adds a UI to monitor memcached statistics. It requires a running memcached daemon and one of the PECL extensions.

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
- Enable cache-tag invalidation via the timestamp checksum service.
- Run the bootstrap container cache in memcache for faster cold starts.
- Choose a specific key-hashing algorithm for long cache keys.
- Use the `memcached` PECL extension for SASL/binary protocol support.
- Adjust invalidation tolerance when memcached is not on localhost.
- Override individual services with `example.services.yml` snippets.
- Keep cache data warm across deploys that clear the database.
- Reduce database size/IO by not persisting cache in SQL.
- Monitor hit/miss ratios and slabs with the memcache_admin submodule.
- Debug cache behavior against a live memcached daemon.
- Provide a cache layer for a decoupled/API backend under heavy load.
- Serve authenticated traffic faster with a fast dynamic-page cache store.
- Standardize caching across a multi-server production cluster.
