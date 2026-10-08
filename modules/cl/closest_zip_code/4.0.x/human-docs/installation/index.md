# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8** or newer.
- No other modules and no third‑party PHP libraries are required — the ZIP‑code
  coordinate data ships with the module as a bundled CSV.

## Install with Composer

From the project root:

```bash
composer require drupal/closest_zip_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/closest_zip_code -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en closest_zip_code -y
```

## Verify it worked

The module has no UI, so verify it from the command line. This one‑liner should
print an array with a `zips` list ordered nearest‑first:

```bash
drush ev 'print_r(\Drupal\closest_zip_code\ClosestZipCode\App::instance()->closestZipCode("00720", ["00723","00725"]));'
```

If you get back a populated result array, the module is installed and its bundled
coordinate data is loading correctly.
