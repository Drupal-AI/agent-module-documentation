<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings.php keys and enabling

There is **no config UI, no config entity, no config schema, no permission**. All configuration is
three optional `$settings[]` arrays read at command time with `\Drupal\Core\Site\Settings::get()`.
Put them in `settings.php` (best per-environment; globals also work).

## Install / enable

```bash
composer require drupal/drush_firewall
drush en drush_firewall -y
```

Enabling alone blocks nothing — you must set at least one policy below. Requires Drush >= 11
(composer `conflict: drush/drush <11.0`). No Drupal module dependencies.

## The three policy settings

```php
// (1) Hard blocklist — these commands never run in this environment.
$settings['drush_firewall_denied'] = [];

// (2) Production blocklist — denied only when the target alias name contains "prod".
//     If UNSET, a built-in default applies: ['sql:drop','sql:santitize','sql:sync','core:rsync'].
//     (Note the source's literal typo "sql:santitize".)
$settings['drush_firewall_production_denied'] = [];

// (3) Maintenance allowlist — while the site is in maintenance mode, ONLY these
//     commands (plus a hardcoded essential set) may run; everything else is denied.
$settings['drush_firewall_maintenance_allowed'] = [];
```

- Command names are matched with a **strict** `in_array(..., TRUE)` against the resolved Drush
  command name (e.g. `sql:sync`, not an alias like `sql-sync`).
- `?? []` / `?? [default]` fallbacks mean an unset key = empty list (except the production key,
  which falls back to the four-command default only when unset).

### Built-in maintenance essentials (always allowed in maintenance mode)

Hardcoded in `FirewallDrushCommands::isMaintenanceProtected()` and merged with your allowlist:
`cache:clear`, `cache:rebuild`, `config:import`, `config:export`, `config:status`,
`core:requirements`, `deploy:batch-process`, `deploy:hook`, `maint:get`, `maint:set`,
`maint:status`, `state:get`, `state:set`, `updatedb`.

## Bypass a policy for one run

Every command gains `--disable-firewall`; passing it turns off **all** checks for that single run:

```bash
drush sql:drop --disable-firewall
```

## Protecting commands that do not bootstrap Drupal

Bootstrapped-command policies (the pre-command hook) do not cover commands such as `sql:sync` that
run before Drupal bootstraps. To also protect those, register the module directory under
`drush: include:` in `drush/drush.yml` (path is to the module dir; adjust for your docroot):

```yaml
drush:
  include:
    - '/var/www/docroot/modules/contrib/drush_firewall'
```

This loads `NoBootstrapCommands`, whose `sqlSyncValidate()` throws
`"Overwriting production database is disabled."` when the `sql:sync` target contains `prod`. See
[../commands/firewall-hooks.md](../commands/firewall-hooks.md).
