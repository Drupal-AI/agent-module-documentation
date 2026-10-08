# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.1 or newer** (`php: >=7.1.0`).
- No required contrib modules. For the update checks (`drush nagios-updates` and
  the update-related status output) core's **Update** module needs to be
  enabled.
- Optional: the PHP **posix** extension (`ext-posix`) is suggested, used to
  detect the OS user running checks.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nagios -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nagios -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nagios -y
```

Enabling the module does **not** open the status page — it starts out disabled.
Go to [Configuration](../configuration/index.md) to enable and secure it.

## Permissions

Nagios Monitoring adds one permission of its own and reuses a core one:

- **Administer nagios ignore** (`administer nagios ignore`) — access to the
  "Ignored modules" form.
- The main settings form and administrative access to the status page use core's
  **Administer site configuration** (`administer site configuration`).

Grant these at **People → Permissions** to trusted administrators only.

This module ships no submodules.
