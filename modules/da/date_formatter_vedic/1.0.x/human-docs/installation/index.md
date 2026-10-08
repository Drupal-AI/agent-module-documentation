# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.1 or later**.
- No module, Composer, or third‑party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/date_formatter_vedic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_formatter_vedic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_formatter_vedic -y
```

## Verify it worked

After enabling, go to **Configuration → Regional and language → Vedic Date
Formatter** (`/admin/config/regional/vedic-date-formatter`) — the settings form
should load. The muhūrta character (default `q`) is then usable in any date format
string. To confirm, add it to a date format and render a date; you should see the
muhūrta name in the output. See [Configuration](../configuration/index.md) to
change the character or the muhūrta names.
