Replaces Drupal's entity memory cache with a bounded least-recently-used (LRU) cache to cap memory use during long-running or high-volume entity processing.

---

Entity LRU Cache decorates core's `entity.memory_cache` service with an `Adapter` that can route entity memory caching through an `LruMemoryCache` (a subclass of core's `MemoryCache`) holding a fixed number of slots. When all slots are full, the least-recently-used entity is evicted instead of the cache growing without bound, which prevents processes that load huge numbers of entities — migrations, bulk updates, queue workers, Drush scripts — from exhausting PHP memory. Behavior is controlled by two container parameters: `lru_memory_cache_slots` (default 300) sets the slot count, and `lru_mode` (default `cli`) chooses when the LRU cache is active — `cli` (CLI processes only), `on` (always), or `off` (never, use core's default). It is a pure performance/memory-tuning layer: no UI, routes, permissions, or config entities, and it works on Drupal 10.3+ and 11.

---

- Cap memory growth of long-running Drush commands that iterate over many entities.
- Keep migrations (Migrate API, `migrate_tools`) from accumulating every loaded entity in memory.
- Bound memory in queue workers that process large batches of entities.
- Prevent out-of-memory failures in bulk content operations (VBO, batch updates).
- Tune the entity static/memory cache size site-wide via `lru_memory_cache_slots`.
- Enable LRU eviction only for CLI runs while leaving web requests on core's default cache (default `cli` mode).
- Turn the LRU cache on for all requests by setting `lru_mode: on`.
- Disable the module's behavior without uninstalling by setting `lru_mode: off`.
- Reduce peak memory of cron jobs that touch large numbers of entities.
- Stabilize memory in scripted one-off data backfills or re-saves.
- Avoid tweaking PHP `memory_limit` upward just to survive batch entity loads.
- Trade a small cache hit-rate reduction for predictable, bounded memory.
- Keep entity re-import or content-sync jobs within a fixed memory envelope.
- Serve as a drop-in decorator without changing calling code (implements `MemoryCacheInterface`).
- Evict the oldest untouched entities first while recently accessed entities stay cached.
- Override the slot count per environment through `settings.php` container parameters.
- Provide a bounded static cache for very large sites where the default unbounded memory cache is a risk.
- Support developers experimenting with the core issue (#3498154) proposing this behavior for core.
- Reduce memory pressure in headless/decoupled backends serving many entity API requests when `lru_mode: on`.
- Complement existing performance caching without touching persistent cache backends.
