Integrates Drupal with the Redis key-value store, providing Redis-backed implementations of Drupal's cache, lock, flood control and queue subsystems. It is configured almost entirely through `settings.php` rather than a UI form.

---

Redis is one of the most common ways to make a Drupal site faster and to scale it across multiple web servers by moving hot data out of the SQL database. The module ships factory services that replace core's default backends: a cache backend (`cache.backend.redis`), a lock backend, a persistent lock backend, a flood-control backend and two queue backends (standard and reliable). It supports three PHP clients — PhpRedis (the C extension), Relay, and Predis (pure PHP) — selected via a settings key. You wire it up by adding `$settings['redis.connection']` (host, port, interface, optional password/base) and pointing `$settings['cache']['default']` at `cache.backend.redis` in `settings.php`, then including the shipped `example.services.yml` to also route lock, flood and cache-tag checksums through Redis. Because it can serve the bootstrap container cache, it can be configured to work even before the module is enabled. The module itself is a lightweight "placeholder" so other modules can depend on the Redis client; it exposes almost no admin UI beyond a read-only status report at Admin → Reports → Redis. Everything deployable lives in code (settings and services YAML), which suits Git-based deployment workflows.

---

- Use Redis as the default cache backend for every cache bin.
- Route only specific bins (e.g. `render`, `dynamic_page_cache`) to Redis.
- Cache the bootstrap container definition in Redis for faster cold starts.
- Share a cache across multiple web/front-end servers in a load-balanced cluster.
- Replace the SQL-based cache to reduce database load on high-traffic sites.
- Use Redis for Drupal's lock backend to coordinate cron and long operations across servers.
- Use Redis for the persistent lock backend.
- Move flood control (login throttling) into Redis so limits are shared cluster-wide.
- Run Drupal queues on Redis with the standard queue backend.
- Run reliable (crash-safe) queues on Redis with the reliable queue backend.
- Offload cache-tag checksums to Redis via `RedisCacheTagsChecksum`.
- Connect over TCP to a local or remote Redis server (host/port).
- Connect to Redis over a UNIX socket for lower latency.
- Authenticate to a password-protected Redis instance.
- Select a specific Redis database number (base) for isolation.
- Choose between PhpRedis, Relay, or Predis clients depending on what is installed.
- Set a custom key prefix so several sites can share one Redis instance safely.
- Compress large cache entries above a configurable byte threshold to save memory.
- Apply a TTL offset so cache entries expire with a safety margin.
- Treat cache invalidations as deletes for extra memory savings.
- Provide the Redis client as a dependency for other custom or contrib modules.
- Get a raw Redis client in custom code via the `redis.factory` service.
- Monitor connection status and memory/key statistics on the Redis report page.
- Restrict who can view the Redis report with a dedicated permission.
- Deploy Redis configuration entirely through version-controlled `settings.php` and services YAML.
- Verify Redis connectivity via the status report on the site's Status report page.
