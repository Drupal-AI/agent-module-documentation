# Installation

## Requirements

- **Drupal 8.8+, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The contributed **Redirect** module (`redirect`), which Composer pulls in and
  which does the actual redirecting.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bundle_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bundle_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bundle_redirect -y
```

Drupal enables the Redirect dependency at the same time. After enabling, grant the
module's permission to the appropriate roles, then set redirect destinations per
bundle as described on the [overview page](../index.md).
