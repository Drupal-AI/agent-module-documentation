# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement:
  ^8||^9||^10||^11||^12`).
- No other modules — it has no dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajax_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_link -y
```

Once enabled, apply the AJAX-loading behavior to the links you want (see the
project page). There is no site-wide configuration form.
