# Installation

## Requirements

Configuration Read-only needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no other module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/config_readonly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_readonly -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_readonly -y
```

**Enabling the module does not lock anything yet.** On its own it only swaps in the
read-only-aware config storage; the lock stays *off* until you add the switch to
`settings.php`. Until then, `/admin/reports/status` shows *"Config is writable — the Config
Read-only module is enabled but not active."*

## Turn the lock on

Add this line to your site's `settings.php` (typically
`web/sites/default/settings.php`) — usually wrapped in a condition so only production is
locked:

```php
$settings['config_readonly'] = TRUE;
```

Then rebuild caches (`drush cr`). See [Configuration](../configuration/index.md) for
production-only patterns, the whitelist, and how to lift the lock again.

## Uninstalling

Because the module blocks the modules-uninstall screen while the lock is on, uninstall it
from the CLI *after* clearing the setting: remove the `$settings['config_readonly']` line,
`drush cr`, then `drush pmu config_readonly -y`.
