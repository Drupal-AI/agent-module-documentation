CacheFlush Drush adds a Drush command to clear a CacheFlush preset's caches by id from the command line (`drush cacheflush <id>`, alias `drush cf <id>`), and to list the available presets.

---

The submodule registers a Drush command `cacheflush` (alias `cf`). Run with a numeric preset id it loads that `cacheflush` preset via `cacheflush_load()`, checks it is published (`status == 1`), and runs `CacheflushApi::create(\Drupal::getContainer())->clearPresetCache()` to clear the preset's configured caches; run with no argument it lists all published presets as `[id] : title`. The command exists in two forms in the codebase: a legacy Drush 8 `cacheflush_drush.drush.inc` (`hook_drush_command()`) and a modern `Drush\Commands` class (`CacheflushDrushCommands`, registered via `drush.services.yml`). It depends only on the base `cacheflush` module and has no permissions, config, or plugins. IMPORTANT (this environment): the modern `CacheflushDrushCommands` class redeclares `protected $logger;` without a type, which is incompatible with the installed Drush base `DrushCommands::$logger` (typed `?Psr\Log\LoggerInterface`). Enabling the module therefore makes every `drush` invocation fatal ("Type of …::$logger must be ?Psr\Log\LoggerInterface"), i.e. the module cannot be enabled on this Drush version until that class is fixed — see the agent doc.

---

- Clear a specific CacheFlush preset from the command line with `drush cf <id>`.
- List all published presets with `drush cf` (no argument).
- Script cache clears for a preset in a deployment pipeline.
- Trigger a preset clear from a CI job by id.
- Run a preset clear over SSH without opening the admin UI.
- Integrate preset-based cache clearing into a cron/crontab script.
- Clear only the caches a preset targets from a release script.
- Use the `cf` alias for quick manual preset clears during development.
- Get a preset's id from the `drush cf` listing before clearing it.
- Refuse to clear an unpublished preset from the CLI (status check).
- Combine with build tooling to clear caches after asset compilation.
- Provide non-UI operators a way to run presets.
- Clear a preset as part of a Makefile target.
- Automate targeted cache invalidation (with cacheflush_advanced presets) from the CLI.
- Run the same named preset across multiple environments from scripts.
- Document preset ids for ops runbooks via the listing command.
