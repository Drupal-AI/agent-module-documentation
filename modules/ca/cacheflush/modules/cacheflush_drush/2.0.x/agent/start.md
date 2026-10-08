# CacheFlush Drush — agent index

Adds a Drush command to clear a CacheFlush **preset** by id from the CLI. Depends on `cacheflush`.
No permissions, config, or plugins.

Core facts:
- Command `cacheflush`, **alias `cf`**. `drush cf <id>` clears the published preset with that id;
  `drush cf` (no arg) lists published presets as `[id] : title`.
- It loads the preset (`cacheflush_load($id)`), verifies `status == 1`, and runs
  `CacheflushApi::clearPresetCache()`.

**Compatibility warning (this environment):** the modern command class `CacheflushDrushCommands`
redeclares `protected $logger;` untyped, incompatible with the installed Drush base
`DrushCommands::$logger` (`?Psr\Log\LoggerInterface`). **Enabling this submodule makes ALL `drush`
commands fatal** ("Type of …::$logger must be ?Psr\Log\LoggerInterface"). It is left uninstalled on
this site for that reason; the command cannot run until the class is fixed.

Docs:
- **The command, its arguments/alias, both implementations, and the incompatibility** →
  [drush/commands.md](drush/commands.md)
