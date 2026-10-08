<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Database cache prefix prepends a configurable string (`$settings['db_cache_prefix']`) to every cache id written to Drupal's default database cache backend.

---

The module exists for the case where several Drupal codebases share one database cache table and would otherwise collide. It overrides the core `cache.backend.database` service with its own `PrefixedDatabaseBackendFactory`, which hands out `PrefixedDatabaseBackend` objects — a subclass of core's `DatabaseBackend` that overrides only `normalizeCid()` to glue `{prefix}_` onto the front of each cache id. The prefix is read at runtime from `$settings['db_cache_prefix']` in `settings.php` (there is no admin UI, no config object, no permissions, and no dependencies beyond core). When the setting is absent the backend behaves exactly like core. The intended scenarios are shared hosting where one database serves many sites, multi-site setups pointed at a common cache table, and blue-green / rolling deployments where an old and a new codebase run against the same infrastructure and must not read each other's stale rendered output or config cache. Two things are worth knowing before relying on it. Changing the prefix effectively invalidates the whole cache (old ids are now unreachable), which is the intended clean-start behaviour on a new deployment but also a cold cache on a busy site — treat a prefix change as a deployment event, not a config tweak. And a prefix is not confidentiality: every entry still lives in the same `cache_*` table and is readable by anything with database access, so it prevents accidental collision, not deliberate cross-tenant reading. Version 2.0.0-rc3, core `^10.3 || ^11`.

---

- Separate database cache entries between Drupal sites that share one database.
- Avoid cache-id collisions on shared hosting where sites reuse a cache table.
- Scope every cache id to a specific environment (dev / staging / prod).
- Support a blue-green or rolling deployment against shared infrastructure.
- Stop one codebase from reading another codebase's cached render arrays.
- Prevent a config value cached on one site from surfacing on another.
- Prevent stale rendered output being served after a release.
- Force a deliberately cold cache by changing the prefix at deploy time.
- Isolate cache during a migration where old and new code run in parallel.
- Give each multi-site instance its own cache namespace in one table.
- Derive the prefix from the deployment id / git SHA so each release is isolated.
- Keep the standard database backend (no Redis/Memcache) while still segmenting.
- Segment cache for a per-tenant instance sharing a database.
- Ensure module-discovery cache from an old filesystem isn't reused by a new one.
- Avoid the class of bug where "whichever instance writes last wins" corrupts cache.
- Drop in transparently: with no setting configured it behaves like core.
- Enable and disable per-environment by only setting the value where needed.
- Pair with core's own `$settings['cache_prefix']` decision when weighing whether a module is needed at all.
