# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

The module has no dependencies beyond Drupal core and no third-party Composer or
PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autologout_alterable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/autologout_alterable -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autologout_alterable -y
```

There are no submodules.

## After enabling

The module is active out of the box with a 30-minute (1800-second) inactivity
timeout. Review the [Configuration](../configuration/index.md) page to adjust the
timeout, turn on the warning dialog, set role- or user-specific timeouts, and
grant the relevant permissions. If you want expired sessions cleaned up even when
a browser tab is closed, make sure Drupal **cron** runs regularly — the module
uses a cron queue worker for server-side expiry.
