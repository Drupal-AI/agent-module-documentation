<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Drush command hooks and block logic

Two classes, both extending Drush `DrushCommands`. Neither exposes user-facing commands; they only
register **hooks** against other commands.

## FirewallDrushCommands (bootstrapped)

`src/Drush/Commands/FirewallDrushCommands.php`. Uses `AutowireTrait`; constructor injects core
`\Drupal\Core\State\StateInterface $state`. Runs only for commands that bootstrap Drupal.

### Option hook

`addDisableOptionToCommands()` — `#[CLI\Hook(OPTION_HOOK, target: '*')]` +
`#[CLI\Option(name: 'disable-firewall', ...)]`. Empty body; its purpose is to add the
`--disable-firewall` option (default `FALSE`) to every command.

### Pre-command hook (enforcement)

`firewallPolicies(CommandData $commandData): ?CommandResult` — `#[CLI\Hook(PRE_COMMAND_HOOK, target: '*')]`.
Steps:

1. `$command = $commandData->annotationData()->get('command')` — the resolved command name.
2. **Bypass / fail-open guard:** `if (!$input->hasOption('disable-firewall') || $input->getOption('disable-firewall')) return NULL;`
   — i.e. if the command lacks the option OR the flag is set, all checks are skipped.
3. `isCommandDenied($command)` → `in_array($command, Settings::get('drush_firewall_denied') ?? [], TRUE)`.
   If true, return `CommandResult::dataWithExitCode('The "%s" command is disabled...', 0)`.
4. `isProductionProtected($commandData)` → true when the command **has** a `target` argument, that
   argument value contains substring `prod` (`strpos($target, 'prod') !== FALSE`), and the command
   is in `Settings::get('drush_firewall_production_denied')` (default
   `['sql:drop','sql:santitize','sql:sync','core:rsync']`). If true, blocked (exit code 0).
   *If the command has no `target` argument, this check returns FALSE (not protected).*
5. `isMaintenanceProtected($command)` → builds `array_merge(Settings::get('drush_firewall_maintenance_allowed') ?? [], $alwaysAllowed)`
   (essentials list) and returns `!in_array($command, $allowed, TRUE) && $this->state->get('system.maintenance_mode')`.
   If true, blocked (exit code 0).
6. Otherwise return `NULL` → command runs.

All block paths return **exit code 0** with an informational message (not a non-zero failure).

## NoBootstrapCommands (no bootstrap)

`Commands/drush_firewall/NoBootstrapCommands.php`, namespace `Drush\Commands\drush_firewall`.
Loaded only when the module dir is registered under `drush: include:` in `drush/drush.yml`
(see [../config/settings.md](../config/settings.md)). Covers commands that run before Drupal
bootstraps, so it cannot use `Settings`/`State`.

- `addDisableOptionToCommands()` — same `OPTION_HOOK` adding `--disable-firewall`.
- `sqlSyncValidate(CommandData $commandData)` — `#[CLI\Hook(ARGUMENT_VALIDATOR, target: SqlSyncCommands::SYNC)]`.
  Reads the `target` argument; if `strpos($target, 'prod') !== FALSE` it
  `throw new \Exception(dt('Overwriting production database is disabled.'))`, aborting `sql:sync`.
  This branch is **hardcoded** (not driven by the `$settings` arrays) and does not honor
  `--disable-firewall`.

## How "environment" is decided

Never from HTTP/request data (this is CLI-only). Three signals:
- **Target alias name** — `strpos($target, 'prod')` on the Drush `target` argument for production
  protection (both classes).
- **Maintenance mode** — `state('system.maintenance_mode')` for the maintenance policy.
- **`$settings` arrays** — the operator-authored blocklist / production list / maintenance allowlist
  from `settings.php`.
