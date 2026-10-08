# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Config Ignore** (`drupal/config_ignore` `^3.0`) — this module extends it.
  Composer installs it automatically as a dependency.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_ignore_auto -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Config Ignore and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_ignore_auto -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_ignore_auto -y
```

Enabling Config Ignore Auto does **not** start it tracking changes — it stays
inactive until you switch its status on. See [Configuration](../configuration/index.md)
for how to activate it (recommended: only in production, via `settings.php`).
