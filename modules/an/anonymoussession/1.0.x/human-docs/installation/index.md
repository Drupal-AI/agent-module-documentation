# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies. It builds on core's session management.

## Install with Composer

From the project root:

```bash
composer require drupal/anonymoussession -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/anonymoussession -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anonymoussession -y
```

Typically you enable it because another custom module depends on it. Once enabled,
its session service is available to your code. Remember that using it disables the
anonymous page cache on the affected requests.
