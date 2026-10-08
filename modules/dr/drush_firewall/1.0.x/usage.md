<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush Firewall is a Drush-only guardrail module that blocks or restricts which Drush commands may run in a given environment, on production targets, or while the site is in maintenance mode.

---

The module ships no routes, permissions, config entities, or admin UI — it is configured entirely through `$settings[]` entries in `settings.php` (ideally per-environment settings files) and enforced by Drush command hooks. `FirewallDrushCommands` (`src/Drush/Commands/FirewallDrushCommands.php`) registers a `PRE_COMMAND_HOOK` on every command (`target: '*'`) that runs three checks in order: (1) an unconditional blocklist `$settings['drush_firewall_denied']`; (2) production protection — if the command has a `target` argument whose value contains the substring `prod` and the command is in `$settings['drush_firewall_production_denied']` (defaulting to `sql:drop`, `sql:santitize`, `sql:sync`, `core:rsync`); (3) maintenance protection — while `system.maintenance_mode` state is on, only commands in `$settings['drush_firewall_maintenance_allowed']` plus a built-in essential set (cache clear/rebuild, config import/export/status, deploy hooks, `updatedb`, maint/state get/set, etc.) are allowed and everything else is blocked. When a policy blocks a command the hook returns a `CommandResult` with a message and exit code 0 rather than executing it. Every command also gains a `--disable-firewall` option (an `OPTION_HOOK` on `target: '*'`); passing it skips all checks for that run. Because some Drush commands (e.g. `sql:sync`) do not bootstrap Drupal, a second class `NoBootstrapCommands` (`Commands/drush_firewall/NoBootstrapCommands.php`) provides an `ARGUMENT_VALIDATOR` on `SqlSyncCommands::SYNC` that throws when the target contains `prod`; it only takes effect if the module directory is registered under `drush: include:` in `drush/drush.yml`. This is a defensive ops tool aimed at operator mistakes; it is not an authentication or access-control boundary.

---

- Prevent a destructive command (e.g. a custom `db:wipe`) from ever running in a specific environment by adding it to `$settings['drush_firewall_denied']`.
- Block `sql:drop`, `sql:sanitize`, `sql:sync`, and `core:rsync` from targeting a production alias while leaving them available for staging/dev.
- Stop `sql:sync` from overwriting the production database when the target alias name contains `prod`.
- Keep stray or automated Drush commands from firing during a deployment while the site is in maintenance mode.
- Allow only an explicit set of deploy commands (e.g. `updatedb`, `config:import`, `deploy:hook`) to run during maintenance and deny the rest.
- Guard against Drupal core cron still executing commands while the site is in maintenance mode.
- Ship "never run this on production" rules alongside the environment definition by placing them in a per-environment `settings.php`.
- Apply the same guardrails globally by putting the settings in the shared `settings.php`.
- Temporarily override a block for a single run with `--disable-firewall` when you genuinely need to run a blocked command.
- Standardize destructive-command protection across a team so individual operators cannot accidentally run them.
- Protect CI/CD pipelines from running unexpected Drush commands against the wrong alias.
- Add production protection to commands that accept a target alias argument (e.g. rsync/sql-sync style commands).
- Extend the maintenance allowlist with project-specific commands that must run during a deploy window.
- Combine an unconditional blocklist with maintenance and production policies for layered command protection.
- Register the module in `drush/drush.yml` so non-bootstrapping commands like `sql:sync` are also protected.
- Use it as a lightweight alternative to writing custom Drush hooks for command gating.
- Document environment-specific command policy declaratively in settings rather than in tribal knowledge.
- Prevent accidental database drops/sanitizes on shared or production databases.
- Reduce risk of running data-destructive Drush commands during incident response.
- Enforce that cache and config commands remain available during maintenance while other commands are blocked.
