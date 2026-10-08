# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, and no PHP library or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/betterselect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/betterselect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en betterselect -y
```

Once enabled, select the Better Select widget for a multi-value field under
**Manage form display** (see the [main guide](../index.md)). There is no
required configuration page.
