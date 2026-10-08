Deep-inspects the caching layer: bins, backends, cache-tag usage, and invalidation patterns.

---

Registers the `cache` analyzer (`CacheAnalyzer`, weight 3). It inspects cache bins, the configured cache backend (flagging missing external caches like Redis/Memcache), cache-tag usage in custom code, and cache-tag invalidation patterns; it also lists a bin inventory and configuration status. Each analysis area can be silenced via the four `ignore_*` config toggles (default off).

---

- Detect a missing external cache backend (no Redis/Memcache) in production.
- Flag cache bins with problematic configuration.
- Surface risky cache-tag usage and over-broad invalidations in custom code.
- List all cache bins and the current cache configuration status.
- Silence a noisy area with `ignore_bin_analysis` / `ignore_backend_analysis` / `ignore_tag_analysis` / `ignore_tag_invalidation_analysis`.
- Use as a pre-deploy gate: `drush audit:run cache --fail-on=warning`.
- Weight 3 by default in the Project Score.
- All DB introspection uses static/parameterized queries (e.g. `SHOW TABLES LIKE 'cache_%'`).
