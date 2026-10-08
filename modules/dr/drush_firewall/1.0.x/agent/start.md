<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Firewall (drush_firewall) — agent index

A **Drush-command-only** guardrail: it blocks/restricts which Drush commands may run per
environment, on production targets, or during maintenance mode. **No HTTP routes, no controllers,
no permissions, no config entities/schema, no admin UI, no hooks.** Configured entirely via
`$settings[]` in `settings.php`. Package `Administration`. Core `^10.2 || ^11`. License
GPL-2.0-or-later. Version 1.0.0. Composer `conflict: drush/drush <11.0`; no runtime deps.

- **The three policies, the `$settings` keys, defaults, `--disable-firewall`, drush.yml include** →
  [config/settings.md](config/settings.md)
- **The two Drush command classes and exactly how each hook decides to block** →
  [commands/firewall-hooks.md](commands/firewall-hooks.md)

## What it actually is (from source)

- `src/Drush/Commands/FirewallDrushCommands.php` — class `FirewallDrushCommands` (extends Drush
  `DrushCommands`, `AutowireTrait`, injects core `state`). Runs only for **bootstrapped** commands.
  - `#[CLI\Hook(OPTION_HOOK, target: '*')] addDisableOptionToCommands()` — adds `--disable-firewall`
    to every command (empty body; declares the option).
  - `#[CLI\Hook(PRE_COMMAND_HOOK, target: '*')] firewallPolicies(CommandData $commandData)` — the
    enforcement hook; returns `null` to allow or a `CommandResult` (exit code **0**) to block.
- `Commands/drush_firewall/NoBootstrapCommands.php` — class `NoBootstrapCommands` (namespace
  `Drush\Commands\drush_firewall`). Runs **without** Drupal bootstrap, only when the module dir is
  listed under `drush: include:` in `drush/drush.yml`. Provides the same `--disable-firewall`
  option hook plus `#[CLI\Hook(ARGUMENT_VALIDATOR, target: SqlSyncCommands::SYNC)] sqlSyncValidate()`
  which throws if the `sql:sync` target contains `prod`.

## How a command is classified (summary)

Order in `firewallPolicies()`: (1) `isCommandDenied()` — command in
`Settings::get('drush_firewall_denied')`; (2) `isProductionProtected()` — command has a `target`
argument whose value contains substring `prod` AND command is in
`Settings::get('drush_firewall_production_denied')` (default `sql:drop`, `sql:santitize`,
`sql:sync`, `core:rsync`); (3) `isMaintenanceProtected()` — `state('system.maintenance_mode')` is
on AND command is NOT in `Settings::get('drush_firewall_maintenance_allowed')` merged with a
hardcoded essential allowlist. `--disable-firewall` skips all checks. Environment is decided by the
Drush **target alias name** (string match), the **maintenance-mode state flag**, and the **three
`$settings` arrays** — never by request/HTTP input. See
[commands/firewall-hooks.md](commands/firewall-hooks.md) for the exact conditionals.
