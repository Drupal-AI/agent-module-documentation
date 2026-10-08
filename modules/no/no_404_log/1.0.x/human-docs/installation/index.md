# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **PHP 7.4 or newer.**
- No dependencies beyond Drupal core — it uses core's built-in PSR-3 logging
  services and needs no additional libraries or modules.

Modules that pair well with it (but are not required): **Syslog**, **Monolog**,
and core's **Database Logging (DBLog)**.

## Install with Composer

From the project root:

```bash
composer require drupal/no_404_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/no_404_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en no_404_log -y
```

## Verify it worked

Visit the settings page at `/admin/config/development/no_404_log` to confirm the
module is active, pick a mode, and save. Then request a URL that does not exist
and check your log (for example **Reports → Recent log messages**): with
suppression active, the 404 should no longer appear there.
