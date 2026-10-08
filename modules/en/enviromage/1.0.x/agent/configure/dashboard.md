<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enviromage dashboard

## Permission
All routes require `administer env settings` (declared `restrict access: true`). This is the only gate on the composer-execution feature — grant it only to trusted operators.

## Settings (`enviromage.admin_settings`)
`EnvConfigSettingsForm` stores in `enviromage.settings`:
- `settings_list` — which PHP directives to read (memory_limit, max_execution_time, realpath_cache_size/ttl, upload_max_filesize, post_max_size).
- `modules_list` — which modules to size.

## Composer check (`enviromage.run_composer`)
- `RunComposerCommandForm::submitForm()` builds `composer update drupal/<package>:<constraint> --dry-run --profile`.
  - `<constraint>` is validated by `Composer\Semver\VersionParser::parseConstraints()` (invalid → falls back to a package-only or plain update command).
  - `<package>` comes from a `#select` of module machine names.
  - The command string is saved to table `enviromage_command`.
- `runComposerCommand()` (AJAX) reads the latest stored command and calls `RunComposerCommand::get_update_info_about_enabled_modules()` → `run_composer_command()`.
- `run_composer_command()` executes via `proc_open($command, $descriptors, $pipes, '/var/www/html')` and returns stderr (composer writes progress there). Results are logged to `enviromage_log`.

### Agent security note (report, do not silently rewrite)
`proc_open` with a shell command string is a server command-execution sink (`src/RunComposerCommand.php:248`). It is admin-only and the two user inputs are constrained (VersionParser-validated constraint, select-bound package), so it is not reachable anonymously and not trivially injectable — but treat it as a privileged RCE-adjacent surface. The `--dry-run` flag keeps it non-mutating.

## Module sizes (`enviromage.get_modules_size`)
`GetModulesSize::getModulesSize()` recursively `scandir`/`filesize`s each configured module directory; results are stored in `enviromage_msize`.

## Environment read (`enviromage.get_env_conf`) and log (`enviromage.log_display`)
`GetEnvConf` returns the selected PHP settings; `LogDisplayForm` renders the `enviromage_log` history (user, memory avg, time, operation counts).
