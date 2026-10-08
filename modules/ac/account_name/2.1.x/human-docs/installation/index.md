# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- No other modules and no third-party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/account_name -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/account_name -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en account_name -y
```

The account menu link starts showing the user's name and picture immediately. The
module provides a permission of its own, so if you want to control who gets the
personalized link, review it at **People → Permissions**
(`/admin/people/permissions`).
