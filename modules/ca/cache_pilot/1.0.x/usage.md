Cache Pilot clears and inspects the PHP APCu and Zend OPcache opcode/user caches from Drupal by talking to PHP-FPM over a FastCGI socket.

---

APCu and OPcache live inside the PHP-FPM worker processes, so a Drush (CLI) run in a separate PHP process cannot reset them — the classic cause of stale opcode/user cache after a deploy. Cache Pilot solves this by opening a FastCGI connection (TCP or Unix domain socket, configured as a DSN) to the running FPM pool and executing a small bundled script (`cache-pilot.php`) inside it, which calls `apcu_clear_cache()`, `opcache_reset()`, `apcu_cache_info()` / `apcu_sma_info()`, and `opcache_get_status()`. It ships a settings form for the DSN, an admin reports dashboard that renders APCu and OPcache statistics as tables plus fragmentation bars, two Drush/console commands for deployment scripts, and a `hook_cache_flush()` implementation that clears APCu whenever Drupal rebuilds its caches. Every route and action is gated by the `cache_pilot.administer` permission.

---

- Clear the APCu (user/opcode) cache running in PHP-FPM without restarting the pool.
- Clear the Zend OPcache (compiled bytecode) cache running in PHP-FPM after a code deploy.
- Reset opcode caches from a deployment script so newly deployed PHP files take effect immediately.
- Run `drush cache-pilot:opcache:clear` in a CI/CD pipeline before `drush deploy` to avoid stale code.
- Run `drush cache-pilot:apcu:clear` to flush stale user-cache entries during releases.
- Configure the FastCGI target as TCP (e.g. `tcp://127.0.0.1:9000`, `tcp://php:9000`) for containerized stacks.
- Configure the FastCGI target as a Unix domain socket (e.g. `unix:///var/run/php/php-fpm.sock`) for socket-based setups.
- View live APCu statistics (hits, misses, hit/miss/insert rate, memory usage, cached variables) on a report page.
- View live Zend OPcache statistics (enabled, cache full, memory used/wasted/free, interned strings, cached scripts, restarts, hit rate).
- Spot cache-full or fragmentation problems visually via the used/wasted/free fragmentation bars.
- Confirm whether APCu or OPcache is actually enabled in the FPM pool before relying on it.
- Automatically flush APCu whenever an admin or Drush triggers a full Drupal cache rebuild (`drush cr`).
- Clear caches from the UI via "Clear APCu cache" and "Clear Zend Opcache" buttons on the settings form.
- Verify the FastCGI connection health from the site status report (Reports > Status report) via `hook_requirements`.
- Programmatically clear caches from custom code using the `ApcuCache` / `OpcacheCache` services.
- Check connection status programmatically with the `Client::isConnected()` service method.
- Disable Cache Pilot in specific environments by overriding `cache_pilot.settings:connection_dsn` to `NULL` in `settings.php`.
- Restrict who can manage or view cache internals via the single `cache_pilot.administer` permission.
- Provide site operators a single admin dashboard for opcode-cache health across environments.
- Integrate opcode-cache clearing into blue/green or rolling deployments where FPM stays running.
