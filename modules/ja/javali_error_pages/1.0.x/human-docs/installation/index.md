# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/javali_error_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/javali_error_pages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en javali_error_pages -y
```

## Verify it worked

Visit a URL that doesn't exist on your site (to trigger a 404), or a page your
current user isn't allowed to see (to trigger a 403). Instead of Drupal's plain
default, you should see the module's custom error page. To try the maintenance
page, turn on maintenance mode at **Configuration → Development → Maintenance
mode** (`/admin/config/development/maintenance`) and load the site as an anonymous
visitor.
