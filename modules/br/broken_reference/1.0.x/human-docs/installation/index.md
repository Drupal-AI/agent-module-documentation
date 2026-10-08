# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/broken_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/broken_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en broken_reference -y
```

After enabling, grant the module's audit permission (under **People → Permissions**)
to the roles that should be able to run the broken‑reference detection.
