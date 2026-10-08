Migrate Booster speeds up Drupal migrations by selectively disabling module hooks (e.g. pathauto, xmlsitemap, workbench_moderation) while `drush migrate:import` / `migrate:rollback` run, so expensive side-effect hooks don't fire per row.

---

The module decorates core's `module_handler` service (`MigrateBoostModuleHandler`, decoration priority 10) and, when "boost" is active, filters out configured hook implementations from `hasImplementations()`, `invokeAllWith()`, `invoke()`, `invokeAll()`, and the deprecated variants. You declare what to skip in the `migrate_boost.settings` config object (usually via `settings.php` overrides): `hooks` maps a hook name to the list of modules whose implementation of that hook should be suppressed, and `modules` lists modules whose hooks are suppressed entirely. Boost is off during normal web requests — a kernel `REQUEST` subscriber (`HooksEnablerSubscriber`) calls `MigrateBoost::bootDrupal()` to force-disable it on every HTTP request — and is only switched on inside Drush: the module's Drush integration (`MigrateBoostCommands`) hooks `pre-command` on `migrate:import` and `migrate:rollback` to call `MigrateBoost::enable()`, which sets a static flag and resets the module handler's implementation cache. Extra commands `migrate:booster:enable` (`mbe`) and `migrate:booster:reset` (`mbr`) are provided. This is a CLI/migration performance tool with no UI, no permissions, and no config schema; it is Drupal 11.1+ only and requires Drush 13. Based on prior D7 hook-disabling work (thinktandem/migrate_booster).

---

- Skip pathauto alias generation during a large content migration, then bulk-generate after.
- Suppress xmlsitemap link updates while importing thousands of nodes.
- Disable workbench_moderation `entity_insert` side effects during migration.
- Prevent search_api indexing hooks from firing per migrated row.
- Turn off flag `entity_predelete` hooks during a rollback.
- Speed up `drush migrate:import` by removing expensive presave/insert hooks.
- Disable all hooks of a specific module during migration via the `modules` list.
- Disable only a specific hook of a specific module via the `hooks` map.
- Keep hooks fully active for normal web traffic (boost auto-disabled per request).
- Configure suppression entirely from `settings.php` without changing stored config.
- Run `drush migrate:booster:enable` (mbe) to activate boost for a custom CLI flow.
- Run `drush migrate:booster:reset` (mbr) to reset the implementation cache mid-run.
- Avoid firing notification/mail hooks while backfilling entities.
- Reduce migration memory/time by cutting per-row alter chains.
- Temporarily bypass third-party entity hooks that conflict with migrate.
- Batch-import commerce/products without triggering per-save recalculation hooks.
- Prevent cache-tag invalidation storms from per-row hook side effects.
- Selectively keep critical hooks while dropping cosmetic ones during import.
- Re-run migrations faster in CI by disabling non-essential hooks.
- Pair with post-migration Drush commands to regenerate aliases/sitemaps once.
