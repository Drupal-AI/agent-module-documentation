<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enviromage is a developer/performance dashboard that runs a dry-run `composer update`, profiles its memory and time cost, reports the on-disk size of enabled modules, and reads selected PHP environment settings.
---
All five forms live under `/admin/config/development/enviromage` behind the `administer env settings` permission (declared `restrict access: true`). The settings form picks which PHP directives (memory_limit, max_execution_time, etc.) and which modules to inspect. `RunComposerCommandForm` builds a command like `composer update drupal/<package>:<constraint> --dry-run --profile` — the `<constraint>` is validated with Composer's `VersionParser::parseConstraints()` and `<package>` comes from a select of module machine names — persists it to the `enviromage_command` table, and executes it via `RunComposerCommand::run_composer_command()`, which calls `proc_open($command, ...)` with CWD `/var/www/html`. Results (memory average, time, install/update/remove counts) are logged to `enviromage_log`; module sizes go to `enviromage_msize`; `LogDisplayForm` renders the history.

Security posture: the composer runner is an intentional server-command execution feature (`proc_open`, a shell sink at `src/RunComposerCommand.php:248`) gated only by the admin-only `administer env settings` permission; the version constraint is validated by `VersionParser` and the package is constrained to the module select, so a non-admin cannot reach it and an admin cannot trivially inject shell metacharacters through the validated fields — but it remains a privileged command-execution surface to treat with care (grant the permission only to trusted operators). The `--dry-run` flag means it simulates rather than applies changes. The task hint that this module "handles image files" is incorrect — it does not. Setup: enable (depends on `automatic_updates`), grant the permission narrowly, and use the dashboard to evaluate update impact.
---
- Estimate the memory and time cost of a `composer update` before running it for real.
- Run the composer check as a dry-run so nothing is actually installed.
- Profile install/update/remove counts for lock-file and package operations.
- Report the on-disk size of each selected enabled module.
- Sum the total disk footprint of chosen modules.
- Read current PHP settings (memory_limit, max_execution_time, upload_max_filesize, etc.).
- Choose which PHP directives to display on the settings form.
- Target a specific module/package for the update simulation.
- Specify a version constraint (validated by Composer's VersionParser).
- Persist the last customized command for re-running.
- Log each performance check with the running user and timestamp.
- Browse historical performance-check records in the log display.
- Store per-module size measurements in the database.
- Assess upgrade impact before a maintenance window.
- Restrict all functionality to `administer env settings` (restrict access) holders.
- Grant the command-execution permission only to trusted operators.
- Audit the `proc_open` composer sink before exposing the module.
- Compare environment configuration across servers.
- Identify oversized modules bloating the codebase.
- Combine with automatic_updates for update planning.
- Confirm the dry-run flag is present so no changes are applied.
- Export selected settings/module lists via `enviromage.settings` config.
