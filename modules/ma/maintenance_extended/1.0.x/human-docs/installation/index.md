# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contributed modules — it extends Drupal core's maintenance page.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_extended -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance_extended -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_extended -y
```

## Verify it worked

Go to **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`). You should now see a new **Title**
field and a rich-text (formatted) **Message** field where core previously offered
only a plain message box. See [Configuration](../configuration/index.md) to use
them.

> **Note:** This module is an early (alpha) release and is minimally maintained.
> Test it on a non-production environment first.
